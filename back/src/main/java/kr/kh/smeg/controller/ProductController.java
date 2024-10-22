package kr.kh.smeg.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.smeg.model.vo.CategoryVO;
import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.model.vo.ProductVO;
import kr.kh.smeg.pagination.Criteria;
import kr.kh.smeg.pagination.PageMaker;
import kr.kh.smeg.pagination.ProductCriteria;
import kr.kh.smeg.service.ProductService;
import lombok.extern.log4j.Log4j;
@Log4j
@Controller
public class ProductController {
	@Autowired
	ProductService productService;
	
	//상품리스트 페이지
	//@PathVariable을 사용하여  ex url :  (/smeg/product/list/2/3) 위와 같은 식으로 상품 리스트 화면 출력 시 gr_num / ca_num으로 구분하여 리스트 화면 페이지 진행하였습니다.
	@GetMapping("/product/list/{gr}/{ca}")
	public String list(Model model, @PathVariable("gr") int gr_num, @PathVariable("ca")int ca_num, ProductCriteria cri) {
		
		//카테고리 불러오기
		CategoryVO category = productService.getCategoryByCaNum(ca_num);
		
		//그룹리스트 불러오기
		GroupVO group = productService.getGroupByCaGrNum(category.getCa_gr_num());
		
		//그룹에서 가장 작은 카테고리 번호를 갖은 것 조회 : 인디케이터 가운데 경로 처리 위해 사용
		CategoryVO minCategory = productService.getCategoryByGroupMin(category.getCa_gr_num());
		
		String caName = category.getCa_name();
		
		//선택상자를 위한 그룹 리스트처리
		ArrayList<GroupVO> grouplist = productService.getGrouplist();
		
		//상품리스트가져오기
		// 상품리스트 모음
		cri.setType(ca_num+"");//검색 타입대신 카테고리 번호를 저장
		ArrayList<ProductVO> list = productService.getproductList(cri);
		
		// 페이지네이션 관련 모음
		int totalCount = productService.getTotalCount(cri);
		PageMaker pm = new PageMaker(5,cri,totalCount);
		
		//홈페이지 제목
		model.addAttribute("title", "SMEG - " + caName + "- 3차프로젝트");
		model.addAttribute("category", category);
		model.addAttribute("group", group);
		model.addAttribute("minCategory", minCategory);
		model.addAttribute("grouplist", grouplist);
		model.addAttribute("productList",list);
		model.addAttribute("pm",pm);
		
		return "/product/list";
	}
	
	//카테고리리스트를 가져오기 위한 비동기 처리
	@ResponseBody
	@GetMapping("/product/categoryList")
	public Map<String, Object> getCategory(@RequestParam("obj") String gr_num){
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		ArrayList<CategoryVO> categorylist= productService.getCategoriesByGroupNum(gr_num);
		map.put("categorylist", categorylist);
		
		return map;
		
	}
	
	
	// 상품 디테일 페이지
	@GetMapping("/product/detail")
	public String detail(Model model,@RequestParam("pr_code")String pr_code, HttpSession session) {
		//상품 가져옴 가져옴
		ProductVO product = productService.getProductCode(pr_code);
		
		String prName = product.getPr_name();
		
		// 화면에 제목, 코드, 검색 정보를 전송
		model.addAttribute("product", product);
		
		//세션에 있는 회원 정보를 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");
		model.addAttribute("user", user);
		
		model.addAttribute("title", "SMEG - " + prName + " 상세페이지 - 3차프로젝트");

		return "/product/detail";
	}
	
	// 상품 디테일 페이지 - 장바구니버튼클릭시 url
	@GetMapping("/product/basket")
	public String detailBasket(Model model, @RequestParam("pr_code")String pr_code, @RequestParam("ba_amount")String ba_amount,HttpSession session) {
		
		//상품 가져옴 가져옴
		ProductVO product = productService.getProductCode(pr_code);
		
		//세션에 있는 회원 정보를 가져오기
		MemberVO user = (MemberVO) session.getAttribute("user");
		model.addAttribute("user", user);
		
		boolean res= productService.insertBasket(ba_amount, user.getMe_id(), pr_code);
		
		if(res) {
			model.addAttribute("msg", "장바구니에 등록되었습니다.");
			model.addAttribute("url", "/product/detail?pr_code=" + pr_code);
		}
		else {
			model.addAttribute("msg", "장바구니 등록에 실패하였습니다.");
			model.addAttribute("url", "/product/detail?pr_code=" + pr_code);
		}
		
		return "message";
	}
	
	// 상품 디테일 페이지 - 바로구매버튼클릭시 url
	@GetMapping("/product/purchase")
	public String detailPurchase(Model model, @RequestParam("pr_code")String pr_code, @RequestParam("ba_amount")String ba_amount,HttpSession session) {
		
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
	        model.addAttribute("url", "/product/detail?pr_code=" + pr_code);
	        return "message";
	    }

	    boolean res1 = productService.insertOrder(user.getMe_id(), product.getPr_price() * amount);
	    if (!res1) {
	        model.addAttribute("msg", "주문 생성에 실패하였습니다.");
	        model.addAttribute("url", "/product/detail?pr_code=" + pr_code);
	        return "message";
	    }

	    OrderVO order = productService.getOrderById(user.getMe_id());
	    if (order == null) {
	        model.addAttribute("msg", "주문 정보를 가져오는 데 실패하였습니다.");
	        model.addAttribute("url", "/product/detail?pr_code=" + pr_code);
	        return "message";
	    }

	    int or_num = order.getOr_num();
	    boolean res2 = productService.insertOrderlist(or_num, pr_code, ba_amount);
	    if (!res2) {
	        model.addAttribute("msg", "주문 목록 추가에 실패하였습니다.");
	        model.addAttribute("url", "/product/detail?pr_code=" + pr_code);
	        return "message";
	    }


	    model.addAttribute("msg", "주문을 완료했습니다.");
	    model.addAttribute("url", "/product/detail?pr_code=" + pr_code);
	    return "message";
	}
	
	// 상품검색페이지
	@GetMapping("/product/search")
	public String productSearch(Model model, ProductCriteria cri) {
		//모든 제품에서 pr_name을 검색
		ArrayList<ProductVO> productlist = productService.getproductListByName(cri);
		
		// 페이지네이션 관련 모음
		int totalCount = productService.getTotalCountByName(cri);
		PageMaker pm = new PageMaker(5,cri,totalCount);
		
		model.addAttribute("productlist",productlist);
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("pm",pm);
		
		
		model.addAttribute("title", "SMEG - 검색결과페이지 - 3차프로젝트");
		return "/product/search";
	}
		
	
}
