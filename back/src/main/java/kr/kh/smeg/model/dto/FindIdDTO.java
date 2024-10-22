package kr.kh.smeg.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

//아이디 찾기
@Data
@NoArgsConstructor
public class FindIdDTO {

	private String me_name;
	private String me_email;
}