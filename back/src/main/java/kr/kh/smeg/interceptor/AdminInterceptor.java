package kr.kh.smeg.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.smeg.model.vo.MemberVO;

//관리자 페이지 접근 방지
public class AdminInterceptor extends HandlerInterceptorAdapter {
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
      
      //관리자가 아니라면
      if(user == null || (user != null && !user.getMe_authority().equals("ADMIN"))) {
    	 // 경고창 출력
 		 response.setContentType("text/html; charset=UTF-8");
 		 PrintWriter out = response.getWriter();
 		 out.println("<script>");
 		 out.println("alert('관리자만 접근할 수 있습니다.');");
 		 out.println("history.go(-1);"); //이전페이지로 보내는 자바스크립트
 		 out.println("</script>");
 		 out.flush();
         return false;
      }
      
      return true;
   }
}