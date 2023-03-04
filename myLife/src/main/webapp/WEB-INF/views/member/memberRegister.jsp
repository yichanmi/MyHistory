<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<style>
ul{list-style:none; padding-left: 1.5rem;}
form > .fields{margin: -2rem 0px 0rem -2rem;}
</style>
<!-- 중앙 컨텐트 시작 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		let checkId = 0;
		
		//아이디 중복 체크
		$('#confirmId').click(function(){
			if($('#id').val().trim()==''){
				$('#message_id').css('color','red').text('아이디를 입력하세요');
				$('#id').val('').focus();
				return;
			}
			
			$.ajax({
				url:'confirmId.do',
				type:'post',
				data:{id:$('#id').val()},
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'idNotFound'){
						$('#message_id').css('color','#000').text('등록가능ID');
						checkId = 1;
					}else if(param.result == 'idDuplicated'){
						$('#message_id').css('color','red').text('중복된ID');
						$('#id').val('').focus(); //새로 입력할수있도록 지워주는 작업
						checkId = 0;
					}else if(param.result == 'notMatchPattern'){
						$('#message_id').css('color','red').text('영문,숫자4~12');
						$('#id').val('').focus();
						checkId = 0;
					}else{
						checkId = 0;
						alert('ID중복체크 오류');
					}
				},
				error:function(){
					checkId = 0;
					alert('네트워크 오류 발생');
				}
			});
		});//end of click
		
		//아이디 중복 안내 메세지 초기화 및 아이디 중복 값 초기화
		$('#register_form #id').keyup(function(){
			checkId=0;
			$('#message_id').text(''); //메세지 초기화
		});
		
		//submit이벤트 발생시 아이디 중복 체크 여부 확인
		$('#register_form').submit(function(){
			if(checkId==0){
				$('#message_id').css('color','red').text('아이디 중복 체크 필수');
				if($('#id').val().trim()==''){
					$('#id').val('').focus();
				}
				return false;
			}
		});
	});
</script>
<div id="wrapper">
<section>
	<header>
	<h2>Join Page</h2>
	</header>
	<div class="content">
	<form:form action="registerUser.do" modelAttribute="memberVO" id="register_form" style="margin-top: 150px; <%-- margin-left: 150px; --%>">
		<form:errors element="div" cssClass="error-color"/><!-- 필드가 없는 에러 발생시 표시 -->
		<div class="fields" style="width: 375px;">
		<ul class="id-chk" style="display:flex;flex-wrap: wrap;list-style: none;margin-bottom: 0px;">
			<li>
				<div class="field half">
				<form:label path="id"></form:label>
				<form:input path="id" placeholder="ID는 영문,숫자4~12"/>
				</div>
			</li>
			<li>
				<input type="button" id="confirmId" value="ID중복체크" style="margin-top: 18px;padding:2px 10px;"/>
			</li>
			<li>
				<!-- 자바스크립트 체크 처리 -->
				<span id="message_id"></span>
				<form:errors path="id" cssClass="error-color"/>
			</li>
		</ul>
		<br>
		<ul>
			<li>
				<div class="field half">
				<form:label path="passwd"></form:label>
				<form:password path="passwd" placeholder="PWD는 영문,숫자 4~12"/>
				<form:errors path="passwd" cssClass="error-color"/>
				</div>
			</li>
			<li>
				<div class="field half">
				<form:label path="name"></form:label>
				<form:input path="name" placeholder="USER NAME"/>
				<form:errors path="name" cssClass="error-color"/>
				</div>
			</li>
			<%-- <li>
				<form:label path="phone">전화번호</form:label>
				<form:input path="phone"/>
				<form:errors path="phone" cssClass="error-color"/>
			</li> --%>
			<%-- <li>
				<div class="field half">
				<form:label path="email"></form:label>
				<form:input path="email" placeholder="EMAIL"/>
				<form:errors path="email" cssClass="error-color"/>
				</div>
			</li> --%>
		<%-- 	<li>
				<form:label path="zipcode">우편번호</form:label>
				<form:input path="zipcode"/>
				<input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기">
				<form:errors path="zipcode" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="address1">주소</form:label>
				<form:input path="address1"/>
				<form:errors path="address1" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="address2">상세주소</form:label>
				<form:input path="address2"/>
				<form:errors path="address2" cssClass="error-color"/>
			</li> --%>
		</ul>
		</div>
		<div>
			<form:button cssClass="button primary">Register</form:button>
			<input type="button" class="button primary" value="Main" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</form:form>
	</div>
	</section>
<!-- 우편번호 스크립트 시작 -->
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.scrolly.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/browser.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/breakpoints.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/util.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
<!-- 우편번호 스크립트 끝 -->
</div>
<!-- 중앙 컨텐트 끝 -->