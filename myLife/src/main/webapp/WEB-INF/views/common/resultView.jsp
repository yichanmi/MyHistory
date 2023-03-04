<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	alert('${message}'); //문자열이기때문에 작은 따옴표 필수
	location.href='${url}' //BoardController에서 지정한 모델속성명
</script>