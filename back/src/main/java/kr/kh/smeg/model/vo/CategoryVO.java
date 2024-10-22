package kr.kh.smeg.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CategoryVO {
	private int ca_num;
	private int ca_gr_num;
	private String ca_name;
	private String ca_explain;
	private String ca_pic_name; //이미지관련 멤버변수 추가
	private String ca_pic_ori_name; //이미지관련 멤버변수 추가
	
}
