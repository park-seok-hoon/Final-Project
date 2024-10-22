package kr.kh.smeg.model.vo;

import java.util.ArrayList;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ProductVO {
	private String pr_code;			//상품 코드
	private String pr_name;			//상품명
	private int pr_price;			//상품 가격
	private String pr_explain;		//상품 설명
	private String pr_pic;			//상세 사진
	private String pr_pic_ori_name; //상품수정때 원래 이름을 가져오기 위해 추가한 변수
	private String pr_kc;			//kc 안증번호
	private String pr_elec;			//소비전력
	private String pr_energy; 		//에너지소비효율등급
	private String pr_date;			//출시년월
	private String pr_maker;		//수입자 표기
	private String pr_nation;		//제조국
	private String pr_size;			//크기,용량,형태
	private String pr_guarantee;	//품질보증기준
	private String pr_AS;			//A/S책임자와전화번호
	private String pr_extraprice;	//추가설치비용
	private int pr_ca_num;			//제품 그룹 번호
	private String pr_ps_state;		//상태명
	
	//상품리스트때문에 추가된 변수
	private String pr_ca_name;
	private String pr_gr_name;
	private String pr_gr_num;
	
	//슬라이드이미지 때문에 추가된 변수
	private String pr_sp_name;
	
	//슬라이드사진들을 rusultmap으로 조인하기 위해 생성
	private ArrayList<Slide_picsVO> slidelist;
}
