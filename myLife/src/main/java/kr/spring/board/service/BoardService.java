package kr.spring.board.service;

import java.util.List;
import java.util.Map;

import kr.spring.board.vo.BoardReplyVO;
import kr.spring.board.vo.BoardVO;

public interface BoardService {
	//부모글(추상메서드 형태) -> board쪽은 (댓글부분제외) 겹치는 부분이 없어서 개별적으로 사용될 메서드들(트랜잭션)
	public List<BoardVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertBoard(BoardVO board);
	public BoardVO selectBoard(Integer board_num); //상세페이지
	public void updateHit(Integer board_num); //조회수 업데이트
	public void updateBoard(BoardVO board);
	public void deleteBoard(Integer board_num); //얘랑 댓글이랑 같이 여러개의 메서드를 처리해야하지만 아직 댓글이 없으므로 일단 단독 사용
	public void deleteFile(Integer board_num); //파일지우기
	
	//댓글부분
	public List<BoardReplyVO> selectListReply(Map<String,Object> map);
	public int selectRowCountReply(Map<String,Object>map);
	public BoardReplyVO selectReply(Integer re_num);
	public void insertReply(BoardReplyVO boardReply);
	public void updateReply(BoardReplyVO boardReply);
	public void deleteReply(Integer re_num);
}
