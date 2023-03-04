<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<style>
	ul{list-style:none; padding-left: 1.5rem;}
	td{margin: 0; padding: 0; border: 0; font-size: 100%; font: inherit; vertical-align: middle; text-align: center;}
	table th {padding: 10px 3rem 0.75rem 3rem; text-align: center;}
	#wrapper section > .content{padding: 30px 2rem;}
	select#keyfield {margin-bottom: 7px;width: calc(120% - 25px);}
	form#search_form {display: inline-table;}
</style>
<!-- 중앙 컨텐츠 시작 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.scrolly.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/browser.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/breakpoints.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/util.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		//검색어 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()=''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div id="wrapper">
<section>
	<header>
	<h2>My List</h2>
	<p><strong>See more</strong><br>희망연봉, 입사시기, 고용형태 등...</p>
	</header>
	<div class="content">
	<form action="list.do" id="search_form" method="get" style="border:none;">
		<ul class="search" style="display:flex;">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>ID</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
					<option value="4" <c:if test="${param.keyfield == 4}">selected</c:if>>제목+내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="Search" class="button primary" style="padding: 2px 15px;width: calc(120% - 15px);height: 50px;">
			</li>
		</ul>
	</form>
	<br>
		<div class="align-right3">
			<c:if test="${empty user_num}">
				<input type="button" value="Login" class="button primary" onclick="location.href='${pageContext.request.contextPath}/member/login.do'">
			</c:if>
			<!-- 로그인이 되있는 상태라면 보여지게(글을 쓸 수 있게) -->
			<c:if test="${!empty user_num}">
				<input type="button" value="Write" class="button primary" onclick="location.href='write.do'" style="margin-right: 5px;width: 80px;padding: 2px 10px;">
			</c:if>
			
				<input type="button" value="Main" onclick="location.href='${pageContext.request.contextPath}/main/main.do'" style="width: 80px;padding: 0 10px;">
		</div>
	
			<!-- 로그인이 되있는 상태라면 보여지게(글을 쓸 수 있게) -->
		<%-- <c:if test="${!empty user_num}">
		<div class="align-right2">
			<input type="button" value="Write" onclick="location.href='write.do'" style="margin-right: 5px;width: 80px;padding: 2px 10px;">
		</div>
		</c:if> --%>
	
	<c:if test="${count == 0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<table class="list-table">
			<tr>
				<!-- <th>번호</th> -->
				<th>My Photo</th>
				<th width="400">Title</th>
				<!-- <th>작성자</th> -->
				<!-- <th>작성일</th> -->
				<!-- <th>조회수</th> -->
			</tr>
			<c:forEach var="board" items="${list}">
			<tr>
				<%-- <td>${board.board_num}</td> ${not empty board.filename}--%>
				<c:choose>
					<c:when test="${fn:endsWith(board.filename,'.jpg') ||
									fn:endsWith(board.filename,'.JPG') ||
						            fn:endsWith(board.filename,'.gif') ||
						            fn:endsWith(board.filename,'.GIF') ||
						            fn:endsWith(board.filename,'.png') ||
						            fn:endsWith(board.filename,'.PNG')}">
						<td style="width:230px; height:230px;">
							<img src="imageView.do?board_num=${board.board_num}" style="width:230px; height:190px;">
						</td>
					</c:when>
					<c:otherwise>
						<td style="width:230px; height:230px;"><img src="https://3.bp.blogspot.com/-WhBe10rJzG4/U4W-hvWvRCI/AAAAAAAABxg/RyWcixpgr3k/s1600/noimg.jpg" style="width:230px; height:230px;"></td>
					</c:otherwise>
				</c:choose>
				<td><a href="detail.do?board_num=${board.board_num}">${board.title}</a></td>
				<%-- <td>${board.id}</td> --%>
				<%-- <td>${board.reg_date}</td> --%>
				<%-- <td>${board.hit}</td> --%>
			</tr>
			</c:forEach>
		</table>
		<div class="align-center">
		${pagingHtml}
		</div>
	</c:if>
	</div>
</section>
</div>
<!-- 중앙 컨텐츠 끝 -->