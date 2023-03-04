package kr.spring.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;

@Controller
public class MemberAdminController {
	private static final Logger logger = LoggerFactory.getLogger(MemberAdminController.class);
	
	//주입받기
	@Autowired
	private MemberService memberService;
	
	//1.회원관리 목록
	@RequestMapping("/member/admin_list.do")
	//페이지 처리, 키필드, 키워드 처리
	public ModelAndView process(@RequestParam(value = "pageNum", defaultValue = "1")
								int currentPage,
								@RequestParam (value = "keyfield", defaultValue = "")
								String keyfield,
								@RequestParam(value = "keyword", defaultValue = "")
								String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield",keyfield);
		map.put("keyword", keyword);
		
		//1-1.총 글의 갯수 또는 검색된 글의 갯수
		int count = memberService.selectRowCount(map);
		
		logger.info("<<회원관리>> : " + count);
		
		//1-2.페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20,10,"admin_list.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		List<MemberVO> list = null; //리스트 초기화
		if(count > 0 ) {
			list = memberService.selectList(map);
		}
		
		//모델앤뷰로 데이터 반환
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_memberList"); //타일스 설정임 -> 설정하러 ㄱ
		mav.addObject("count",count);
		mav.addObject("list",list);
		mav.addObject("pagingHtml", page.getPagingHtml());
		
		return mav;
	}
	
	//2. 관리자 - 회원정보 수정 폼
	@GetMapping("/member/admin_update.do")
	//사용자쪽에서 쓴 메서드가 있으므로 그대로 활용
	public String form(@RequestParam int mem_num, Model model){
		
		MemberVO memberVO = memberService.selectMember(mem_num);
		
		model.addAttribute("memberVO",memberVO);
		
		return "admin_memberModify"; //타일스 설정하러
	}
	
	//2-1. 관리자 - 회원정보 수정 처리
	//과정1)수정 폼에서 전송된 데이터 처리
	@PostMapping("/member/admin_update.do")
	public String submit(@Valid MemberVO memberVO, BindingResult result) {//자바빈에 담겨서 오므로
		
		//로그 찍기
		logger.info("<<관리자 회원수정 처리>> : " + memberVO);
		
		//유효성 체크 결과 오류 발생시 폼 호출
		if(result.hasErrors()) {
			return "admin_memberModify";
		}
		
		//정상수행시 회원정보 수정 처리
		memberService.updateByAdmin(memberVO); //자바빈의 데이터를 업데이트 시켜야하므로
		
		return "redirect:/member/admin_list.do";
	}
}
