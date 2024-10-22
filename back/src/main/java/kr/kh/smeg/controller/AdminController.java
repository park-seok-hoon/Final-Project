package kr.kh.smeg.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import com.mysql.cj.log.Log;
import kr.kh.smeg.service.ProductService;

import kr.kh.smeg.model.vo.CategoryVO;
import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.model.vo.OrderStateVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.model.vo.ProductVO;
import kr.kh.smeg.pagination.Criteria;
import kr.kh.smeg.pagination.PageMaker;
import kr.kh.smeg.service.AdminService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class AdminController {
	
	@Autowired ProductService productService;
	@Autowired AdminService adminService;
	
	//관리자페이지 - 회원리스트
	@GetMapping("/admin/user_list")
	public String list(Model model, Criteria cri) {
		//회원리스트 가져오기 - ADMIN만 빼고 가져오기
		ArrayList<MemberVO> memberlist = adminService.getMemberList(cri);
		
		//날짜 문자인데, 10글자로 변경 처리
		for(MemberVO member : memberlist) {
			member.setMe_birth(member.getMe_birth().substring(0, 10));
		}
		
		int memberCount = adminService.getMemberTotalCount(cri);
		PageMaker pm = new PageMaker(5, cri, memberCount);
		model.addAttribute("pm", pm);
		
		model.addAttribute("memberlist", memberlist);
		model.addAttribute("memberCount", memberCount);
		model.addAttribute("title", "SMEG - 회원리스트 보기/강퇴 - 3차프로젝트");
		return "/admin/user_list";
	}
	
	//회원강퇴기능
	@ResponseBody
	@PostMapping("/admin/user/drop")
	public boolean adminUserDrop(@RequestParam("arr[]") ArrayList<String> arr) { 
		if(arr == null) {
			return false;
		}else {
			boolean res = adminService.deleteMemberByChk(arr);
			//삭제 성공 시 메세지?
			return res;
		}
	}
	
	//관리자페이지 - 카테고리관리
	@GetMapping("/admin/category")
	public String category(Model model) {
		//그룹리스트 가져오기
		ArrayList<GroupVO> grouplist = adminService.getGroupList();	
		
		model.addAttribute("grouplist", grouplist);
		
		
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 카테고리관리 - 3차프로젝트");
		return "/admin/category";
	}
	
	//관리자페이지 - 카테고리관리 - 수정
	@PostMapping("/admin/categoryUpdate")
	public String categoryUpdate(Model model, CategoryVO category, MultipartFile category_file_update, String past_ca_pic_ori_name) {
		boolean res= adminService.updateCategory(category, category_file_update, past_ca_pic_ori_name);
		
		if(res) {
			model.addAttribute("msg", "수정이 완료되었습니다.");
			model.addAttribute("url", "/admin/category");
		}
		else {
			model.addAttribute("msg", "수정에 실패하였습니다.");
			model.addAttribute("url", "/admin/category");
		}
		
		return "message";
	}
	
	//관리자페이지 - 카테고리관리 - 등록
	@PostMapping("/admin/categoryInsert")
	public String categoryInsert(Model model, CategoryVO category, MultipartFile category_file_insert) {
		
		boolean res= adminService.insertCategory(category, category_file_insert);
		
		if(res) {
			model.addAttribute("msg", "등록이 완료되었습니다.");
			model.addAttribute("url", "/admin/category");
		}
		else {
			model.addAttribute("msg", "등록에 실패하였습니다.");
			model.addAttribute("url", "/admin/category");
		}
		
		return "message";
	}
	
	@GetMapping("/category/delete")
	public String boardDelete(Model model, int caNum) {
		//서비스에게 게시글 번호와 회원 정보를 주면서 삭제하라고 요청
		boolean res = adminService.deleteCategory(caNum);
		//삭제 성공시 성공 처리
		if(res) {
			model.addAttribute("url", "/admin/category");
			model.addAttribute("msg", "카테고리를 삭제했습니다.");
		}
		//삭제 실패시 실패 처리
		else {
			model.addAttribute("url", "/admin/category");
			model.addAttribute("msg", "카테고리를 삭제하지 못했습니다.");
		}
		
		return "message";
	}
	
	//관리자페이지 - 상품등록 - GET
	@GetMapping("/admin/insert")
	public String productInsert(Model model) {
		//그룹 리스트를 DB에서 가져오고 model.addattribute로 화면에 전송
		ArrayList<GroupVO> list = productService.getGrouplist();
		model.addAttribute("list",list);
		model.addAttribute("title", "SMEG - 상품등록 - 3차프로젝트");
		
		//그룹 리스트를 DB에서 가져와서 선택상자에 처리
		ArrayList<GroupVO> grouplist = adminService.getGroupList();
		model.addAttribute("grouplist", grouplist);
		
		return "/admin/insert";
	}
	
	//카테고리리스트를 가져오기 위한 비동기 처리
	@ResponseBody
	@GetMapping("/admin/categoryList")
	public Map<String, Object> getCategory(@RequestParam("obj") String gr_num){
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		ArrayList<CategoryVO> categorylist= adminService.getCategoriesByGroupNum(gr_num);
		
		map.put("categorylist", categorylist);
		
		return map;
		
	}
	
	//카테고리리스트를 가져오기 위한 비동기 처리
	//Post방식이 필요해서 2로 처리
	@ResponseBody
	@PostMapping("/admin/categoryList2")
	public Map<String, Object> getCategory2(@RequestParam("obj") String gr_num){
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		ArrayList<CategoryVO> categorylist= adminService.getCategoriesByGroupNum(gr_num);
		
		//해당 글자 중 <br>태그를 \n => 대신 인식못해서 특수문자로 처리
		for(CategoryVO category : categorylist) {
			category.setCa_explain(category.getCa_explain().replace("<br>", "&#10"));
		}
		
		map.put("categorylist", categorylist);
		
		return map;
		
	}
	
	//상품코드 중복확인 처리
	@ResponseBody
	@GetMapping("/admin/code/check/dup")
	public Map<String, Object> idCheckDup(@RequestParam("code") String code){
		Map<String,Object> map = new HashMap<String,Object>();
		boolean res = adminService.codeCheck(code); //아이디 중복체크를 위한 service로 보냄
		map.put("result", res); //result라는 이름을 가진 중복체크를 마친 변수 값을 넣음
		
		return map;
	}
	
	//관리자페이지 - 상품등록 POST
	@PostMapping("/admin/insert")
	public String productInsertPost(Model model, ProductVO product, MultipartFile slide_pictures[], MultipartFile file_detail) {
		
		if(product.getPr_ps_state()==null)	//상품 상태가 품절일 경우 체크여서 값이 "품절" 체크를 해제하면 null값이 들어가는데 DB에 저장은 "판매중"으로 해줘야 되기 때문에
			product.setPr_ps_state("판매중");
		//상품 등록
		//boolean res=productService.InsertProduct(product,slide_pictures,file_detail);	//파일 3개, 상세 파일
		boolean res= adminService.insertProduct(product,slide_pictures,file_detail);	//파일 3개, 상세 파일
		
		if(res) {
			model.addAttribute("msg", "등록이 완료되었습니다.");
			model.addAttribute("url", "/admin/insert");
		}
		else {
			model.addAttribute("msg", "등록에 실패하였습니다.");
			model.addAttribute("url", "/admin/insert");
		}
		
		
		return "message";
	}
	
	//관리자페이지 - 상품리스트보기 - 업데이트하기 위해
	@GetMapping("/admin/update_list")
	public String updatelist(Model model, Criteria cri) {
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 상품수정 - 3차프로젝트");
		
		//그룹의 정보를 리스트로 가져온다.
		ArrayList<GroupVO> grouplist = adminService.getGroupList();
		
		//그룹의 정보를 화면에 보내준다.
		model.addAttribute("grouplist",grouplist);
		
		//상품 리스트를 DB에서 가져와서 선택상자에 처리
		ArrayList<ProductVO> productlist  = adminService.getProductList(cri);
		int totalCount = adminService.getProductTotalCount(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("productlist", productlist);
		model.addAttribute("pm", pm);
		
		return "/admin/update_list";
	}
	
	//SMEG - 상품등록 - 3차프로젝트
	@GetMapping("/admin/update")
	public String update(Model model, @RequestParam("prCode") String pr_code, @RequestParam("grName") String gr_name, @RequestParam("caName") String ca_name) {
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 상품등록 - 3차프로젝트");
		
		//받아온 파라미터를 통해 ProductVO생성
		ProductVO product = adminService.getProductByPrCode(pr_code);
		model.addAttribute("product", product);
		
		//그룹 리스트를 DB에서 가져와서 선택상자에 처리
		ArrayList<GroupVO> grouplist = adminService.getGroupList();
		model.addAttribute("grouplist", grouplist);
		
		//주소파라미터에서 받아온 값을 화면에 전달
		model.addAttribute("gr_name", gr_name);
		model.addAttribute("ca_name", ca_name);
		
		return "/admin/update";
	}
	
	//상품 수정 폼전송처리
	@PostMapping("/admin/update")
	public String updatePost(Model model, ProductVO product, MultipartFile slide_pictures[], MultipartFile file_detail, String[] slide_pictures_value, String file_detail_value) {
		if(product.getPr_ps_state()==null)	//상품 상태가 품절일 경우 체크여서 값이 "품절" 체크를 해제하면 null값이 들어가는데 DB에 저장은 "판매중"으로 해줘야 되기 때문에
			product.setPr_ps_state("판매중");
		
		boolean res = adminService.updateProduct(product, slide_pictures, file_detail, slide_pictures_value, file_detail_value);
		
		if(res) {
			model.addAttribute("msg", "수정에 성공하였습니다.");
			model.addAttribute("url", "/admin/update_list");
		}else {
			model.addAttribute("msg", "수정에 실패하였습니다.");
			model.addAttribute("url", "/admin/update");
		}
		
		return "message";
	}
	
	
	//SMEG - 상품삭제
	@GetMapping("/admin/delete")
	public String delete(Model model, Criteria cri) {
		//홈페이지 제목
		model.addAttribute("title", "SMEG - 상품삭제 - 3차프로젝트");
		
		//그룹의 정보를 리스트로 가져온다.
		ArrayList<GroupVO> grouplist = adminService.getGroupList();
		
		//그룹의 정보를 화면에 보내준다.
		model.addAttribute("grouplist",grouplist);
		
		//상품 리스트를 DB에서 가져와서 선택상자에 처리
		ArrayList<ProductVO> productlist  = adminService.getProductList(cri);
		int totalCount = adminService.getProductTotalCount(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("productlist", productlist);
		model.addAttribute("pm", pm);
		model.addAttribute("totalCount", totalCount);
		
		return "/admin/delete";
	}
	
	//체크박스를 통한 비동기 삭제
	@ResponseBody
	@PostMapping("/admin/delete")
	public boolean productDelete(@RequestParam("arr[]") ArrayList<String> arr) { 
		if(arr == null) 
			return false;

		boolean res = adminService.deleteProduct(arr);
		
		//삭제 성공 시 메세지
		return res;
	}
	
	
	//SMEG - 고객주문내역 - 3차프로젝트
	@GetMapping("/admin/order_list")
	public String orderlist(Model model, Criteria cri) {
		
		//주문번호 개수 반환 - 이번엔 모든 주문처리
		int ordercount = adminService.getOrderCount(cri);
		
		//모든 주문정보 가져오기
		ArrayList<OrderVO> orderlist = adminService.getOrder(cri);
		
		//주문상태 가져오기
		ArrayList<OrderStateVO> orderstatelist = adminService.getOrderState();
		
		PageMaker pm = new PageMaker(5, cri, ordercount);
		model.addAttribute("pm", pm);
		model.addAttribute("ordercount", ordercount);
		model.addAttribute("orderlist", orderlist);
		model.addAttribute("orderstatelist", orderstatelist);
		model.addAttribute("title", "SMEG - 고객주문내역 - 3차프로젝트");
		
		return "/admin/order_list";
	}
	
	//주문 변경 기능
	@ResponseBody
	@PostMapping("/admin/order/state/update")
	public boolean faqDelete(@RequestParam("os_state[]") ArrayList<String> os_states, @RequestParam("or_num[]") ArrayList<Integer> or_nums) { 
		if(os_states == null || or_nums == null) {
			return false;
		}else {
			boolean res = adminService.orderStateUpdate(os_states, or_nums);
			//삭제 성공 시 메세지?
			return res;
		}
	}

}