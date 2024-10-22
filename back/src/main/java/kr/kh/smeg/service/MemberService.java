package kr.kh.smeg.service;

import kr.kh.smeg.model.dto.FindIdDTO;
import kr.kh.smeg.model.dto.FindPwDTO;
import kr.kh.smeg.model.dto.LoginDTO;
import kr.kh.smeg.model.vo.MemberVO;

public interface MemberService {

	boolean signup(MemberVO member); //회원가입

	boolean idCheck(String id); //아이디 중복 검사

	MemberVO login(LoginDTO loginDTO); //로그인

	MemberVO findID(FindIdDTO findid); //아이디 찾기

	boolean findPw(String id, String email); //비밀번호 찾기

	void updateMemberCookie(MemberVO user); //자동로그인 관련 쿠키 DB에 처리
	
	MemberVO getMemberByCookie(String sessionId); //자동로그인 관련 쿠키 생성

	MemberVO getuserinfo(MemberVO user, String me_pw);

	boolean updateMember(MemberVO member, MemberVO user);

	boolean idCheck(String sns, String id);

	boolean signupSns(String sns, String id, String pw);

	MemberVO loginSns(String sns, String id);
}
