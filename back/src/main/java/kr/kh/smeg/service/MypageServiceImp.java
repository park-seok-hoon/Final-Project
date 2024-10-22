package kr.kh.smeg.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.smeg.dao.MemberDAO;
import kr.kh.smeg.dao.MypageDAO;
import kr.kh.smeg.model.vo.BasketVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.model.vo.OrderVO;
import kr.kh.smeg.pagination.Criteria;

@Service
public class MypageServiceImp implements MypageService {
	@Autowired
	MypageDAO mypageDao;
	
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	//문자열 체크
	private boolean checkString(String str) {
		return str != null && str.length() != 0;
	}

	@Override
	public ArrayList<BasketVO> getBasketById(String me_id) {
		return mypageDao.selectBasketById(me_id);
	}

	@Override
	public boolean deleteBasketByNum(String ba_num) {
		if(!checkString(ba_num)) {
			return false;
		}
		return mypageDao.deleteBasketByNum(ba_num);
	}

	@Override
	public boolean deleteBaskets(ArrayList<Integer> arr) {
		if(arr == null) {
			return false;
		}
		boolean res = true;
		for(int ba_num : arr) {
			if(!mypageDao.deleteBasketByNum(String.valueOf(ba_num))) {
				res = false;
			}
		}
		return res;
	}

	@Override
	public boolean insertOrderlistAll(int or_num, ArrayList<String> pr_codes, ArrayList<Integer> ba_amounts) {
		if(pr_codes == null || ba_amounts == null) {
			return false;
		}
		boolean res = true;
		
		for(int i=0;i<pr_codes.size();i++) {
			if(!mypageDao.insertOrderlist(or_num, pr_codes.get(i), ba_amounts.get(i))) {
				res = false;
			}
		}
		
		return res;
	}

	@Override
	public ArrayList<OrderVO> getOrderById(String me_id, Criteria cri) {
		return mypageDao.selectOrderById(me_id,cri);
	}

	@Override
	public int getOrderCountById(String me_id, Criteria cri) {
		return mypageDao.selectOrderCountById(me_id,cri);
	}

	@Override
	public boolean deleteMemberById(String me_id) {
		if(!checkString(me_id)) {
			return false;
		}
		return mypageDao.deleteMemberById(me_id);
	}

	//탈퇴를 위한 비밀번호 체크
	@Override
	public boolean pwCheck(String me_pw, String pw) {
		if(!checkString(me_pw) || !checkString(pw)) {
			return false;
		}
	
		
		if(!passwordEncoder.matches(pw, me_pw)) {
			return false;
		}
		
		return true;
	}
}
