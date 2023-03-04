package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	//사용자 -> 어노테이션이용하므로 인터페이스만 구현 , 헷갈리므로 memberdao랑 메서드명 동일하게 복붙
	//detail부분은 합쳐지므로 삭제 -> 이 후 클래스쪽으로 구현처리
	public void insertMember(MemberVO member);
	public MemberVO selectCheckMember(String id); //멤버vo로 반환 형태
	public MemberVO selectMember(Integer mem_num); //int로도 명시가능
	public void updateMember(MemberVO member);
	public void updatePassword(MemberVO member);
	public void deleteMember(Integer mem_num);
	public void updateProfile(MemberVO member); //포르필이미지 업데이트

	//관리자 -> 어노테이션이용하므로 인터페이스만 구현
	public List<MemberVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void updateByAdmin(MemberVO member);
}
