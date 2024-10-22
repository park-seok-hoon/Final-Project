package kr.kh.smeg.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.smeg.model.vo.MemberVO;

//일반 회원용 - 페이지 접근 방지
public class MemberInterceptor extends HandlerInterceptorAdapter {
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
      
      //로그인 안했으면
      if(user == null) {
		 // 경고창 출력
		 response.setContentType("text/html; charset=UTF-8");
		 PrintWriter out = response.getWriter();
		 out.println("<script>");
		 out.println("alert('로그인이 필요한 서비스입니다.');");
		 out.println("</script>");
		 out.flush();
         response.sendRedirect(request.getContextPath() + "/topnav/login");
         return false;
      }
      
      return true;
   }
   
   //mypage 공통로직 처리
   @Override
   public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	   MemberVO user = (MemberVO) request.getSession().getAttribute("user");
	   
	   // 모델 앤 뷰가 존재하고 사용자 정보가 있다면 모델에 사용자 정보를 추가합니다.
	   if (modelAndView != null && user != null) {
		   modelAndView.addObject("user", user);
	   }
   }
}