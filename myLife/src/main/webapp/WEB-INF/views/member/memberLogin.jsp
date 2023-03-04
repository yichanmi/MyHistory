<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<style>
ul{list-style:none;}
form > .fields{margin: -2rem 0px 0rem -1.5rem;}
</style>
<!-- 중앙컨텐츠 시작 -->
<div id="wrapper">
	<section>
	<header>
		<h2>My Login Page</h2>
		<p><strong>My Login Page</strong><br> ONLY FOR ME.</p>
	</header>
	<div class="content">
	<form:form action="login.do" modelAttribute="memberVO" id="login_form" style="margin-top: 150px; margin-left: 150px;">
		<form:errors element="div" cssClass="error-color"/><!-- 필드에 의존하지않는 컬럼이 에러날때 표시 -->
		<div class="fields">
		<ul>
			<li>
				<div class="field half">
				<form:label path="id"></form:label>
				<form:input path="id" placeholder="ID"/>
				<form:errors path="id" cssClass="error-color"/>
				</div>
			</li>
			<li>
				<div class="field half">
				<form:label path="passwd"></form:label>
				<form:password path="passwd" placeholder="PASSWORD"/>
				<form:errors path="passwd" cssClass="error-color"/>
				</div>
			</li>
		</ul>
		</div>
		<div>
			<form:button cssClass="button primary">Login</form:button>
			<input type="button" value="Main" class="button primary" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
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
<!-- 중앙컨텐츠 끝-->