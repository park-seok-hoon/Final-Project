package kr.kh.smeg.model.vo;


import java.util.ArrayList;

import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
public class GroupVO {
	private int gr_num;
	private String gr_name;
	private ArrayList<CategoryVO> categorylist;
}
