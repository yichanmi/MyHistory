<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!-- 중앙 컨텐츠 시작 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/board.reply.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.scrolly.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/browser.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/breakpoints.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/util.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<style>
	ul{list-style:none;}
	section#reply{display: flex;float: right;/* margin: 38px -26px 10px 26px; */}
</style>
<div id="wrapper">
<section>
	<header>
	<h2>${board.title}</h2>
	</header>
	<div class="content" style="padding: 20px 4rem;">
	<ul>
		<%-- <li>번호 : ${board.board_num}</li> --%>
		<li>작성자 : ${board.id}</li>
		<li>조회수 : ${board.hit}</li>
		<c:if test="${!empty board.modify_date}">
		<%-- <li>최근 수정일 : ${board.modify_date}</li> --%>
		</c:if>
		<li>작성일 : ${board.reg_date}</li>
		<c:if test="${!empty board.filename}">
			<li>첨부파일 : <a href="file.do?board_num=${board.board_num}">${board.filename}</a></li>
		</c:if>
	</ul>
		<p>
			${board.content}
		</p>
	</div>
	</section>
	
	<c:if test="${fn:endsWith(board.filename,'.jpg') ||
	              fn:endsWith(board.filename,'.JPG') ||
	              fn:endsWith(board.filename,'.gif') ||
	              fn:endsWith(board.filename,'.GIF') ||
	              fn:endsWith(board.filename,'.png') ||
	              fn:endsWith(board.filename,'.PNG')}">
	<div class="align-center">
		<img src="imageView.do?board_num=${board.board_num}" style="max-width:500px;">
	</div>
	</c:if>
	<c:if test="${empty fn:endsWith(board.filename,'.jpg') ||
	              empty fn:endsWith(board.filename,'.JPG') ||
	              empty fn:endsWith(board.filename,'.gif') ||
	              empty fn:endsWith(board.filename,'.GIF') ||
	              empty fn:endsWith(board.filename,'.png') ||
	              empty fn:endsWith(board.filename,'.PNG')}">
	              <div class="align-center">
	              	<img src="imageView.do?board_num=${board.board_num}" style="max-width:500px;display:none;">
	              </div>
	</c:if>
	<div id="re-btn">
		<c:if test="${!empty user_num && user_num == board.mem_num}">
		<input type="button" value="수정" id="update_btn" class="button primary"
		onclick="location.href='update.do?board_num=${board.board_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('delete.do?board_num=${board.board_num}');
				}
			};
		</script>
		</c:if>
			<input type="button" class="test1-btn" value="목록" onclick="location.href='list.do'">
	</div>
	
	<div id="reply_div">
		<span class="re-title">Comments</span>
		<!-- 댓글 폼 작성 -->
		<form id="re_form">		<!-- name = 부모글 번호 식별 / 조건 체크까지-->
			<input type="hidden" name="board_num" value="${board.board_num}" id="board_num">
			<textarea rows="3" cols="50" name="re_content" id="re_content" class="rep-content"
			<c:if test="${empty user_num}">disabled="disabled"</c:if>
			><c:if test="${empty user_num}">로그인해야 작성할 수 있습니다.</c:if></textarea>
			
			<c:if test="${!empty user_num}">
				<div id="re_second" class="align-right2">
					<input type="submit" value="전송" />
				</div>	
					<c:if test="${empty user_num}">
						<input type="submit" value="전송" style="margin: 7px 0px 0px -40px;padding: 0px 25px;height:60px;">
					</c:if>
			</c:if>
			
			<c:if test="${!empty user_num}">
				<div id="re_first">
					<span class="letter-count">300/300</span>
				</div>	
			</c:if>
		</form>
	</div>
	
	<!-- 댓글 목록 출력(표시) -->
	<c:if test="${fn:endsWith(board.filename,'.jpg') ||
	              fn:endsWith(board.filename,'.JPG') ||
	              fn:endsWith(board.filename,'.gif') ||
	              fn:endsWith(board.filename,'.GIF') ||
	              fn:endsWith(board.filename,'.png') ||
	              fn:endsWith(board.filename,'.PNG')}">
				<div id="output"></div><!-- style="margin-top: 30px;" -->
	</c:if>
				<div id="output""></div> <!-- style="margin-top: 120px; -->
				
	<div class="paging-button" style="display: none;">
		<input type="button" value="다음글 보기">
	</div>
	
	<div id="loading" style="display: none;">
		<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
	</div>
</div>
<!-- 중앙 컨텐츠 끝 -->