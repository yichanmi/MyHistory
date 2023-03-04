<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 중앙 컨텐츠 시작 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		//마이페이지에서 프로필 사진 업로드 작업하기(ajax방식)
		$('#photo_btn').click(function(){
			//클릭시 사진 보여지게
			$('#photo_choice').show();
			$(this).hide(); //버튼은 숨겨지게
		});
		
		//처음 화면에 보여지는 이미지를 읽어 보관시키기
		let photo_path = $('.my-photo').attr('src');
		//변수 생성
		let my_photo;
		$('#upload').change(function(){ //사진 미리보기 처리하기
			my_photo = this.files[0];
			if(!my_photo){
				//파일 객체가 있어야 처리되는데 없다면 빠져나가게 -> 원래 이미지로 만들어주기 -> 이미지 올리기 취소시
				$('.my-photo').attr('src',photo_path);
				return; //change의 이벤트 핸들러를 빠져나가면 되므로 리턴만.
			}
			
			if(my_photo.size > 1024 * 1024){
				alert(Math.round(my_photo.size/1024) 
						+ 'kbytes(1024kbytes까지만 업로드 가능!)');
				$('.my-photo').attr('src',photo_path); //원래 이미지로 환원
				$(this).val(''); //파일 지워주기
				return;
			}
			
			//정상적으로 수행시 이미지 미리보기 처리해주기
			var reader = new FileReader();
			reader.readAsDataURL(my_photo);
			
			//이미지를 읽어오면 이벤트 발생하므로
			reader.onload=function(){
				$('.my-photo').attr('src',reader.result);
			};
		}); //end of change(이미지 미리보기 위해 한 코드들)
		
		//이미지 미리보기가 정상수행시 서버에 전송(서밋->photo_sumbit -> upload를 읽어다가 처리)
		$('#photo_submit').click(function(){
			if($('#upload').val()==''){ //파일선택x시
				alert('파일을 선택하세요!');
				$('#upload').focus();
				return;
			}
			
			//정상적으로 파일 선택시 파일 전송
			//파일 읽기
			var form_data = new FormData();
			//'upload':파라미터명 (프로퍼티명과 일치시켜야 호출 가능)
			form_data.append('upload',my_photo);//우리가 업로드할 파일의 키와 밸류(my_photo에 파일정보가 담김) 쌍으로 명시
			
			$.ajax({
				url:'updateMyPhoto.do',
				type:'post',
				data:form_data,
				dataType:'json',
				contentType:false,
				enctype:'multipart/form-data',
				processData:false,
				success:function(param){//멤버에이젝스클래스에서 
					if(param.result == 'logout'){
						alert('로그인 후 사용하세요!');
					}else if(param.result == 'success'){
						alert('프로필 사진이 수정되었습니다.');
						//정상적으로 수행시 수정된 사진으로 변경해야하므로 저장된 이미지파일정보를 가져옴(초기화 작업 먼저 작성)
						//초기화 작업1
						photo_path = $('.my-photo').attr('src');
						$('#upload').val('');
						$('#photo_choice').hide();
						$('#photo_btn').show(); //숨겨진 버튼을 보여지게끔 작업
					}else{
						alert('파일 전송 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류발생!');
				}
			});
		});//end of click(사진이 서버로 전송되는 버튼 클릭)
		
		//초기화 작업2
		$('#photo_reset').click(function(){
			$('.my_photo').attr('src',photo_path);
			$('#upload').val('');//파일명 지워주기
			$('#photo_choice').hide();
			$('#photo_btn').show();
		});
	});
</script>
<div class="page-main">
	<h2>프로필 사진</h2>
	<ul>
		<li>
			<c:if test="${empty member.photo_name}">
			<img src="${pageContext.request.contextPath}/resources/images/face.png" 
									width="200" height="200" class="my-photo">
			</c:if>
			<c:if test="${!empty member.photo_name}">
			<img src="${pageContext.request.contextPath}/member/photoView.do"
									width="200" height="200" class="my-photo">
			</c:if>
		</li>
		<li>
			<div class="align-center">
				<input type="button" value="수정" id="photo_btn">
			</div>
			<div id="photo_choice" style="display: none;"><!-- 보여지지않게 -->
				<input type="file" id="upload" accept="image/gif,image/png,image/jpeg">
				<input type="button" value="전송" id="photo_submit">
				<input type="button" value="취소" id="photo_reset"><!-- ajax처리 ㄱㄱ -->
			</div>
		</li>
	</ul>
	
	<h2>회원상세정보</h2>
	<ul>
		<li>이름 : ${member.name}</li>
		<li>전화번호 : ${member.phone}</li>
		<li>이메일 : ${member.email}</li>
		<li>우편번호 : ${member.zipcode}</li>
		<li>주소 : ${member.address1}</li>
		<li>상세주소 : ${member.address2}</li>
		<li>가입날짜 : ${member.reg_date}</li>
		<c:if test="${!empty member.modify_date}">
			<li>정보 수정일 : ${member.modify_date}</li>
		</c:if>
	</ul>
	<hr size="1" width="100%">
	<p class="align-right">
		<input type="button" value="회원정보수정" onclick="location.href='update.do'">
		<input type="button" value="비밀번호변경" onclick="location.href='changePassword.do'">
		<input type="button" value="회원탈퇴" onclick="location.href='delete.do'">
	</p>
</div>
<!-- 중앙 컨텐츠 끝 -->