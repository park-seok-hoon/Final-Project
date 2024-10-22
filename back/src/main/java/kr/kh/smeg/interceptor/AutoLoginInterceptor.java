package kr.kh.smeg.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.kh.smeg.model.vo.MemberVO;
import kr.kh.smeg.service.MemberService;

public class AutoLoginInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	MemberService memberService;
	
	//자동 로그인을 체크했을떄 어느 페이지를 가도 자동 로그인이 되도록 하고 모든 url에 갔을때
	//한번씩 자동 로그인을 체크하도록 하기 위해서 만들었음
	
	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
	    throws Exception {
		
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		//로그인이 안되어 있다면 자동 로그인을 체크를 해야 함
		if(user == null) {
			//loginCookie 정보를 가져옴
			Cookie cookie = WebUtils.getCookie(request, "loginCookie");	
			//LoginInterceptor와 이름을 동일하게 맞춰야 함 "loginCookie"
			
			//쿠키가 있으면 자동 로그인을 진행함
			if(cookie != null) {
				//쿠키에 value로 넣었던 세션 아이디 값을 가져옴
				String sessionId = cookie.getValue();
				user = memberService.getMemberByCookie(sessionId);
				if(user != null) {
					request.getSession().setAttribute("user", user);
				}
				
				
			}
		}
		
		return true;
	}
}