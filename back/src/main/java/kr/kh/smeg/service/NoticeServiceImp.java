package kr.kh.smeg.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.smeg.dao.NoticeDAO;
import kr.kh.smeg.model.vo.FileVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.model.vo.NoticeCategoryVO;
import kr.kh.smeg.model.vo.NoticeVO;
import kr.kh.smeg.pagination.Criteria;
import kr.kh.smeg.utils.UploadFileUtils;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NoticeServiceImp implements NoticeService {
	@Autowired
	NoticeDAO noticeDao;
	
	@Resource
	private String uploadPath;
	
	private boolean checkString(String str) {
		return str != null && str.length() != 0;
	}
	
	private void uploadFile(int no_num, String file, String originalFile) {
		
		try {
			String originalFileName = originalFile;
			//파일명이 없으면
			if(originalFileName.length() == 0) {
				return;
			}
			//FileVO 개체를 생성
			FileVO fileVo = new FileVO(no_num, file, originalFileName);
			//DB에 추가
			noticeDao.insertFile(fileVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void deleteFile(FileVO file) {
		if(file == null) {
			return;
		}
		//서버에서 삭제
		UploadFileUtils.deleteFile(uploadPath, file.getFi_name());
		System.out.println(uploadPath);
		System.out.println(file.getFi_name());
		//DB에서 삭제
		noticeDao.deleteFile(file.getFi_num());
	}

	@Override
	public ArrayList<NoticeCategoryVO> getNoticeCategoryList() {
		
		return noticeDao.selectNoticeCategoryList();
	}

	@Override
	public boolean insertNotice(NoticeVO notice, MemberVO user, String[] files, String[] originalFiles) {
		if(user == null || notice == null) {
			return false;
		}
		if(!checkString(notice.getNo_title()) || !checkString(notice.getNo_content())) {
			return false;
		}
		if(notice.getNo_nc_num() < 0 && notice.getNo_num() > 4) { //카테고리 번호 1~4가 아니면
			return false;
		}
		notice.setNo_me_id(user.getMe_id());
		boolean res = noticeDao.insertNotice(notice);
		//게시글 등록 실패 => 첨부파일 올릴 필요 없음
		if(!res) {
			return false;
		}
		//첨부파일 업로드 작업
		//첨부파일 없는 경우
		if(files == null || files.length == 0) {
			return true;
		}
		for (int i = 0; i < files.length; i++) {
	        String file = files[i];
	        String originalFile = originalFiles[i];
	        //첨부파일을 서버에 업로드하고, DB에 추가
	        uploadFile(notice.getNo_num(), file, originalFile);
	    }
		
		return true;
	}

	@Override
	public String uploadImg(MultipartFile file) {
		if(file == null || file.getOriginalFilename().length() == 0)
			return null;
		
		try {
			return UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public void deleteImg(String file) {
		UploadFileUtils.deleteFile(uploadPath, file);
	}

	//공지사항 리스트처리
	@Override
	public ArrayList<NoticeVO> getNoticeList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1,5);
		}
		return noticeDao.selectNoticeList(cri);
	}

	@Override
	public int getNoticeTotalCount(Criteria cri) {
		if(cri == null) {
			cri = new Criteria(1,5);
		}
		return noticeDao.selectNoticeTotalCount(cri);
	}

	@Override
	public boolean deleteNotice(ArrayList<Integer> arr) {
		if(arr == null) {
			return false;
		}
		
		boolean res = true;
		for(int no_num : arr) {
			//첨부파일 관련 삭제하려면 workbench에서 외래키 옵션 CASCADE로 변경해야 함
			//서버의 첨부파일 삭제 및 DB에서 제거
			//게시글 번호에 맞는 첨부파일 리스트를 가져옴
			ArrayList<FileVO> fileList = noticeDao.selectFileList(no_num);
			//첨부파일 리스트가 있으면 반복문으로 첨부파일을 삭제
			if(fileList != null) {
				for(FileVO file : fileList) {
					deleteFile(file);
				}
			}
			
			//삭제가 실패하면, 브라우저 두 개 notice 2개...
			//나중에 이 기능은 adminInterceptor 추가해서 관리자만 가능하게 수정할 예정
			if(!noticeDao.deleteNotice(no_num)) {
				res = false;
			}
		}
		return res;
	}

	@Override
	public void updateView(int noNum) {
		noticeDao.updateView(noNum);
	}

	@Override
	public NoticeVO getNotice(int noNum) {
		return noticeDao.selectNotice(noNum);
	}

	@Override
	public ArrayList<FileVO> getFileList(int noNum) {
		return noticeDao.selectFileList(noNum);
	}

	@Override
	public NoticeVO getNoticeNext(int noNum) {
		return noticeDao.selectNoticeNext(noNum);
	}

	@Override
	public NoticeVO getNoticePrev(int noNum) {
		return noticeDao.selectNoticePrev(noNum);
	}
}
