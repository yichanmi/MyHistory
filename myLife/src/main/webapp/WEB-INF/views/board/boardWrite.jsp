<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" /><link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<!-- 중앙 컨텐츠 시작 -->
<!-- 부트스트랩 라이브러리 넣어주기 : 링크걸기부터 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https//code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https//stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
ul{list-style:none;}
</style>
<!-- ckeditor 라이브러리 넣기 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor.js">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploadAdaptor.js">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
</script>
<div id="wrapper">
	<section>
		<header>
		<h2>Register Page</h2>
		</header>
		<div class="content">
		<form:form modelAttribute="boardVO" action="write.do" enctype="multipart/form-data" id="register_form" style="margin-top: 150px; margin-left: 150px;">
		<form:errors element="div" cssClass="error-color"/>
		<div class="fields">
		<ul>
			<li>
				<div class="field half">
					<form:label path="title"></form:label>
					<form:input path="title" placeholder="TITLE"/>
					<form:errors path="title" cssClass="error-color"/>
				</div>
			</li>

			<li style="margin-top:10px;">
				<form:textarea path="content" placeholder="CONTENTS"/>
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
					<form:errors path="upload" cssClass="error-color"/>
				</div>
			</li>
		</ul>
		</div>
		<div style="margin: -40px 0px 0px 30px;">
			<form:button cssClass="button primary">Write</form:button>
			<input type="button" value="List" class="button primary" onclick="location.href='list.do'">
		</div>
		</form:form>
	</div>
	</section>
</div>
			<!-- Scripts -->
			<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.scrolly.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/browser.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/breakpoints.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/util.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<!-- 중앙 컨텐츠 끝 -->