package kr.kh.smeg.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.kh.smeg.model.vo.CategoryVO;
import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.model.vo.OrderStateVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.model.vo.ProductVO;
import kr.kh.smeg.pagination.Criteria;

public interface AdminService {

	ArrayList<GroupVO> getGroupList();

	ArrayList<CategoryVO> getCategoriesByGroupNum(String gr_num);

	boolean codeCheck(String code);

	boolean insertProduct(ProductVO product, MultipartFile[] slide_pictures, MultipartFile pr_pic);

	ArrayList<ProductVO> getProductList(Criteria cri);

	int getProductTotalCount(Criteria cri);

	ProductVO getProductByPrCode(String pr_code);

	boolean updateProduct(ProductVO product, MultipartFile[] slide_pictures, MultipartFile file_detail, String[] slide_pictures_value, String file_detail_value);

	boolean insertCategory(CategoryVO category, MultipartFile category_file_insert);

	boolean updateCategory(CategoryVO category, MultipartFile category_file_update, String past_ca_pic_ori_name);

	boolean deleteCategory(int caNum);

	boolean deleteProduct(ArrayList<String> arr);

	int getOrderCount(Criteria cri);

	ArrayList<OrderVO> getOrder(Criteria cri);

	ArrayList<OrderStateVO> getOrderState();

	boolean orderStateUpdate(ArrayList<String> os_states, ArrayList<Integer> or_nums);

	ArrayList<MemberVO> getMemberList(Criteria cri);

	int getMemberTotalCount(Criteria cri);

	boolean deleteMemberByChk(ArrayList<String> arr);

}
