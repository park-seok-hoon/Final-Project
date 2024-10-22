package kr.kh.smeg.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.smeg.model.vo.MemberVO;

//로그인을 한 경우 접근하면 안되는 페이지 적용
public class GuestInterceptor extends HandlerInterceptorAdapter {
	/* preHandle에서 return값이 true이면 가려던 컨트롤러로 가서 작업을 진행
	 * return값이 false이면 가려던 컨트롤러로 가지 마세요. 리다이렉트할 경로가 있으면 해당 경로로 이동
	 * */
	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
	    throws Exception {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		//로그인 했으면
		if(user != null) {
			// 경고창 출력
		    response.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.println("<script>");
		    out.println("alert('접근 권한이 없습니다.');");
		    out.println("history.go(-1);"); //이전페이지로 보내는 자바스크립트
        	out.println("</script>");
		    out.flush();
		   		   
			return false;
		}
		
		return true;
	}
}
