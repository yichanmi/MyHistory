<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CMLee<%-- <tiles:getAsString name="title"/> --%></title><!-- 설정에 의해 제목이 바뀔수 있으므로 -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style2.css"> --%>
</head>
<body>
<div id="main">
	<div id="main_header">
		<tiles:insertAttribute name="header"/>
	</div>
	<div id="main_menu">
		<tiles:insertAttribute name="left"/>
	</div>
	<div id="main_body">
		<tiles:insertAttribute name="body"/>
	</div>
	<div id="main_footer">
		<tiles:insertAttribute name="footer"/>
	</div>
</div>
</body>
</html>