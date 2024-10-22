package kr.kh.smeg.dao;

import java.util.ArrayList;

import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.NoticeVO;

public interface MainDAO {

	ArrayList<GroupVO> selectGrouplist();

	ArrayList<NoticeVO> selectNoticelist();
}
