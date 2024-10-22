package kr.kh.smeg.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

//비밀번호 찾기
@Data
@NoArgsConstructor
public class FindPwDTO {

	private String me_id;
	private String me_email;
}