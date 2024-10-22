package kr.kh.smeg.service;

import java.util.ArrayList;

import kr.kh.smeg.model.vo.CategoryVO;
import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.model.vo.OrderlistVO;
import kr.kh.smeg.model.vo.ProductVO;
import kr.kh.smeg.model.vo.Slide_picsVO;
import kr.kh.smeg.pagination.Criteria;
import kr.kh.smeg.pagination.ProductCriteria;

public interface ProductService {

	CategoryVO getCategoryByCaNum(int ca_num);

	GroupVO getGroupByCaGrNum(int ca_gr_num);

	CategoryVO getCategoryByGroupMin(int ca_gr_num);

	ArrayList<GroupVO> getGrouplist();

	ArrayList<CategoryVO> getCategoriesByGroupNum(String gr_num);

	ArrayList<ProductVO> getproductList(ProductCriteria cri);

	int getTotalCount(ProductCriteria cri);

	ProductVO getProductCode(String pr_code);

	boolean insertBasket(String ba_amount, String me_id, String pr_code);

	boolean insertOrder(String me_id, int or_total_price);

	boolean insertOrderlist(int or_num, String pr_code, String ba_amount);

	OrderVO getOrderById(String me_id);

	ArrayList<ProductVO> getproductListByName(ProductCriteria cri);

	int getTotalCountByName(ProductCriteria cri);
}
