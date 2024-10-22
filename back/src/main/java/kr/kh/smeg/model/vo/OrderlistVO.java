package kr.kh.smeg.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderlistVO {
	private int ol_num;
	private int ol_or_num;
	private String ol_pr_code;
	private String ol_amount; //수량
	
	//조인해서 추가된 변수
	private String sp_name;
	private String pr_name;
	private String pr_price;
}