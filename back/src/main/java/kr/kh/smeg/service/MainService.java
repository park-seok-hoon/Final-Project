package kr.kh.smeg.service;

import java.util.ArrayList;

import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.NoticeVO;

public interface MainService {

	ArrayList<GroupVO> getGrouplist();

	ArrayList<NoticeVO> getNoticelist();
}
