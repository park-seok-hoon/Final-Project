package kr.kh.smeg.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.smeg.model.vo.Slide_picsVO;
import kr.kh.smeg.model.vo.FileVO;
import kr.kh.smeg.model.vo.CategoryVO;
import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.model.vo.ProductVO;
import kr.kh.smeg.pagination.Criteria;
import kr.kh.smeg.pagination.ProductCriteria;

public interface ProductDAO {

	CategoryVO selectCategoryByCaNum(@Param("ca_num")int ca_num);

	GroupVO selectGroupByCaGrNum(@Param("ca_gr_num")int ca_gr_num);

	CategoryVO selectCategoryByGroupMin(@Param("ca_gr_num")int ca_gr_num);

	ArrayList<GroupVO> selectGrouplist();

	ArrayList<CategoryVO> selectCategoriesByGroupNum(@Param("gr_num")String gr_num);

	ArrayList<ProductVO> selectProductList(@Param("cri")ProductCriteria cri);

	int selectProductTotalCount(@Param("cri")ProductCriteria cri);

	ProductVO selectProductCode(@Param("pr_code")String pr_code);

	boolean insertBasket(@Param("ba_amount")String ba_amount, @Param("ba_me_id")String me_id, @Param("ba_pr_code")String pr_code);

	boolean insertOrder(@Param("or_me_id")String me_id, @Param("or_total_price")int or_total_price);

	boolean insertOrderlist(@Param("or_num")int or_num, @Param("pr_code")String pr_code, @Param("orlist_amount")String orlist_amount);

	OrderVO selectOrderById(@Param("or_me_id")String me_id);
	
	ArrayList<ProductVO> selectSearchProduct(@Param("cri") Criteria cri);

	ArrayList<ProductVO> selectproductListByName(@Param("cri")ProductCriteria cri);

	int selectTotalCountByName(@Param("cri")ProductCriteria cri);

}
