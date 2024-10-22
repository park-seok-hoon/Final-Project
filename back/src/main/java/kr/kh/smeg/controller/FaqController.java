package kr.kh.smeg.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.smeg.model.vo.FaqVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.pagination.Criteria;
import kr.kh.smeg.pagination.PageMaker;
import kr.kh.smeg.service.FaqService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class FaqController {
	
	@Autowired
	FaqService faqService;
	
	//리스트목록보기
	@GetMapping("/faq/list")
	public String faqList(Model model, Criteria cri, HttpSession session) {
		ArrayList<FaqVO> list = faqService.getFaqList(cri);
		int totalCount = faqService.getTotalCount(cri);
		PageMaker pm = new PageMaker(5,cri,totalCount);
		model.addAttribute("pm",pm);
		model.addAttribute("title", "SMEG - faq - 3차프로젝트");
		model.addAttribute("list",list);
		
		//사용자 정보
		MemberVO user = (MemberVO)session.getAttribute("user");
		model.addAttribute("user",user);
		
		return "/faq/list";
	}
	
	//faq 삭제기능
	@ResponseBody
	@PostMapping("/faq/delete")//또는 @PostMapping("경로")
	public boolean faqDelete(@RequestParam("arr[]") ArrayList<Integer> arr) { 
		if(arr == null) {
			return false;
		}else {
			boolean res = faqService.deleteFaq(arr);
			//삭제 성공 시 메세지?
			return res;
		}
	}

	//입력창
	@GetMapping("/faq/insert")
	public String faqInsert(Model model) {
		model.addAttribute("title", "SMEG - faq등록 - 3차프로젝트");
		return "/faq/insert";
	}
	
	//faq입력창 - POST
	@PostMapping("/faq/insert")
	public String faqInsertPost(Model model, FaqVO faq, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(faqService.insert(faq,user)) {
			model.addAttribute("msg","faq 등록을 완료했습니다.");
			model.addAttribute("url","/faq/list");
		}else {
			model.addAttribute("msg","faq 등록에 실패했습니다.");
			model.addAttribute("url","/faq/insert");
		}
		return "message";
	
	}
}
