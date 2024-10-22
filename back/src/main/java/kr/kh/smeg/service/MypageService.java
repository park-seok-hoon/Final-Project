package kr.kh.smeg.service;

import java.util.ArrayList;

import kr.kh.smeg.model.vo.BasketVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.pagination.Criteria;

public interface MypageService {

	ArrayList<BasketVO> getBasketById(String me_id);

	boolean deleteBasketByNum(String ba_num);

	boolean deleteBaskets(ArrayList<Integer> arr);

	boolean insertOrderlistAll(int or_num, ArrayList<String> pr_codes, ArrayList<Integer> ba_amounts);

	ArrayList<OrderVO> getOrderById(String me_id, Criteria cri);

	int getOrderCountById(String me_id, Criteria cri);

	boolean deleteMemberById(String me_id);

	boolean pwCheck(String me_pw, String pw);

}
