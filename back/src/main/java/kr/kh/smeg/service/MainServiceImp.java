package kr.kh.smeg.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.smeg.dao.MainDAO;
import kr.kh.smeg.model.vo.GroupVO;
import kr.kh.smeg.model.vo.NoticeVO;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MainServiceImp implements MainService {
	@Autowired
	MainDAO mainDao;


	@Override
	public ArrayList<GroupVO> getGrouplist() {
		return mainDao.selectGrouplist();
	}


	@Override
	public ArrayList<NoticeVO> getNoticelist() {
		return mainDao.selectNoticelist();
	}
}
