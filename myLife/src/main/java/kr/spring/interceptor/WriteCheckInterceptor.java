package kr.spring.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardVO;

public class WriteCheckInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger = LoggerFactory.getLogger(WriteCheckInterceptor.class);
	
	@Autowired
	private BoardService boardService; //주입, 한건의 레코드를 불러와야함
	
	@Override
	public boolean preHandle(HttpServletRequest request,
						 	 HttpServletResponse response,
						 	 Object handler) throws Exception{
		
		//로그찍기
		logger.info("<<로그인 회원번호와 작성자 회원번호 일치 여부 체크>>");
		
		//작성자의 회원번호 구하기 , - board_num이 get방식으로 넘어오므로 request로 처리해주기
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		BoardVO board = boardService.selectBoard(board_num); //자바빈에서 board_num정보 뽑아오기
		
		//로그인한 회원번호 구하기
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//로그인 회원번호 == 작성자회원번호 (일치 여부 체크)인지
		if(user_num == null || user_num != board.getMem_num()) {
			request.setAttribute("accessMsg", "로그인 아이디와 작성자 아이디 불일치");
			request.setAttribute("accessUrl", request.getContextPath()+"/board/list.do");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/common/notice.jsp");
			dispatcher.forward(request, response);
			
			return false; //일치하지않으므로 false
		}
		
		return true; //일치하면 true
	}

}
