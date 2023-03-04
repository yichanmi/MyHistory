package kr.spring.board.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
	private int board_num; //게시판번호
	@NotEmpty
	private String title; //글제목
	@NotEmpty
	private String content; //내용
	private int hit; //조회수
	private Date reg_date; //등록일
	private Date modify_date; //수정일
	private MultipartFile upload; //파일업로드할때 파라미터네임으로 넘어올 프로퍼티
	private byte[] uploadfile; //바이트형태 파일->파일업로드할수있게
	private String filename; //파일명
	private String ip;
	private int mem_num; //회원번호
	private String id; //아이디 -> table에 없음. -> spmember에 있는 데이터를 조인해서 사용 : id하나만 쓰므로 
						//여러개 프로퍼티를 쓸 경우엔 MemberVO membeVO식으로 끌어다쓰는게 좋음
	
	//업로드 파일 처리
	public void setUpload(MultipartFile upload) throws IOException{
		this.upload = upload;
		//MultipartFile -> byte[] 형태로 변환 -> 작업시 예외발생가능성 있으므로 메서드에 IO익셉션명시
		setUploadfile(upload.getBytes());
		
		//파일명 구하기
		setFilename(upload.getOriginalFilename());
	}
	
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public byte[] getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(byte[] uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
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

	//uploadfile만 제외시키고(이유:바이트배열이므로 속도가 느려짐) 투스트링
	@Override
	public String toString() {
		return "BoardVO [board_num=" + board_num + ", title=" + title + ", content=" + content + ", hit=" + hit
				+ ", reg_date=" + reg_date + ", modify_date=" + modify_date + ", upload=" + upload + ", filename="
				+ filename + ", ip=" + ip + ", mem_num=" + mem_num + ", id=" + id + "]";
	}
}
