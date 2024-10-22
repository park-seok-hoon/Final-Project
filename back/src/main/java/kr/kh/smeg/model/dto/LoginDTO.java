package kr.kh.smeg.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

//로그인 
@Data
@NoArgsConstructor
public class LoginDTO {
	
	private String me_id;
	private String me_pw;
	private boolean autoLogin; //login.jsp autoLogin을 받을 변수 자동 로그인
}