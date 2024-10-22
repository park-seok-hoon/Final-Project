package kr.kh.smeg.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.smeg.model.vo.CategoryVO;
import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.model.vo.OrderStateVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.model.vo.ProductVO;
import kr.kh.smeg.model.vo.Slide_picsVO;
import kr.kh.smeg.pagination.Criteria;

public interface AdminDAO {

	ArrayList<GroupVO> selectGroupList();

	ArrayList<CategoryVO> selectCategoriesByGroupNum(@Param("gr_num")String gr_num);

	ProductVO selectProduct(@Param("pr_code")String code);
	
	ProductVO selectProductByPrCode(@Param("pr_code")String code);

	boolean insertProduct(@Param("pr")ProductVO product);

	boolean insertSlidePictures(@Param("sp_name")String name, @Param("sp_ori_name")String originalFilename, @Param("sp_pr_code")String pr_code);

	ArrayList<ProductVO> selectProductList(@Param("cri")Criteria cri);

	int selectProductTotalCount(@Param("cri")Criteria cri);

	boolean updateProduct(@Param("pr")ProductVO product);
	
	void insertSlidePictures(@Param("sp")Slide_picsVO slideVo);

	void deleteSlidePictures(@Param("sp_num")int sp_num);
	
	void deleteSlidePicture(@Param("sp_pr_code")String sp_pr_code, @Param("sp_num")int sp_num);

	ArrayList<Slide_picsVO> selectSlideList(@Param("sp_pr_code")String pr_code);

	boolean insertCategory(@Param("ca")CategoryVO category);

	CategoryVO selectCategoryByCaNum(@Param("ca_num")int ca_num);

	boolean updateCategory(@Param("ca")CategoryVO category);

	boolean deleteCategory(@Param("ca_num")int caNum);

	ArrayList<ProductVO> selectProductByCaNum(@Param("pr_ca_num")int caNum);

	boolean deleteProduct(@Param("pr_code")String pr_code);

	ArrayList<Slide_picsVO> selectSlidesByProductCode(@Param("pr_code")String pr_code);

	int selectOrderCount(@Param("cri")Criteria cri);

	ArrayList<OrderVO> selectOrder(@Param("cri")Criteria cri);

	ArrayList<OrderStateVO> selectOrderState();

	boolean orderStateUpdate(@Param("or_num")Integer integer, @Param("or_state")String string);

	ArrayList<MemberVO> selectMemberList(@Param("cri")Criteria cri);

	int selectMemberTotalCount(@Param("cri")Criteria cri);

	boolean deleteMemberByChk(@Param("me_id")String me_id);


}
