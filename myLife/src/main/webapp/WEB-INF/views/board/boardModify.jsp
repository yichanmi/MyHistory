<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<!-- 중앙 컨텐츠 시작 -->
<!-- ckeditor 라이브러리 넣기 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https//code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https//stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
ul{list-style:none;}
div.fields{width:483px;}
</style>
<!-- ckeditor 라이브러리 넣기 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor.js">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploadAdaptor.js">
</script>
<div id="wrapper">
<section>
	<header>
		<h2>Modify</h2>
	</header>
	<form:form modelAttribute="boardVO" action="update.do" id="update_form" enctype="multipart/form-data" style="margin-top: 150px; margin-left: 100px;">
		<!-- 글번호를 히든값으로 처리 -->
		<form:hidden path="board_num"/>
		<form:errors element="div" cssClass="error-color"/>
		<div class="fields">
		<ul>
			<li>
				<div class="field half">
				<form:label path="title"></form:label>
				<form:input path="title"/>
				<form:errors path="title" cssClass="error-color"/>
				</div>
			</li>
			<!-- <li><b>내용</b></li> -->
			<li style="margin-top:10px;">
				<form:textarea path="content"/>
				<form:errors path="content" cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#content' ),{
		            	extraPlugins: [MyCustomUploadAdapterPlugin]
		            })
		            .then( editor => {
						window.editor = editor;
					} )
		            .catch( error => {
		                console.error( error );
		            } );
			    </script>
			</li>
			<li>
				<div class="field half">
				<form:label path="upload"></form:label>
				<input type="file" name="upload" id="upload">
				<!-- 파일이 있는지 없는지 체크 -->
				<c:if test="${!empty boardVO.filename}"><!-- 업로드 한경우 -->
				<br>
				<span id="file_detail">(${boardVO.filename})파일이 등록되어 있습니다.
				다시 업로드하면 기존 파일은 삭제됩니다.
				<input type="button" value="파일삭제" id="file_del"><!-- 스크립트 ajax로 삭제처리 : boardMapper쪽 명시 -->
				</span>
<!-- 파일이 없을 때도 있으므로 이쪽에서 파일삭제 aJax통신 작업 스크립트 작성 시작 -->
<script type="text/javascript">
	$(function(){
		$('#file_del').click(function(){ //파일 삭제 버튼을 누를때 이벤트 발생
			let choice = confirm('삭제하시겠습니까?');
			if(choice){
				$.ajax({
					url:'deleteFile.do',
					data:{board_num:${boardVO.board_num}},
					type:'post',
					dataType:'json',
					cache:false,
					timeout:30000,
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인 후 사용하세요!');
						}else if(param.result == 'success'){
							$('#file_detail').hide(); //정상적으로 파일삭제시 기존에 등록된 파일정보 숨기기(지우기?)
						}else{
							alert('파일 삭제 오류 발생!');
						}
					},
					error:function(){
						alert('네트워크 오류 발생!');
					}
				});
			}
		});
	});
</script>
				</c:if>
				</div>
			</li>
		</ul>
		</div>
		<div class="align-center">
			<form:button cssClass="button primary">수정</form:button>
			<input type="button" value="목록" class="button primary" onclick="location.href='list.do'">
		</div>
	</form:form>
</section>
</div>
<!-- 중앙 컨텐츠 끝 -->