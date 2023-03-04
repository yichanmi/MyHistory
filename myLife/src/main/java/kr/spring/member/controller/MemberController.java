package kr.spring.member.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);
	
	@Autowired
	private MemberService memberService;
	
	//자바빈연결후 자바빈 초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	//1.회원 등록 폼 호출
	@GetMapping("/member/registerUser.do")
	public String form() {
		//타일스 설정
		return "memberRegister"; //member.xml로 감 -> 여기서 타일스 상속,설정(매핑시키기)
	}
	
	//1-1.회원등록처리
	@PostMapping("/member/registerUser.do")
	public String submit(@Valid MemberVO memberVO, BindingResult result) {
		
		//로그 찍기
		logger.info("<<회원가입>> : " + memberVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//회원가입 처리
		memberService.insertMember(memberVO);
		
		return "redirect:/main/main.do";
	}
	
	//2.로그인 폼
	@GetMapping("member/login.do")
	public String formLogin() {
		//타일스 설정
		return "memberLogin";
	}
	
	//2-1.로그인 폼에서 전송된 데이터 처리
	@PostMapping("/member/login.do")
	public String submitLogin(@Valid MemberVO memberVO, BindingResult result,
			HttpSession session) { //여기에 세션만 넣어주면 세션받아서 이용가능
		
		//로그 찍기
		logger.info("<<회원 로그인>> : " + memberVO); //memberVO에서 유효성체크
		
		//모든 필드를 유효성체크하므로 id랑 passwd 필드만 체크하도록 명시해주기
		if(result.hasFieldErrors("id") || result.hasFieldErrors("passwd")) {
			//유효성 체크결과 오류가 있으면 폼 호출
			return formLogin();
		}
	
		//로그인 체크(id,passwd 일치 여부 체크 -> 예외던지기 기법 사용)
		try {
			//오류가 없을시
			MemberVO member = memberService.selectCheckMember(memberVO.getId()); //id를 vo에 담아서 가져옴
			
			//조건체크
			boolean check = false;
			if(member!=null) { //아이디 존재o, 비밀번호 체크하기
				//비밀번호 일치 여부 체크				//사용자가 입력한 비밀번호를 넘겨서 db에 저장된 것이랑 비교
				check = member.isCheckedPassword(memberVO.getPasswd());
			}
			
			if(check) {
				//check가 트루시 인증성공, 로그인 처리해주기 - 세션이용(세션에 데이터 넣거주기)
				session.setAttribute("user_num", member.getMem_num());
				session.setAttribute("user_id", member.getId());
				session.setAttribute("user_auth", member.getAuth());
				session.setAttribute("user_photo", member.getPhoto());
				
				return "redirect:/main/main.do";
			}
			//인증실패
			throw new AuthCheckException();
		}catch(AuthCheckException e) { //사용자정의예외던지기 클래스 만든것 사용
			//폼에서 보여질 메세지 생성
			result.reject("invalidIdOrPassword");
			//인증 실패로 로그인 폼을 호출
			return formLogin();
		}
	}
	
	//2-2. 회원 로그아웃
	@RequestMapping("/member/logout.do")
	public String processLogout(HttpSession session) {
		
		//세션을 받아왔으므로 바로 로그아웃 처리(별도의 ui처리안하도록 구현)
		session.invalidate();
		
		return "redirect:/main/main.do";
	}
	
	//3. My페이지 작업
	@RequestMapping("/member/myPage.do")
	public String process(HttpSession session, Model model) {
		
		//로그인 되있는 상태인지
		Integer user_num = (Integer)session.getAttribute("user_num");
		MemberVO member = memberService.selectMember(user_num);
		
		//로그찍기
		logger.info("<<회원 상세 정보>> : " + member);
		
		model.addAttribute("member",member);
		
		//타일스 설정
		return "memberView"; //member.xml에서 타일스 설정 꼭 해주기
	}
	
	//3-1. 수정 폼
	@GetMapping("/member/update.do")
	public String formUpdate(HttpSession session, Model model) {
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		MemberVO memberVO = memberService.selectMember(user_num); //한건의 레코드 읽어옴
		
		//모델에 넣어주면 리퀘스트에 담아짐
		model.addAttribute("memberVO",memberVO);
		
		return "memberModify"; //member.xml에서 타일스 설정 꼭 해주기
	}
	
	//3-2. 수정폼에서 전송된 데이터 처리
	@PostMapping("/member/update.do")
	public String submitUpdate(@Valid MemberVO memberVO, BindingResult result,
														 HttpSession session) { //mem_num사용을 위해
		//로그 찍기
		logger.info("<<회원정보 수정>> : " + memberVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "memberModify";
		}
		
		//히든으로 안넘긴 user_num을 받아옴 //폼에서 넘어오지 않았기때문에
		Integer user_num = (Integer)session.getAttribute("user_num");
		memberVO.setMem_num(user_num); //자바빈이 비어있으므로 user_num을 받아옴
		
		//회원정보수정
		memberService.updateMember(memberVO);
		
		return "redirect:/member/myPage.do"; //수정되었는지 확인 위해, 정상적으로 수행시 마이페이지 호출
	}
	
	//4. 현재 비밀번호 변경 폼
	@GetMapping("/member/changePassword.do")
	public String formChangePassword() {
		return "memberChangePassword"; //member.xml가서 설정
	}
	
	//4-1. 비밀번호 변경 폼에서 전송된 데이터 처리
	@PostMapping("/member/changePassword.do")
	public String submitChangePassword(@Valid MemberVO memberVO, BindingResult result,
									  		  HttpSession session) {//자바빈에 담아서 처리하기
		logger.info("<<비밀번호 변경 처리>> : " + memberVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasFieldErrors("now_passwd") || result.hasFieldErrors("passwd")) {
			return formChangePassword();
		}
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		memberVO.setMem_num(user_num); //비밀번호 전송작업
		
		//세션에 저장된 회원정보를 이용해서 DB에 저장된 회원정보를 MemberVO에 담아서 반환 처리
		MemberVO db_member = memberService.selectMember(memberVO.getMem_num()); //회원번호를 넣고 db에 저장된 회원정보 읽어옴
		
		//사용자가 입력한 비밀번호와 DB에 저장된 비밀번호정보가 일치하는지 여부 체크
			//DB에서 읽어온 비번			  //사용자가 입력한 현재 비밀번호
		if(!db_member.getPasswd().equals(memberVO.getNow_passwd())) { //불일치할 경우
			result.rejectValue("now_passwd", "invalidPassword");
			//불일치하면 비밀번호 수정폼 호출
			return formChangePassword();
		}
		
		//일치하면 비밀번호 수정처리
		memberService.updatePassword(memberVO);
		
		return "redirect:/member/myPage.do";
	}
	
	//5. 회원탈퇴(삭제) 폼 호출
	@GetMapping("/member/delete.do")
	public String formDelete() {
		return "memberDelete"; //->member.xml작업 ㄱ
	}
	
	//5-1. 회원탈퇴 처리(회원 데이터 삭제)
	@PostMapping("/member/delete.do")
	public String submitDelete(@Valid MemberVO memberVO, BindingResult result,
									  HttpSession session) {
		
		//로그
		logger.info("<<회원탈퇴>> : " + memberVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasFieldErrors("id") || result.hasFieldErrors("passwd")) {
			return "formDelete";
		}
		
		//아이디 , 비밀번호 일치 여부 조건 체크(user_num을 통해 한건의 레코드를 받아 세션에 있는 아이디를 통해 일치여부 체크)
		Integer user_num = (Integer)session.getAttribute("user_num");
		//데이터가 담겨있는 memberVO를 통해 데이터 넘겨주기
		memberVO.setMem_num(user_num);
		
		//아이디와 비밀번호 일치 여부 체크 작업(예외 던지기)
		try {
			//세션에 저장된 회원정보를 이용해서 DB에 저장된 회원정보를 MemberVO에 담아서 반환 작업
			MemberVO db_member = memberService.selectMember(memberVO.getMem_num()); //한건의 레코드 불러옴
			
			//조건체크
			boolean check = false;
				//db저장된 id									//현재 로그인된 id
			if(db_member!=null && memberVO.getId().equals(db_member.getId())) {
				//비밀번호 일치 여부						//사용자가 입력한 변경할 비밀번호
				check = db_member.isCheckedPassword(memberVO.getPasswd());
			}
			if(check) {
				//인증성공, 회원정보 삭제
				memberService.deleteMember(memberVO.getMem_num());
				
				//탈퇴했으니 로그아웃
				session.invalidate();
				
				return "redirect:/main/main.do";
			}
			//인증 실패
			throw new AuthCheckException();
			
		}catch(AuthCheckException e) {
			result.reject("invalidIdOrPassword");
			return formDelete();
		}
	}
	
	//6. 이미지 출력(프로필 작업->바이트배열로 가지고있어 별도로 작업해서 스트림을 발생해서 저장) -> 이미지 불러오기
	@RequestMapping("/member/photoView.do")
	public ModelAndView viewImage(HttpSession session) {
		
		//세션에 저장된 회원번호 알아냄
		Integer user_num = (Integer)session.getAttribute("user_num");
		MemberVO memberVO = memberService.selectMember(user_num);
		
		//바이트 스트림으로 인해 모델앤뷰에 담아서 사진데이터를  호출하는 방식
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView"); //뷰 이름 구하기 -> 빈(bean) 객체 생성
		//설정에 의해 이미지파일스트림들이 호출 가능해짐
		//imageFile(속성명)바이트 배열(에서 스트림형태로 변환)이 전달됨(kr.spring.view/imageView에서 작업된)
		mav.addObject("imageFile", memberVO.getPhoto());
		mav.addObject("filename", memberVO.getPhoto_name());
		
		return mav;
	}
}
