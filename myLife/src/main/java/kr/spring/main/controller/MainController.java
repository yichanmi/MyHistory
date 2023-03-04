package kr.spring.main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.board.controller.BoardController;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;

@Controller
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@SuppressWarnings("unused")
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/main/main.do")
	public String main() {
		
		//타일스 설정한 것 반환->메인호출
		return "main";
	}
}
