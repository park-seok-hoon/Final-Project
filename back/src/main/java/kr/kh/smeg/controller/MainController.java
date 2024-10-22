package kr.kh.smeg.controller;

import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.NoticeVO;
import kr.kh.smeg.service.MainService;
import lombok.extern.log4j.Log4j;


//여긴 기능없이 페이지 주소만 처리할 컨트롤러
@Log4j
@Controller
public class MainController {
	
	@Autowired
	MainService mainService;

	//메인페이지 - 공지사항리스트는 4개 가져와야 함
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		//공지사항 리스트가져와야 함
		ArrayList<NoticeVO> noticelist = mainService.getNoticelist();
		
		//Jsoup을 통해 태그를 제거하는 코드 : pom.xml에서 의존성 확인할것!
		for(NoticeVO notice : noticelist) {
			if(notice.getNo_content() != null && notice.getNo_content() != "") {
				Document content = Jsoup.parse(notice.getNo_content());
				String noticeContent = content.text();
				
				//이미지만 갖고 오고 싶다면
				/* Elements elements = content.getElementsByTag("img");
				 * if(elements.size() != 0) {
				 * 	  elements = elements.get(0); //이미지가 여러개일 경우 첫번째 이미지 가져옴
				 * }
				 */
				
				if(noticeContent.length() > 200) {
					noticeContent = noticeContent.substring(0, 200);
				}
				notice.setNo_content(noticeContent);
			}
		}
		
		model.addAttribute("noticelist", noticelist);
		
		return "/main/index";
	}
	
	//header 메뉴처리
	@GetMapping("/common/header")
	public String header(Model model) {
		ArrayList<GroupVO> grouplist = mainService.getGrouplist();
		
		model.addAttribute("grouplist", grouplist);
		
		return "common/header_view";
	}
	
	
	//연혁
	@GetMapping("/smeg/history")
	public String history(Model model) {
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 연혁 - 3차프로젝트");
		return "/smeg/history";
	}

	//스토리
	@GetMapping("/smeg/story")
	public String story(Model model){
		model.addAttribute("title", "SMEG - 스토리 - 3차프로젝트");
		return "/smeg/story";
	}
	
	//수상내역
	@GetMapping("/smeg/award")
	public String award(Model model) {
		model.addAttribute("title", "SMEG - 수상내역 - 3차프로젝트");
		return "/smeg/award";
	}
	
	// 매장안내
	@GetMapping("/service/store")
	public String store(Model model) {
		model.addAttribute("title", "SMEG - 매장안내 - 3차프로젝트");
		return "/service/store";
	}
}
