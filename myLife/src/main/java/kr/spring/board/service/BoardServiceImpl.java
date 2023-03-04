package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.board.dao.BoardMapper;
import kr.spring.board.vo.BoardReplyVO;
import kr.spring.board.vo.BoardVO;

//컨테이너에 포함시킬것이므로
@Service
public class BoardServiceImpl implements BoardService{

	@Autowired //주입받기
	private BoardMapper boardMapper;
	
	//2. 게시판 목록 : 리스트
	@Override
	public List<BoardVO> selectList(Map<String, Object> map) {

		return boardMapper.selectList(map);
	}
	
	//2-1. 게시판 목록 : 총 레코드 수(카운트)
	@Override
	public int selectRowCount(Map<String, Object> map) {

		return boardMapper.selectRowCount(map);
	}
	
	//3.글 등록
	@Override
	public void insertBoard(BoardVO board) {
		boardMapper.insertBoard(board);
	}
	
	//4. 글 상세 페이지 보기
	@Override
	public BoardVO selectBoard(Integer board_num) {
	
		return boardMapper.selectBoard(board_num);
	}
	
	//5. 조회수 증가(업데이트)
	@Override
	public void updateHit(Integer board_num) {
		boardMapper.updateHit(board_num);		
	}
	
	//7. 글 수정 처리
	@Override
	public void updateBoard(BoardVO board) {
		boardMapper.updateBoard(board);
	}
	
	//8. 글 삭제
	@Override
	public void deleteBoard(Integer board_num) {
		//댓글이 존재하면 댓글을 우선 삭제하고 부모글을 삭제
		boardMapper.deleteReplyByBoardNum(board_num);
		boardMapper.deleteBoard(board_num);
	}
	
	//6. 업로드 파일만 지우기 -> 작업후 컨트롤러(ajax컨트롤러로)
	@Override
	public void deleteFile(Integer board_num) {
		boardMapper.deleteFile(board_num);
	}
	
	
	//댓글 추상메서드부분
	@Override
	public List<BoardReplyVO> selectListReply(Map<String, Object> map) {
		return boardMapper.selectListReply(map);
	}

	@Override
	public int selectRowCountReply(Map<String, Object> map) {
		return boardMapper.selectRowCountReply(map);
	}

	@Override
	public BoardReplyVO selectReply(Integer re_num) {
		return boardMapper.selectReply(re_num);
	}

	//댓글 입력
	@Override
	public void insertReply(BoardReplyVO boardReply) {
		boardMapper.insertReply(boardReply);
	}

	@Override
	public void updateReply(BoardReplyVO boardReply) {
		boardMapper.updateReply(boardReply);	
	}

	@Override
	public void deleteReply(Integer re_num) {
		boardMapper.deleteReply(re_num);
	}
}
