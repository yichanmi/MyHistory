package kr.spring.member.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminCheckInterceptor extends HandlerInterceptorAdapter{
	//로그 찍기
	private static final Logger logger = LoggerFactory.getLogger(AdminCheckInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response,
							 Object handler) throws Exception{
		
		logger.info("<<AdminCheckInterceptor 진입>>");
		
		HttpSession session = request.getSession();
		//auth값 구하기
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth == null || user_auth != 3) { //로그인이 안되있거나 관리자가 아닌경우
			//관리자 권한이 아닌 경우(forward방식)
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/common/notice.jsp");
			dispatcher.forward(request, response);
			//요청한 페이지를 호출안하므로
			return false;
		}
		
		return true; //트루여야 요청한 페이지가 호출되므로
	}
}
