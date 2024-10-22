package kr.kh.smeg.pagination;

import lombok.Data;

@Data
public class ProductCriteria extends Criteria {
	//매개변수가 있는 생성자
	public ProductCriteria(int page, int perPageNum) {
		//Criteria의 생성자 호출
		super(page, perPageNum);
		setOrder("pr_code");
	}
	//기본생성자
	public ProductCriteria() {
		setOrder("pr_code");
		setPerPageNum(12); // 한 페이지에 보여질 상품 수를 12개로 설정
	}
}
