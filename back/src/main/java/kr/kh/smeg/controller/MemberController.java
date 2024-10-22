package kr.kh.smeg.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.smeg.model.dto.FindIdDTO;
import kr.kh.smeg.model.dto.LoginDTO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.service.MemberService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller 
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	
	//로그인 GET : 페이지 불러들어올때
	@GetMapping("/topnav/login")
	public String login(Model model, HttpServletRequest request) {
		//아이디저장관련
		//1. userId를 저장할 변수
		String userId = "";
		
		//2. 쿠키생성 : Cookie란? - 웹 서버가 클라이언트에게 저장하는 작은 데이터 조각. (이름 = 값) 이 쌍으로 구성됨. 속성으로 (이름, 값, 만료일, 도메인, 경로, 보안, HTTP전용) 등을 가짐
		Cookie[] cookies = request.getCookies();
		
		//3. 여러 쿠키값에서 remember라는 쿠키를 확인
		for(Cookie cookie : cookies) {
			if(cookie.getName().equals("remember")) { //만약 쿠키이름이 remember라면
				userId = cookie.getValue();
			}
		}
		
		request.setAttribute("remember", userId);
		
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 로그인 - 3차프로젝트");
		return "/topnav/login";
	}
	
	//로그인 POST : 데이터전송시
	@PostMapping("/topnav/login")
	public String loginPost(Model model,LoginDTO loginDTO, String remember, HttpServletResponse response) {
		
		MemberVO user = memberService.login(loginDTO);
		model.addAttribute("user", user);
		if(user!=null) {
			//자동로그인
			user.setAutoLogin(loginDTO.isAutoLogin());
			
			//로그인에 성공했을 때 아이디 저장이 체크관련 명령처리
			//remember가 없다면 빈문자열 처리
			if(remember == null) {
	            remember = "";
	        }
			
			//remember가 on과 같다면
			if(remember.equals("on")) {
	            Cookie cookie = new Cookie("remember", user.getMe_id()); //아이디값 찾아서 저장
	            response.addCookie(cookie);
	        }else{
	            Cookie cookie = new Cookie("remember", ""); //아니면 빈문자열 처리
	            response.addCookie(cookie);
	        }
			
			
			model.addAttribute("msg","로그인에 성공하였습니다.");
			model.addAttribute("url","/");
		}else {
			model.addAttribute("msg","로그인에 실패하였습니다.");
			model.addAttribute("url", "/topnav/login");
		}
		
		return "message";
	}
	
	//로그아웃 
	@GetMapping("/topnav/logout")
	public String logout(HttpSession session, Model model, HttpServletRequest request) {
		//세션에 있는 회원 정보를 가져오고
		MemberVO user=(MemberVO) session.getAttribute("user");
		//회원 정보에 쿠키를 null로 변경 후에
		user.setMe_cookie(null);
		user.setMe_cookie_limit(null);
		//memberService.updateMemberCookie(user);를 호출해주면 됨 
		//세션에서 로그인 정보만 지운다면 쿠키가 남아있어 해당 쿠키 기간까지 계속해서 쿠키를 체크해서 로그아웃이 되지 않음으로
		//쿠키에 null값을 넣어서 쿠키를 비워줘야만 함.
		memberService.updateMemberCookie(user);
		session.removeAttribute("user");
		model.addAttribute("msg","로그아웃 되었습니다.");
		model.addAttribute("url","/");
		return "message";
	}
	
	//회원가입 GET
	@GetMapping("/topnav/signup")
	public String signup(Model model) {
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 회원가입 - 3차프로젝트");
		return "/topnav/signup";
	}
	
	//회원가입 POST
	@PostMapping("/topnav/signup")
	public String signupPost(Model model,MemberVO member) {
		if(memberService.signup(member)) {
			model.addAttribute("msg","회원가입을 완료했습니다.");
			model.addAttribute("url", "/");
		}
		else {
			model.addAttribute("msg", "회원가입에 실패하였습니다.");
			model.addAttribute("url", "/topnav/signup");
		}
		
		return "message";
	}
	
	//아이디 중복 체크
	@ResponseBody
	@GetMapping("/topnav/id/check/dup")
	public Map<String, Object> idCheckDup(@RequestParam("id") String id){
		Map<String,Object> map = new HashMap<String,Object>();
		boolean res = memberService.idCheck(id); //아이디 중복체크를 위한 service로 보냄
		map.put("result", res); //result라는 이름을 가진 중복체크를 마친 변수 값을 넣음
		
		return map;
	}
	
	//아이디찾기
	@GetMapping("/topnav/id_search")
	public String id_search(Model model) {
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 아이디 찾기 - 3차프로젝트");
		return "/topnav/id_search";
	}
	
	
	//아이디 찾기 POST
	@PostMapping("/topnav/id_search")
	public String id_searchPost(Model model,FindIdDTO findid, HttpSession session) {
		if (findid.getMe_name() == null || findid.getMe_email() == null) {
	        model.addAttribute("msg", "이름과 이메일을 모두 입력해 주세요.");
	        model.addAttribute("url", "/topnav/id_search");
	        return "message";
	    }
		
		MemberVO user = memberService.findID(findid);
		log.info(user);

		if(user!=null) {
			session.setAttribute("id", user.getMe_id());
			model.addAttribute("url", "/topnav/id_search_result");
		}else {
			model.addAttribute("msg","존재하지 않는 아이디입니다.");
			model.addAttribute("url", "/topnav/id_search");
		}
		
		return "message";
		
	}
	
	
	//아이디찾기결과 - GET
	@GetMapping("/topnav/id_search_result")
	public String id_search_resultGet(Model model, HttpSession session) {
		
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 아이디 찾기 결과 - 3차프로젝트");
		
		String id = (String) session.getAttribute("id");
		
		model.addAttribute("id", id);
		
		return "/topnav/id_search_result";

	}
	
	//아이디찾기결과 POST - 로그인이 되도록 처리
	@PostMapping("/topnav/id_search_result")
	public String id_search_resultPost(Model model,LoginDTO loginDTO, HttpSession session) {
		
		MemberVO user = memberService.login(loginDTO);
		model.addAttribute("user", user);
		
		if(user!=null) {
			model.addAttribute("msg","로그인에 성공하였습니다.");
			model.addAttribute("url","/");
		}else {
			model.addAttribute("msg","로그인에 실패하였습니다.");
			model.addAttribute("url", "/topnav/id_search_result");
		}
		
		return "message";
	}
	
	
	//비밀번호찾기 - GET
	@GetMapping("/topnav/pw_search")
	public String pw_search(Model model) {
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 비밀번호 찾기 - 3차프로젝트");
		return "/topnav/pw_search";
	}
	
	//비밀번호찾기 - POST
	@ResponseBody
	@PostMapping("/topnav/pw_search")
	public Map<String, Object> findPwPost(@RequestParam("id") String id, @RequestParam("email") String email){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = memberService.findPw(id, email);
		map.put("result", res);
		return map;
	}
	
	
}
