package kr.kh.smeg.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.smeg.model.vo.FaqVO;
import kr.kh.smeg.pagination.Criteria;

public interface FaqDAO {

	boolean insertFaq(@Param("faq")FaqVO faq);

	ArrayList<FaqVO> selectFaqList(@Param("cri") Criteria cri);

	int selectfaqTotalCount(@Param("cri") Criteria cri);

	boolean deleteFaq(@Param("fa_num") int faq_num);

}
