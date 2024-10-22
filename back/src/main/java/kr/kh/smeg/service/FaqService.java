package kr.kh.smeg.service;

import java.util.ArrayList;

import kr.kh.smeg.model.vo.FaqVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.pagination.Criteria;

public interface FaqService {

	boolean insert(FaqVO faq, MemberVO user); //FAQ 데이터 추가

	ArrayList<FaqVO> getFaqList(Criteria cri); //FAQ 리스트 가져오기

	int getTotalCount(Criteria cri); //FAQ 리스트 개수 가져오기

	boolean deleteFaq(ArrayList<Integer> arr); //FAQ 삭제 처리
	
	
	
	
	
}
