package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;

import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;

@Controller
public class MemberAjaxController {
	private static final Logger logger = 
			LoggerFactory.getLogger(MemberAjaxController.class);
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/member/confirmId.do")
	@ResponseBody//제이슨문자열로 만들어줌
	public Map<String,String> process(@RequestParam String id){
		logger.info("<<id>> : " + id);
		
		Map<String,String> map = new HashMap<String,String>();
		
		MemberVO member = memberService.selectCheckMember(id);
		if(member!=null) {
			//아이디 중복
			map.put("result", "idDuplicated");
		}else {
			if(!Pattern.matches("^[A-Za-z0-9]{4,12}$", id)) {
				//패턴 불일치
				map.put("result", "notMatchPattern");
			}else {
				//아이디 미중복
				map.put("result", "idNotFound");
			}
		}	
		return map;
	}
	
	//2. ajax로 프로필 사진 변경작업(맵 형태로)
	@RequestMapping("/member/updateMyPhoto.do")
	@ResponseBody
	public Map<String,String> processProfile(MemberVO memberVO, HttpSession session){
		
		Map<String,String> map = new HashMap<String,String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) { //로그인x경우
			map.put("result", "logout");
		}else {//로그인o
			memberVO.setMem_num(user_num);
			memberService.updateProfile(memberVO);
			
			//이미지를 업로드한 후 세션에 저장된 user_photo 값 변경
			session.setAttribute("user_photo", memberVO.getPhoto());
			
			map.put("result", "success"); //호출할수있게끔 작업해줌
		}
		
		return map;
	}
}
