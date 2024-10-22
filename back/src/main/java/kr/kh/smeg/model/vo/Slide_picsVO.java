package kr.kh.smeg.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Slide_picsVO {
	
	private int sp_num;				//슬라이드 사진 번호
	private String sp_name; 		//슬라이드사진명
	private String sp_ori_name;		//슬라이드원래사진명
	private String sp_pr_code;		//슬라이드 사진 외래키:제품 코드
	
	public Slide_picsVO(String sp_pr_code, String sp_name, String sp_ori_name) {
		this.sp_pr_code = sp_pr_code;
		this.sp_name = sp_name;
		this.sp_ori_name = sp_ori_name;
	}
}
