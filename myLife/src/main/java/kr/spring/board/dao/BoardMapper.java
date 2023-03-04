package kr.spring.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.vo.BoardReplyVO;
import kr.spring.board.vo.BoardVO;

public interface BoardMapper {
	//부모글(추상메서드 형태)
	//1. 목록처리 : xml에서 sql문 처리
	public List<BoardVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//2. 글 등록처리
	@Insert("INSERT INTO spboard (board_num,title,content,uploadfile,filename,ip,mem_num)"
			+ "VALUES (spboard_seq.nextval,#{title},#{content},#{uploadfile},#{filename},#{ip},#{mem_num})")
	public void insertBoard(BoardVO board);
	
	//3. 글 상세
	@Select("SELECT * FROM spboard b JOIN spmember m ON b.mem_num=m.mem_num "
			+ "WHERE b.board_num=#{board_num}")
	public BoardVO selectBoard(Integer board_num); //상세페이지(#{board_num} <= integer board_num)
	
	//4. 조회수 변경
	@Update("UPDATE spboard SET hit=hit+1 WHERE board_num=#{board_num}")
	public void updateHit(Integer board_num); //조회수 업데이트
	
	
	//5. 글 수정
	public void updateBoard(BoardVO board);
	
	//6. 글 삭제
	@Delete("DELETE FROM spboard WHERE board_num=#{board_num}")
	public void deleteBoard(Integer board_num);
	
	//한건의 레코드는 남기고 파일만 지우기때문에 업데이트 처리
	@Update("UPDATE spboard SET uploadfile='',filename='' WHERE board_num=#{board_num}")
	public void deleteFile(Integer board_num); //업로드파일(바이트배열로 처리된),파일명 두개 지우기 -> 서비스
	
	//<댓글 dao>
	//댓글부분
	public List<BoardReplyVO> selectListReply(Map<String,Object> map);
	
	@Select("SELECT COUNT(*) FROM spboard_reply b JOIN spmember m "
			  + "ON b.mem_num=m.mem_num WHERE b.board_num=#{board_num}")
	public int selectRowCountReply(Map<String,Object>map);
	
	@Select("SELECT * FROM spboard_reply WHERE re_num=#{re_num}")
	public BoardReplyVO selectReply(Integer re_num);
	
	@Insert("INSERT INTO spboard_reply (re_num,re_content,re_ip,board_num,mem_num)"
			+ "VALUES (spreply_seq.nextval,#{re_content},#{re_ip},#{board_num},#{mem_num})")
	public void insertReply(BoardReplyVO boardReply);
	
	@Update("UPDATE spboard_reply SET re_content=#{re_content},"
			 + "re_ip=#{re_ip},re_mdate=SYSDATE WHERE re_num=#{re_num}")
	public void updateReply(BoardReplyVO boardReply);
	
	@Delete("DELETE FROM spboard_reply WHERE re_num=#{re_num}")
	public void deleteReply(Integer re_num);
	
	//부모님 삭제시 댓글이 존재하면 부모글 삭제전 댓글 삭제
	@Delete("DELETE FROM spboard_reply WHERE board_num=#{board_num}")
	public void deleteReplyByBoardNum(Integer board_num);
}
