package kr.kh.smeg.model.vo;

import java.util.ArrayList;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BasketVO {
	
	private int ba_num;
	private int ba_amount; //수량
	private String ba_me_id; //아이디
	private String ba_pr_code; //상품 코드
	
	//제품이 리스트로 처리 : 같은 코드의 제품도 여러번 주문 했을 수 있음
	private ArrayList<ProductVO> productlist;
}