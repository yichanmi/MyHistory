package kr.spring.board.vo;

import kr.spring.util.DurationFromNow;

public class BoardReplyVO {
	private int re_num;
	private String re_content;
	private String re_date;
	private String re_mdate;
	private String re_ip;
	private int board_num; //부모글 번호
	private int mem_num; //작성자 회원번호
	private String id;
	
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public String getRe_date() {
		return re_date;
	}
	public void setRe_date(String re_date) {
		this.re_date = DurationFromNow.getTimeDiffLabel(re_date);
	}
	public String getRe_mdate() {
		return re_mdate;
	}
	public void setRe_mdate(String re_mdate) {
		this.re_mdate = DurationFromNow.getTimeDiffLabel(re_mdate);
	}
	public String getRe_ip() {
		return re_ip;
	}
	public void setRe_ip(String re_ip) {
		this.re_ip = re_ip;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@Override
	public String toString() {
		return "BoardReplyVO [re_num=" + re_num + ", re_content=" + re_content + ", re_date=" + re_date + ", re_mdate="
				+ re_mdate + ", re_ip=" + re_ip + ", board_num=" + board_num + ", mem_num=" + mem_num + ", id=" + id
				+ "]";
	}
}
