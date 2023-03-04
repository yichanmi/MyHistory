package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;

//컨테이너 구현
@Service
@Transactional //전체에 트랜잭션 처리하기
public class MemberServiceImpl implements MemberService{
	
	@Autowired //주입
	private MemberMapper memberMapper;	
	
	//1. 멤버 회원가입
	@Override
	public void insertMember(MemberVO member) {
		member.setMem_num(memberMapper.selectMem_num()); //자바빈에 넣어주기//시퀀스 넣기
		memberMapper.insertMember(member); //회원정보 넣기
		memberMapper.insertMember_detail(member); //회원 디테일 정보넣기
	}
	
	//1-1. 회원가입 : id중복체크
	@Override
	public MemberVO selectCheckMember(String id) {
		
		return memberMapper.selectCheckMember(id);
	}
	
	//2. 마이페이지 작업
	@Override
	public MemberVO selectMember(Integer mem_num) {

		return memberMapper.selectMember(mem_num);
	}
	
	//3. 회원정보 수정 작업
	@Override
	public void updateMember(MemberVO member) {
		memberMapper.updateMember(member);
	}
	
	//4. 회원 비밀번호 변경 작업
	@Override
	public void updatePassword(MemberVO member) {
		memberMapper.updatePassword(member);
	}

	@Override
	public void deleteMember(Integer mem_num) {
		//member, member_detail 둘 다 작업해줘야함
		memberMapper.deleteMember(mem_num); //업데이트
		memberMapper.deleteMember_detail(mem_num); //삭제
	}

	@Override
	public void updateProfile(MemberVO member) {
		memberMapper.updateProfile(member);
	}
	
	
	//관리자 전용
	@Override
	public List<MemberVO> selectList(Map<String, Object> map) { //1.회원목록처리

		return memberMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) { //2.총 레코드 수 처리

		return memberMapper.selectRowCount(map);
	}

	@Override
	public void updateByAdmin(MemberVO member) {
		memberMapper.updateByAdmin(member); //member쪽 테이블 업데이트
		memberMapper.updateDetailByAdmin(member); //member_detail쪽 업데이트
		//-> 어드민 컨트롤러가서 폼에서 전송된 데이터 업데이트 처리하러 ㄱ
	}

}
