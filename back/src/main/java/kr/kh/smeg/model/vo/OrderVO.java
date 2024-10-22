package kr.kh.smeg.model.vo;

import java.util.ArrayList;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderVO {
	private int or_num;
	private Date or_date;
	private int or_total_price;
	private String or_os_state;
	private String or_me_id;
	
	private String or_me_name; //멤버이름을 조인하기 위해 생성
	
	//주문리스트를 rusultmap으로 조인하기 위해 생성
	private ArrayList<OrderlistVO> orderlistlist;
}