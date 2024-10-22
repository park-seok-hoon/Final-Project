package kr.kh.smeg.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FaqVO {
	private int fa_num; 
	private String fa_me_id; 
	private String fa_q; 
	private String fa_a;
}