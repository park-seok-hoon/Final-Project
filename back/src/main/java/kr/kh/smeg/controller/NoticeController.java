package kr.kh.smeg.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.model.vo.NoticeCategoryVO;
import kr.kh.smeg.model.vo.NoticeVO;
import kr.kh.smeg.pagination.Criteria;
import kr.kh.smeg.pagination.PageMaker;
import kr.kh.smeg.service.NoticeService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class NoticeController {
	@Autowired
	NoticeService noticeService;
	
	//리스트목록보기
	@GetMapping("/notice/list")
	public String list(Model model, Criteria cri, HttpSession session) {
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 공지사항 - 3차프로젝트");

		ArrayList<NoticeVO> list = noticeService.getNoticeList(cri);
		int totalCount = noticeService.getNoticeTotalCount(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("list", list);
		model.addAttribute("pm", pm);
		
		//사용자 정보
		MemberVO user = (MemberVO)session.getAttribute("user");
		model.addAttribute("user",user);
		
		return "/notice/list";
	}
	//디테일페이지
	@GetMapping("/notice/detail")
	public String detail(Model model, int noNum, Criteria cri) {
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 공지사항 상세 - 3차프로젝트");
		
		//조회수 증가
		noticeService.updateView(noNum);
		//게시글을 가져옴
		NoticeVO notice = noticeService.getNotice(noNum);
		
		//이전글, 다음글 가져와야 함
		//다음글
		NoticeVO noticeNext = noticeService.getNoticeNext(noNum);
		//이전글
		NoticeVO noticePrev = noticeService.getNoticePrev(noNum);
		
		//첨부파일은 썸머노트를 썼기 때문에 가져올 필요는 없음
		
		//화면에 게시글, 첨부파일, 검색 정보를 전송
		model.addAttribute("notice", notice);
		model.addAttribute("noticeNext", noticeNext);
		model.addAttribute("noticePrev", noticePrev);
		model.addAttribute("cri", cri);
		
		return "/notice/detail";
	}
	
	//입력창 - GET
	@GetMapping("/notice/insert")
	public String insert(Model model) {
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 공지사항 입력 - 3차프로젝트");
		
		//공지사항카테고리 목록 불러오기
		ArrayList<NoticeCategoryVO> categorylist = noticeService.getNoticeCategoryList();
		
		//카테고리 리스트 화면으로 보냄
		model.addAttribute("categorylist", categorylist);
		
		return "/notice/insert";
	}
	
	//입력창 - POST
	@PostMapping("/notice/insert")
	public String insertNotice(Model model, NoticeVO notice, HttpServletRequest request, String[] file, String[] originalFile) {
		
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		if(noticeService.insertNotice(notice, user, file, originalFile)) {
			log.info(file);
			model.addAttribute("msg", "공지사항을 등록했습니다.");
			model.addAttribute("url", "/notice/list");
		}else {
			model.addAttribute("msg", "공지사항을 등록하지 못했습니다.");
			model.addAttribute("url", "/notice/insert");
		}
		
		return "message";
	}
	
	//썸머노트 이미지 업로드
	@ResponseBody
	@PostMapping("/img/upload")
	public Map<String, Object> imgUpload(MultipartFile file){
		HashMap<String, Object> map = new HashMap<String, Object>();
		String uploadPath = noticeService.uploadImg(file);
		map.put("url", uploadPath);
		return map;
	}
	
	//썸머노트 이미지 삭제
	@ResponseBody
	@PostMapping("/img/delete")
	public Map<String, Object> imgDelete(String file){
		HashMap<String, Object> map = new HashMap<String, Object>();
		noticeService.deleteImg(file);
		map.put("res", "삭제");
		return map;
	}
	
	
	//삭제(기능)-페이지는 없음
	//공지사항 삭제기능
	@ResponseBody
	@PostMapping("/notice/delete")//또는 @PostMapping("경로")
	public boolean noticeDelete(@RequestParam("arr[]") ArrayList<Integer> arr) { 
		if(arr == null ) {
			return false;
		}else {
			boolean res = noticeService.deleteNotice(arr);
			//삭제 성공 시 메세지?
			return res;
		}
	}
}
