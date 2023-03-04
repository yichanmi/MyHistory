package kr.spring.member.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter{ //먼저 요청 데이터를 낚아채 조건 체크
	//로그찍기
	private static final Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response,
							 Object handler)throws Exception{
		
		logger.info("<<LoginCheckInterceptor 진입>>"); //요청한 데이터를 낚아채 로그인여부 체크를 해주느냐
		
		//로그인 여부 검사
		HttpSession session = request.getSession();
		if(session.getAttribute("user_num")==null) { //로그인x않은경우
			response.sendRedirect(request.getContextPath()+"/member/login.do"); //요청한 페이지로 가지않음
			
			return false; //요청한 페이지로 가지않으므로
		}
		return true; //정상적으로 수행시 요청한 페이지(url)를 호출
	}
}
