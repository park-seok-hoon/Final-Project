package kr.kh.smeg.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.smeg.model.dto.FindIdDTO;
import kr.kh.smeg.model.dto.FindPwDTO;
import kr.kh.smeg.model.vo.MemberVO;

public interface MemberDAO {

	MemberVO selectMember(@Param("id")String me_id); //아이디 중복 체크를 위한 검사

	boolean insertMember(@Param("member")MemberVO member); //회원가입시 회원정보 추가

	MemberVO findID(@Param("me")FindIdDTO findid); //아이디를 찾기 위한 검사

	void updatePassword(@Param("id")String id, @Param("pw")String encPw);

	void updateMemberCookie(@Param("user")MemberVO user); //자동 로그인

	MemberVO selectMemberByCookie(@Param("session_id")String sessionId); //자동 로그인 쿠키

	boolean updateMember(@Param("me") MemberVO member);

}
