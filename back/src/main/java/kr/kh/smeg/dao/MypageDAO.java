package kr.kh.smeg.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.smeg.model.vo.BasketVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.pagination.Criteria;

public interface MypageDAO {

	ArrayList<BasketVO> selectBasketById(@Param("ba_me_id")String me_id);

	boolean deleteBasketByNum(@Param("ba_num")String ba_num);

	boolean insertOrderlist(@Param("or_num")int or_num, @Param("pr_code")String string, @Param("orlist_amount")Integer integer);

	ArrayList<OrderVO> selectOrderById(@Param("or_me_id")String me_id, @Param("cri")Criteria cri);

	int selectOrderCountById(@Param("or_me_id")String me_id, @Param("cri")Criteria cri);

	boolean deleteMemberById(@Param("me_id")String me_id);
	
}
