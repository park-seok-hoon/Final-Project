package kr.kh.smeg.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.smeg.model.vo.FileVO;
import kr.kh.smeg.model.vo.NoticeCategoryVO;
import kr.kh.smeg.model.vo.NoticeVO;
import kr.kh.smeg.pagination.Criteria;

public interface NoticeDAO {

	ArrayList<NoticeCategoryVO> selectNoticeCategoryList();

	void insertFile(@Param("fi")FileVO fileVo);

	boolean insertNotice(@Param("no")NoticeVO notice);

	void deleteFile(@Param("fi_num")int fi_num);

	ArrayList<NoticeVO> selectNoticeList(@Param("cri")Criteria cri);

	int selectNoticeTotalCount(@Param("cri")Criteria cri);

	boolean deleteNotice(@Param("no_num")int no_num);

	ArrayList<FileVO> selectFileList(@Param("no_num")int no_num);

	void updateView(@Param("no_num")int noNum);

	NoticeVO selectNotice(@Param("no_num") int noNum);

	NoticeVO selectNoticeNext(@Param("no_num")int noNum);

	NoticeVO selectNoticePrev(@Param("no_num")int noNum);
}
