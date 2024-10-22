package kr.kh.smeg.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.smeg.model.vo.BasketVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.model.vo.ProductVO;
import kr.kh.smeg.pagination.Criteria;
import kr.kh.smeg.pagination.PageMaker;
import kr.kh.smeg.service.MemberService;
import kr.kh.smeg.service.MypageService;
import kr.kh.smeg.service.ProductService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MypageController {
	@Autowired
	MypageService mypageService;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	MemberService memberService;
	
	//개인정보 수정 - 비번확인
	@GetMapping("/mypage/personal_info")
	public String list(Model model, HttpSession session) {
		//세션에서 user정보를 가져와서 저장. - 카카오 로그인 확인용
		MemberVO user = (MemberVO) session.getAttribute("user");
		model.addAttribute("user", user); //user라는 이름으로 전송
		
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 개인정보수정 - 3차프로젝트");
		return "/mypage/personal_info";
	}
	
	//개인정보 수정 - 비번확인 - POST
	@PostMapping("/mypage/personal_info")
	public String listPost(Model model, HttpSession session, String me_pw) {
		//세션에서 user정보를 가져와서 저장.
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		model.addAttribute("user", user); //user라는 이름으로 전송
		
		//새롭게 비번을 입력한 유저를 찾음
		MemberVO loginuser = memberService.getuserinfo(user, me_pw);

		if(loginuser != null) {
			session.setAttribute("a", "asd");
			//"a", "asd" 등과 같은 확인할 수 있는 임의의 값을 session에 저장
			//앞에 a가 String name, asd가 object value.
			model.addAttribute("url","/mypage/personal_info_update");
			model.addAttribute("msg", "회원정보 수정페이지로 이동합니다.");
		}
		else {
			model.addAttribute("url","/mypage/personal_info");
			model.addAttribute("msg","비밀번호가 틀립니다. 비밀번호를 다시 입력해주세요.");
		}
		return "message";
	}
	
	
	//개인정보수정
	@GetMapping("/mypage/personal_info_update")
	public String update(Model model) {	
		model.addAttribute("title", "SMEG - 개인정보수정 - 3차프로젝트");
		return "/mypage/personal_info_update";
	}
	
	//개인정보수정 POST 
	//이름, 성별, 생년월일, 아이디, 비밀번호, 비밀번호 확인, 휴대폰 번호
	//이메일, 주소
	@PostMapping("/mypage/personal_info_update")
	public String updatePost(Model model, MemberVO member, HttpSession session) {	
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = memberService.updateMember(member,user);
		if(res) {
			model.addAttribute("msg","회원 정보를 수정했습니다.");
			model.addAttribute("url","/mypage/personal_info");
			session.setAttribute("user", member);
		}else {
			model.addAttribute("msg","회원 정보를 수정하지 못했습니다.");
			model.addAttribute("url","/mypage/personal_info_update");
		}
		
		return "message";
	}
	
	
	//주문내역
	@GetMapping("/mypage/order")
	public String order(Model model, HttpSession session, Criteria cri) {
		//회원정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		//주문번호 개수 반환
		int ordercount = mypageService.getOrderCountById(user.getMe_id(),cri);
		
		//주문정보 가져오기
		ArrayList<OrderVO> orderlist = mypageService.getOrderById(user.getMe_id(),cri);
		
		PageMaker pm = new PageMaker(5, cri, ordercount);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "SMEG - 주문내역 - 3차프로젝트");
		model.addAttribute("ordercount", ordercount);
		model.addAttribute("orderlist", orderlist);
		
		
		return "/mypage/order";
	}
	
	//장바구니
	@GetMapping("/mypage/shopping_list")
	public String shoppinglist(Model model, HttpSession session) {
		//회원정보 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");
		
		//장바구니 리스트 가져오기
		ArrayList<BasketVO> basketlist = mypageService.getBasketById(user.getMe_id());
		
		model.addAttribute("title", "SMEG - 장바구니 - 3차프로젝트");
		model.addAttribute("basketlist", basketlist);
		
		return "/mypage/shopping_list";
	}
	
	//장바구니 - 한개삭제
	@GetMapping("/mypage/basket/delete/one")
	public String shoppinglistDelete1(Model model, @RequestParam("ba_num") String ba_num) {
		boolean res= mypageService.deleteBasketByNum(ba_num);
		
		if(res) {
			model.addAttribute("msg", "해당 장바구니를 삭제했습니다.");
			model.addAttribute("url", "/mypage/shopping_list");
		}
		else {
			model.addAttribute("msg", "해당 장바구니 삭제에 실패했습니다.");
			model.addAttribute("url", "/mypage/shopping_list");
		}
		
		return "message";
	}
	
	//장바구니 - 한개바로구매
	@GetMapping("/mypage/basket/order/one")
	public String shoppinglistOrder1(
			Model model, 
			@RequestParam("pr_code") String pr_code, 
			@RequestParam("ba_amount") String ba_amount, 
			@RequestParam("ba_num") String ba_num, 
			HttpSession session
	) {
	    // 상품 가져오기
	    ProductVO product = productService.getProductCode(pr_code);
	    if (product == null) {
	        model.addAttribute("msg", "해당 상품을 찾을 수 없습니다.");
	        model.addAttribute("url", "/mypage/shopping_list");
	        return "message";
	    }
	    
	    // 세션에 있는 회원 정보를 가져오기
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    if (user == null) {
	        model.addAttribute("msg", "로그인이 필요합니다.");
	        model.addAttribute("url", "/member/login");
	        return "message";
	    }
	    
	    int amount;
	    try {
	        amount = Integer.parseInt(ba_amount);
	    } catch (NumberFormatException e) {
	        model.addAttribute("msg", "잘못된 수량 정보입니다.");
	        model.addAttribute("url", "/mypage/shopping_list");
	        return "message";
	    }

	    boolean res1 = productService.insertOrder(user.getMe_id(), product.getPr_price() * amount);
	    if (!res1) {
	        model.addAttribute("msg", "주문 생성에 실패하였습니다.");
	        model.addAttribute("url", "/mypage/shopping_list");
	        return "message";
	    }

	    OrderVO order = productService.getOrderById(user.getMe_id());
	    if (order == null) {
	        model.addAttribute("msg", "주문 정보를 가져오는 데 실패하였습니다.");
	        model.addAttribute("url", "/mypage/shopping_list");
	        return "message";
	    }

	    int or_num = order.getOr_num();
	    boolean res2 = productService.insertOrderlist(or_num, pr_code, ba_amount);
	    if (!res2) {
	        model.addAttribute("msg", "주문 목록 추가에 실패하였습니다.");
	        model.addAttribute("url", "/mypage/shopping_list");
	        return "message";
	    }

	    // 장바구니에서 제거
	    boolean res3 = mypageService.deleteBasketByNum(ba_num);
	    if (!res3) {
	        model.addAttribute("msg", "장바구니 항목 제거에 실패하였습니다.");
	        model.addAttribute("url", "/mypage/shopping_list");
	        return "message";
	    }

	    model.addAttribute("msg", "주문을 완료했습니다.");
	    model.addAttribute("url", "/mypage/shopping_list");
	    return "message";
	}
	
	//장바구니 - 선택 삭제기능
	@ResponseBody
	@PostMapping("/mypage/basket/delete/all")
	public boolean basketDelete(@RequestParam("arr[]") ArrayList<Integer> arr) { 
		if(arr == null) {
			return false;
		}else {
			boolean res = mypageService.deleteBaskets(arr);

			return res;
		}
	}
		
	//장바구니 - 선택 주문기능
	@ResponseBody
	@PostMapping("/mypage/basket/order/all")
	public boolean orderAll(
		@RequestParam("arr1[]") ArrayList<Integer> ba_nums, 
		@RequestParam("arr2[]") ArrayList<String> pr_codes,
		@RequestParam("arr3[]") ArrayList<Integer> ba_amounts,
		@RequestParam("total") int totalPrice,
		HttpSession session
	) { 
		if(ba_nums == null || pr_codes == null || ba_amounts == null) {
			return false;
		}else {
			// 세션에 있는 회원 정보를 가져오기
		    MemberVO user = (MemberVO) session.getAttribute("user");
		    
		    //주문만들기 - 주문은 하개
		    boolean res1 = productService.insertOrder(user.getMe_id(), totalPrice);
		    
		    OrderVO order = productService.getOrderById(user.getMe_id());
		    
		    int or_num = order.getOr_num();
		    
		    //주문리스트 여러개 만들기
		    boolean res2 = mypageService.insertOrderlistAll(or_num, pr_codes, ba_amounts);
		    
		    //장바구니에서 모두 제거
		    boolean res3 = mypageService.deleteBaskets(ba_nums);

			return res1 && res2;
		}
	}
	
	//회원탈퇴 - GET
	@GetMapping("/mypage/user_drop")
	public String userdrop(Model model) {
		//유저정보 안보내도 인터셉터에 있음
		model.addAttribute("title", "SMEG - 회원탈퇴 - 3차프로젝트");
		return "/mypage/user_drop";
	}
	
	//회원탈퇴 - POST
	@PostMapping("/mypage/user_drop")
	public String userdropPost(Model model, HttpSession session) {
		// 세션에 있는 회원 정보를 가져오기
	    MemberVO user = (MemberVO) session.getAttribute("user");
		
		//회원정보 제거
		//order테이블에서 외래키 or_me_id를 CASCADE처리해야 알아서 같이 삭제
		//basket테이블에서 외래키 ba_me_id를 CASCADE처리해야 알아서 같이 삭제
		//orderlist테이블에서 외래키 or_num를 CASCADE처리해야 알아서 같이 삭제
	    boolean res = mypageService.deleteMemberById(user.getMe_id());
	    //회원 정보에 쿠키를 null로 변경 후에
  		user.setMe_cookie(null);
  		user.setMe_cookie_limit(null);
  		//memberService.updateMemberCookie(user);를 호출해주면 됨 
  		//세션에서 로그인 정보만 지운다면 쿠키가 남아있어 해당 쿠키 기간까지 계속해서 쿠키를 체크해서 로그아웃이 되지 않음으로
  		//쿠키에 null값을 넣어서 쿠키를 비워줘야만 함.
  		memberService.updateMemberCookie(user);
  		session.removeAttribute("user");
	    
	    if(!res) {
	        model.addAttribute("msg", "회원탈퇴에 실패하였습니다.");
	        model.addAttribute("url", "/mypage/user_drop");
	        return "message";
	    }

	    model.addAttribute("msg", "회원탈퇴했습니다. SMEG는 회원님을 위해 서비스 품질을 더 높이겠습니다.");
	    model.addAttribute("url", "/");
	    
	    return "message";
	}
	
	//탈퇴를 위한 비밀번호 체크
	@ResponseBody
	@GetMapping("/mypage/pw/check/dup")
	public Map<String, Object> pwCheckDup(@RequestParam("pw") String pw, HttpSession session){
		Map<String,Object> map = new HashMap<String,Object>();
		// 세션에 있는 회원 정보를 가져오기
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    
		boolean res = mypageService.pwCheck(user.getMe_pw(), pw); //비밀번호체크를 위한 service로 보냄
		map.put("result", res); //result라는 이름을 가진 중복체크를 마친 변수 값을 넣음
		
		return map;
	}
}
