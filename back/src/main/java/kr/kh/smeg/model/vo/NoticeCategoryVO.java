package kr.kh.smeg.model.vo;

import java.util.ArrayList;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NoticeCategoryVO {
	private int nc_num;
	private String nc_name;
	private ArrayList<NoticeVO> noticelist;
}
