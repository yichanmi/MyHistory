package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;

public interface MemberMapper {
	//사용자 -> 어노테이션이용하므로 인터페이스만 구현
	@Select("SELECT spmember_seq.nextval FROM dual")
	public int selectMem_num();
	
	@Insert("INSERT INTO spmember (mem_num,id) VALUES (#{mem_num},#{id})")
	public void insertMember(MemberVO member);
	
	@Insert("INSERT INTO spmember_detail (mem_num,name,passwd,phone,email,zipcode,address1,address2) VALUES (#{mem_num},#{name},#{passwd},#{phone},#{email},#{zipcode},#{address1},#{address2})")
	public void insertMember_detail(MemberVO member);
	
	@Select("SELECT m.mem_num,m.id,m.auth,d.passwd,d.photo FROM spmember m LEFT OUTER JOIN spmember_detail d ON m.mem_num=d.mem_num WHERE m.id=#{id}")
	public MemberVO selectCheckMember(String id); //멤버vo로 반환 형태
	
	@Select("SELECT * FROM spmember m JOIN spmember_detail d ON m.mem_num=d.mem_num WHERE m.mem_num=#{mem_num}")
	public MemberVO selectMember(Integer mem_num); //int로도 명시가능, 요기 mem_num이 위 #{mem_num}으로 전달되는 것임
	
	@Update("UPDATE spmember_detail SET name=#{name},phone=#{phone},email=#{email},zipcode=#{zipcode},address1=#{address1},address2=#{address2},modify_date=SYSDATE WHERE mem_num=#{mem_num}")
	public void updateMember(MemberVO member);
	
	@Update("UPDATE spmember_detail SET passwd=#{passwd} WHERE mem_num=#{mem_num}")
	public void updatePassword(MemberVO member);
	
	//회원탈퇴는 두가지 작업(UPDATE와 DELETE 두 개 수행)
	@Update("UPDATE spmember SET auth=0 WHERE mem_num=#{mem_num}") //auth=0처리
	public void deleteMember(Integer mem_num);
	
	@Delete("DELETE FROM spmember_detail WHERE mem_num=#{mem_num}") //트랜잭션 처리하러 서비스 ㄱ
	public void deleteMember_detail(Integer mem_num);
	
												//blod타입 포토 : 자동변환해줘서 이것만 명시
	@Update("UPDATE spmember_detail SET photo=#{photo},photo_name=#{photo_name} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberVO member); //프로필이미지 업데이트
	
	//[관리자] -> 어노테이션이용하므로 인터페이스만 구현
	public List<MemberVO> selectList(Map<String,Object> map); //목록작업(리스트) xml에 작업
	public int selectRowCount(Map<String,Object> map);//목록작업(총 레코드 수) xml에 작업
	
	//1-1)auth값 변경처리를 위한 업데이트 작업
	@Update("UPDATE spmember SET auth=#{auth} WHERE mem_num=#{mem_num}")
	public void updateByAdmin(MemberVO member);
	//1-2)member_detail부분의 데이터 업데이트 작업
	@Update("UPDATE spmember_detail SET name=#{name},phone=#{phone},email=#{email},zipcode=#{zipcode},address1=#{address1},address2=#{address2} WHERE mem_num=#{mem_num}")
	public void updateDetailByAdmin(MemberVO member);
}
