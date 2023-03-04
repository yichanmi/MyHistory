package kr.spring.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired //주입받기
	private BoardService boardService;

	//1. 게시판 글 목록(리스트)
	@RequestMapping("/board/list.do")
	public ModelAndView process(@RequestParam(value = "pageNum", defaultValue = "1")
								int currentPage,
								@RequestParam(value = "keyfield", defaultValue = "")
								String keyfield,
								@RequestParam(value = "keyword", defaultValue = "")
								String keyword){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword",keyword);
		
		//글의 총 갯수 또는 검색된 글의 갯수
		int count = boardService.selectRowCount(map);
		
		//페이지처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,20,10,"list.do");
		map.put("start",page.getStartCount());
		map.put("end",page.getEndCount());
		
		List<BoardVO> list = null;
		if(count > 0) {
			list = boardService.selectList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("boardList"); //타일스 설정 -> 타일스설정했으므로 타일스파일 생성하러 
		//타일스 설정 후 servlet-context.xml에 타일스 설정 한 것 넣어주기
		mav.addObject("count",count);
		mav.addObject("list",list);
		mav.addObject("pagingHtml",page.getPagingHtml());

		return mav;
	}

	//자바빈(VO) 초기화
	@ModelAttribute
	public BoardVO initCommand() {
		return new BoardVO();
	}

	//2.글 등록 폼
	@GetMapping("/board/write.do")
	public String form() {
		
		return "boardWrite"; 
	}
  
	//2-1. 글 등록 폼에서 전송된 데이터 처리
	@PostMapping("/board/write.do")
	public String submit(@Valid BoardVO boardVO, BindingResult result, HttpSession session, HttpServletRequest request) {
		
		//로그
		logger.info("<<게시판 글 저장>> : " + boardVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		//회원번호세팅
		boardVO.setMem_num(user_num);
		//ip셋팅
		boardVO.setIp(request.getRemoteAddr());
		//글쓰기 완료
		boardService.insertBoard(boardVO);
		
		return "redirect:/board/list.do";
	}
	
	//3.게시판 글 상세
	@RequestMapping("/board/detail.do")
	public ModelAndView process(@RequestParam int board_num) {
		logger.info("<<게시판 글 상세>> : " + board_num);
		
		//해당 글의 조회수 증가
		boardService.updateHit(board_num);
		
		BoardVO board = boardService.selectBoard(board_num); //한건의 레코드 넘김->모델앤뷰로 담아줌
		//타이틀에 HTML 불허
		board.setTitle(StringUtil.useNoHtml(board.getTitle()));
		
								//타일스설정  , 속성명,  속성값
		return new ModelAndView("boardView","board",board);//생성자방식으로 넘기는 방식
	}
	//3-1. 글 상세에서 이미지 출력
	@RequestMapping("/board/imageView.do")
	//글번호를 통해 이미지를 읽어와야함
	public ModelAndView viewImage(@RequestParam int board_num) {
		BoardVO board = boardService.selectBoard(board_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		mav.addObject("imageFile",board.getUploadfile()); //바이트배열로 반환
		mav.addObject("filename",board.getFilename());
		return mav;
	}
	
	//4.servlet-context에서 이미지다운로드 설정을 저장했으므로 별도로 컨트롤러에서 만들어줘야함.
	//<파일 다운로드>
	@RequestMapping("/board/file.do")
	public ModelAndView download(@RequestParam int board_num) {
		BoardVO board = boardService.selectBoard(board_num); //board_num을 불러옴(시퀀스)
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("downloadView"); //servlet-context에서 설정한 id값
		mav.addObject("downloadFile",board.getUploadfile());
		mav.addObject("filename",board.getFilename());
		
		return mav;
	}
	
	//5. 게시글 수정 폼 호출
	@GetMapping("/board/update.do")
	public String formUpdate(@RequestParam int board_num, Model model) {
		
		BoardVO boardVO = boardService.selectBoard(board_num); //한건의 레코드를 불러 리퀘스트에 넣어줘야함
		
		model.addAttribute("boardVO",boardVO);
		
		return "boardModify"; //타일스 설정
	}
	
	//5-1. 게시글 수정폼에서 전송된 데이터로 글 수정처리
	@PostMapping("/board/update.do")
	public String submitUpdate(@Valid BoardVO boardVO, BindingResult result,
								HttpServletRequest request, //ip주소 구하기 위해
								Model model) {
		
		logger.info("<<글 정보 수정>> : " + boardVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			//title 또는 content가 입력되지 않으면 유효성 체크시 오류가 발생하고
			//★'파일 정보를 잃어버리기 때문에' 폼을 호출할 때 다시 셋팅
			BoardVO vo = boardService.selectBoard(boardVO.getBoard_num());
			boardVO.setFilename(vo.getFilename());
			
			return "boardModify";
		}
		
		//ip셋팅
		boardVO.setIp(request.getRemoteAddr());
		
		//글 수정
		boardService.updateBoard(boardVO);
		
		//view에 표시할 메세지 지정
		model.addAttribute("message","글 수정 완료!");
		model.addAttribute("url", request.getContextPath()+"/board/list.do");
		
		return "common/resultView";//타일스 설정이 아닌 views/.jsp파일 호출
	}
	
	//6. 글 삭제 처리
	//별도의 폼을 호출안하므로 req매핑어노테이션으로
	@RequestMapping("/board/delete.do")
	public String submitDelete(@RequestParam int board_num) {
		
		boardService.deleteBoard(board_num);
		
		return "redirect:/board/list.do";
	}
	
}
