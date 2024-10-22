package kr.kh.smeg.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.smeg.dao.FaqDAO;
import kr.kh.smeg.model.vo.FaqVO;
import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.pagination.Criteria;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FaqServiceImp implements FaqService {
	@Autowired
	FaqDAO faqDao;

	@Override
	public boolean insert(FaqVO faq, MemberVO member) {
		if(faq == null || faq.getFa_a() == null || faq.getFa_q() == null) {
			return false;
		
		}
		//faq애서 멤버 아이디를 가져와서 null일 경우 false
		//그러니깐 멤버 아이디값을 가져와야함 .
		if(member == null || member.getMe_id()==null) {
			return false;
		}
		
		//멤버 중에서도 권한이 ADMIN이어야 함 - 추가
		if(!member.getMe_authority().equals("ADMIN")) {
			return false;
		}
		
		//faq 중복체크 num 가져와서 하면 중복이 되겠지 당연히 그럼 뭘 가져와서 중복체크를 하지?
		//num이 아니라 faq a로 중복체크가 되나? 같은 질문이 있을 경우?
		//faqVO newFaq = faqDao.selectFaq(faq.getFa_num());
		faq.setFa_me_id(member.getMe_id());
		//다오에게 insert하라고 시키기
		return faqDao.insertFaq(faq);
	}

	@Override
	public ArrayList<FaqVO> getFaqList(Criteria cri) {
		if(cri == null)
			cri = new Criteria();
			return faqDao.selectFaqList(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return faqDao.selectfaqTotalCount(cri);
	}

	@Override
	public boolean deleteFaq(ArrayList<Integer> arr) {
		if(arr == null) {
			return false;
		}
		boolean res = true;
		for(int faq_num : arr) {
			//삭제가 실패하면, 브라우저 두 개 faq 2개...
			//나중에 이 기능은 adminInterceptor 추가해서 관리자만 가능하게 수정할 예정
			if(!faqDao.deleteFaq(faq_num)) {
				res = false;
			}
		}
		return res;
	}
	
}
