package kr.kh.smeg.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.smeg.model.vo.FileVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.model.vo.NoticeCategoryVO;
import kr.kh.smeg.model.vo.NoticeVO;
import kr.kh.smeg.pagination.Criteria;

public interface NoticeService {

	ArrayList<NoticeCategoryVO> getNoticeCategoryList();

	boolean insertNotice(NoticeVO notice, MemberVO user, String[] file, String[] originalFile);

	String uploadImg(MultipartFile file);

	void deleteImg(String file);

	ArrayList<NoticeVO> getNoticeList(Criteria cri);

	int getNoticeTotalCount(Criteria cri);

	boolean deleteNotice(ArrayList<Integer> arr);

	void updateView(int noNum);

	NoticeVO getNotice(int noNum);

	ArrayList<FileVO> getFileList(int noNum);

	NoticeVO getNoticeNext(int noNum);

	NoticeVO getNoticePrev(int noNum);

}
