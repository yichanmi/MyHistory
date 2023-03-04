<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Let Me Introduce Myself</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
		<style>
			.z-index{z-index:1;}
			form {border: none;}
		</style>
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Intro -->
					<section class="intro">
						<header>
							<h1>HELLO!<br>LEE<br> CHAN MI</h1>
							<p>Let Me Introduce Myself!</p>
							<ul class="actions">
								<li><a href="#first" class="arrow scrolly"><span class="label">Next</span></a></li>
							</ul>
						</header>
						<div class="content">
							<span class="image fill" data-position="center"><img src="${pageContext.request.contextPath}/resources/images2/hanbok.jpg" /></span>
						</div>
					</section>
					
				<!-- Section -->
					<section>
						<header>
							<h2>Basic Information</h2>
							<p>Name, Birth Date, etc..</p>
							<span><b>이 찬 미</b></span><br><br>
							<span><b>1997.03.22.</b></span><br><br>
							<span><b>웹 개발자</b>(예정)</span><br>
						</header>
						<div class="content">
							<p><strong>#HashTag</strong><br><strong>#PICKMEUP</strong>&nbsp;#내사진 #이름 #나이 #주소 #연락처 <strong>#엄청난개발자</strong>(예정) #27살 #이찬미 #이메일 #ESFP</p>
							<div id="img_area" style="position:relative;">
							<img src="${pageContext.request.contextPath}/resources/images/me.png" class="img1 z-index" style="width:calc(500px - 10%);height:calc(400px - 100px);"/>
							<img src="${pageContext.request.contextPath}/resources/images/lcm1.png" class="img2" style="width:calc(500px - 10%);height:calc(400px - 100px);display:none;"/>
							<img src="${pageContext.request.contextPath}/resources/images/27.png" class="img3" style="width:calc(500px - 10%);height:calc(400px - 100px);display:none;"/>
							<img src="${pageContext.request.contextPath}/resources/images/me3.jpg" class="img4" style="width:calc(500px - 10%);height:calc(400px - 100px);display:none;"/>
							</div>
						</div>
					</section>
					
				<!-- Section -->
					<section>
						<header>
							<h3><b>Academic Background & Career</b></h3>
							<p><b>학력 및 경력사항 정보</b></p>
							<span>◆ 2016.03 ~ 2019.02<br>서일대 정보통신공학과 졸업</span><br><br>
							<span>◆ 2016.03 ~ 2020.02<br>서일대 전기공학과 학과조교 근무</span><br><br>
							<span>◆ 2020.03 ~ 2021.08<br>한림대학교 데이터과학융합스쿨<br>데이터테크전공 편입 후 졸업</span><br><br>
							<span>◆ 2022.04 ~ 2022.12<br>(주)윌비소프트 솔루션사업부 SM팀 사원</span><br>
						</header>
						<div class="content">
							<div class="gallery">
								<a href="${pageContext.request.contextPath}/resources/images/hallym.jpg" class="full-img9"><img src="${pageContext.request.contextPath}/resources/images2/gallery/thumbs/09.jpg" alt="최종학력" /><span class="gallary-text9" style="width:500px;"><b>최종학력 증명서<br>(Click!)</b></span></a>
								<a href="${pageContext.request.contextPath}/resources/images/operation_SM.png" class="full-img10"><img src="${pageContext.request.contextPath}/resources/images2/gallery/thumbs/10.jpg" alt="경력" /><span class="gallary-text10" style="width:900px;"><b>Represent<br>WebSite(SM)</b></span></a>
							</div>
						</div>
				</section>

				<!-- Section -->
					<section>
						<header>
							<h2>Main Skill</h2>
						</header>
						<div class="content">
							<p><strong>Development Environment Tools Used</strong> <br>Other tools I've used... MyBatis, Tomcate, Github, GitLab, Jquery ...</p>
							<ul class="feature-icons">
								<li class="icon solid fa-code">JAVA</li>
								<li class="icon solid fa-code">JAVASCRIPT</li>
								<li class="icon solid fa-code">JSP</li>
								<li class="icon solid fa-code">ORACLE</li>
								<li class="icon solid fa-code">SPRINGFRAMEWORK</li>
								<li class="icon solid fa-code">HTML/CSS</li>
							</ul>
						</div>
					</section>

				<!-- Section -->
					<section>
						<header>
							<h2>A letter of self-introduction</h2>
						</header>
						<div class="content">
							<p><strong>자기소개서</strong><br>INTRODUCE YOURSELF.</p>

							<!-- Section -->
								<section>
									<header>
										<h3>◆ Sequence</h3>
										<p>1. 성장과정<br> 2. 업무역량<br>3. 성격 장/단점<br>4. 입사 후 포부</p>
									</header>
									<div class="content">
										<div class="gallery">
											<a href="${pageContext.request.contextPath}/resources/images/condition1.PNG" class="landscape full-img9"><img src="${pageContext.request.contextPath}/resources/images/condition1.PNG" alt="1.성장과정" /><span class="gallary-text1"><b>성장과정</b></span></a>
											<a href="${pageContext.request.contextPath}/resources/images/condition2.PNG" class="full-img2"><img src="${pageContext.request.contextPath}/resources/images/condition2.PNG" alt="2.업무관련 역량" /><span class="gallary-text2" style="width:900px;"><b>업무역량</b></span></a>
											<a href="${pageContext.request.contextPath}/resources/images/condition3.PNG" class="full-img3"><img src="${pageContext.request.contextPath}/resources/images/condition3.PNG" alt="3. 성격 장/단점" /><span class="gallary-text3" style="width:900px;"><b>성격 장/단점</b></span></a>
											<a href="${pageContext.request.contextPath}/resources/images/condition4.PNG" class="landscape full-img4"><img src="${pageContext.request.contextPath}/resources/images/condition4.PNG" alt="4.입사 후 포부" /><span class="gallary-text4"><b>입사후 포부</b></span></a>
										</div>
									</div>
								</section>

							<!-- Section -->
								<section>
									<header>
										<h3>◆ Activity</h3>
										<p>2021.10.27. ~ 2022.04.11.<br>[쌍용강북교육센터]<br> 국가기간•전략산업직종훈련(Java기반 풀스택 웹 개발 과정)‘(디지털컨버전스)데이터 분석기법을 활용한데이터융합 개발자 양성과정(A)’<br> 이수(112일, 896시간)</p>
									</header>
									<div class="content">
										<div class="gallery">
											<a href="${pageContext.request.contextPath}/resources/images/ssangyong.PNG" class="paperfile"><img src="${pageContext.request.contextPath}/resources/images/ssangyong.PNG" class="paperfile" /></a>
										</div>
									</div>
								</section>

						</div>
					</section>

				<!-- Section -->
					<section>
						<header>
							<h2>A desired salary</h2>
							<p>희망연봉, 고용형태 등</p>
						</header>
						<div class="content">
							<p><strong>See more Other Information</strong><br>
							<c:if test="${empty user_num}">로그인 없이 보러가기</c:if>
							<c:if test="${!empty user_num}">"GO LIST" Button Click !</c:if>
							</p>
							<ul class="actions">
								<li><a href="${pageContext.request.contextPath}/board/list.do" class="button primary large">Go List</a></li>
								<li><a href="#" class="button large">Go Top</a></li>
							</ul>
						</div>
					</section>

				<!-- Section -->
					<section>
						<header>
							<h2>BESIDES..</h2>
						</header>
						<div class="content">
							<c:if test="${empty user_num}"><p><strong>◆ 게시물 등록시 아래 Login버튼 먼저 클릭해주세요</strong></p></c:if>
							<c:if test="${!empty user_num}"><p><strong>◆ 글 등록은 아래 Write버튼부터 먼저 클릭해주세요</strong></p></c:if>
							<form action="write.do" method="get" id="register_form" enctype="multipart/form-data">
								<div class="fields">
									<div class="field half">
										<input type="text" name="title" id="title" placeholder="세부 정보는" />
									</div>
									<div class="field">
										<textarea name="content" id="content" placeholder="위 GO LIST버튼 클릭!" rows="7"></textarea>
									</div>
								</div>
								<c:if test="${!empty user_num}">
								<ul class="actions">
									<li><input type="button" value="Write" class="button primary" onclick="alert('글쓰기 페이지로 이동!'); location.href='${pageContext.request.contextPath}/board/write.do'" /></li>
									<li><input type="button" value="Logout" class="button primary" onclick="alert('로그아웃 완료!'); location.href='${pageContext.request.contextPath}/member/logout.do'" /></li>
								</ul>
								</c:if>
								<c:if test="${empty user_num}">
								<ul class="actions">
									<li><input type="button" value="Login" class="button primary" onclick="alert('페이지 이동! \n로그인이 안된 경우 user / 1234로 입력해주세용'); location.href='${pageContext.request.contextPath}/board/write.do'" /></li>
									<li><a href="${pageContext.request.contextPath}/member/registerUser.do" class="button primary">Join</a></li>
								</ul>
								</c:if>
							</form>
						</div>
						<footer>
							<ul class="items">
								<li>
									<h3>Email</h3>
									<a href="#">skn1059@naver.com</a>
								</li>
								<li>
									<h3>Phone</h3>
									<a href="#">010-4150-1536</a>
								</li>
								<li>
									<h3>Elsewhere</h3>
									<ul class="icons">
										<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
										<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
										<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
										<li><a href="#" class="icon brands fa-linkedin-in"><span class="label">LinkedIn</span></a></li>
										<li><a href="#" class="icon brands fa-github"><span class="label">GitHub</span></a></li>
										<li><a href="#" class="icon brands fa-codepen"><span class="label">Codepen</span></a></li>
									</ul>
								</li>
							</ul>
						</footer>
					</section>
				<!-- Copyright -->
					<div class="copyright">&copy; Untitled. All rights reserved. Design: <a href="https://html5up.net">HTML5 UP</a>.</div>
			</div>

		<!-- Scripts -->
			<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.scrolly.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/browser.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/breakpoints.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/util.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
			<script type="text/javascript">
			$(function() {
				$("a.landscape.full-img1").click(function() {
					$(".inner img").css('width','1300px');
					$(".inner-text").text('저는 어려서부터 부모님으로부터 항상 자신감있고 안좋은 일이 있어도 기죽지말고 살라는 말씀을 자주 해주셨습니다. 하지만 자신감 부족과 소심한 성격으로 인해 자기주도적인 성격을 가지고 있지 않아 방황을 많이 하였습니다. 무엇이 하고 싶은건지, 어떤 것을 해야할지 방향성을 못잡고 정보통신공학과를 졸업하였습니다. 그 뒤 1년 계약의 행정조교 생활마저 하고 싶어서가 아닌 교수님 제안이었습니다. 스스로에 대한 자신감 부족과 취업 압박감으로 슬럼프를 겪었으나 제가 무언가를 해야겠다라고 결심이 생긴 것은 조교계약종료 직전이었습니다. 계속 슬럼프에 빠질 것 같은 위기감으로 무엇이라도 해보자라고 결심하여 첫 번째로 실천한 것은 데이터테크전공 학사취득이었습니다. 하지만 학사취득을 하고도 취업에 대한 방향성을 찾질 못했지만 한가지 확실했던 것은 대학전공을 살려 IT관련 업무를 하고 싶다는 열망이 생겼습니다. 그러다 슬럼프에 빠졌던 것은 실무에 대한 경험 및 지식 부족으로 인한 자신감 하락과 두려움이었다는 것을 깨닫고, 저는 그 슬럼프를 극복하기 위해 두 번째로는 풀스택 국비수료과정을 수료하였습니다. 국비과정을 수료하면서 프로그래밍 언어를 더 자세히 경험을 했고 자바, 스프링프레임워크, SQL, JSP, 자바스크립트 등으로 웹 개발에 관심이 생겼습니다. 되었습니다. 국비과정을 통해 팀 프로젝트로 물품구매사이트, CGV영화 예매 클론사이트를 완성시키는 과정에서 처음으로 제 스스로가 주도적으로 무언가를 해내고자하는 모습을 발견할 수 있었을 뿐만 아니라 의사소통하는 방법을 알았으며, 협업의 중요성을 배우게 되었습니다. 그리고 웹 개발이라는 취업 목표가 생김과 동시에 자신감이 생겨 슬럼프도 많이 극복하게 되었습니다. 저 같은 경우는 웹 개발을 하는 과정에서 내면과 외면 둘 다 성장하게 된 계기라고 할 수 있습니다.');
				})
				
				$("a.full-img2").click(function() {
					$(".inner img").css('width','1200px');
					$(".inner-text").text('저는 개발자로서 필요한 기본적인 개발 역량을 갖추고 있습니다.최종 프로젝트로 CGV 웹사이트를 벤치마킹한 웹사이트를 SpringFrameWork 구조로 구축하였습니다.그중 제가 맡은 부분은 CGV 극장 부분과 HTML/CSS로 디자인 처리 작업을 맡게 되었습니다. 벤치마킹할 영화예매 사이트는 여러 지역에 상영관 하나로 일주일 동안 동일한 영화만 상영하되 상영시간을 각각 다르게 하는 것으로 진행하였습니다. 극장 페이지를 구현하기 위해서 Mybatis와 JavaScript, Ajax 그리고 jsp를 사용하였습니다. 첫 번째로 홈페이지 디자인 구조를 CGV사이트 소스를 따와 적용하였고, 데이터를 넣어줄 수 있는 입력폼 코드를 작성하였습니다. 그리고 지역과 지점 정보, 상영정보, 좌석 정보 리스트들이 클릭할 때 리스트 정보가 변동될 수 있게끔 필요한 데이터를 Ajax를 통해 리스트들을 출력하였습니다. 영화예매는 사용자가 원하는 날짜, 시간대에 맞춰서 예매하므로 자바스크립트를 이용해 오늘 날짜부터 7일 뒤까지 날짜를 출력하는 함수로 날짜 데이터를 구현하였습니다. 이를 통해 날짜 버튼 클릭시 극장별 상영정보들을 출력되게 작업하였습니다. 그리고 마무리로 팀원들과 소통하여 미완성된 페이지의 UI부분을 보완하여 발표까지 잘 마무리되었습니다. 최종 프로젝트의 경험을 가지고 LMS솔루션 회사에 입사하여 SM운영 업무를 맡게 되었습니다. 대표적으로 1. 일정 횟수 로그인 실패시 계정잠금 처리 기능, 2. 웹 취약점 관련 파라미터 변조 공격에 대해 JavaScript/Jquery로 조건 추가, 3. 부모사이트에서 호출된 iframe에 대한 context.xml수정으로 samesite 설정, 4. 개인정보 마스킹 처리(xml), 5. 우편번호 스크립트관련 이슈 수정 등 이 밖에도 운영서버에 빌드 및 소스반영을 위한 배포하기 위해 putty, 파일질라, gitLab를 이용하였습니다.');
				})
				
				$("a.full-img3").click(function() {
					$(".inner img").css('width','1200px');
					$(".inner img").css('height','1100px');
					$(".inner-text").text('저는 MBTI가 ESFP입니다. 네이버 지식백과에서는 사교적이고 친절하며 사람들과 함께 즐겁게 일을 하는 것을 좋아한다고 요약돼있습니다. 모든 회사는 팀 단위로 구성하여 업무를 하게 됩니다. 저는 업무를 진행하면서 소통과 협업을 중요하게 생각하고 협업하면서 결과를 만드는 과정에서 보람을 느낍니다. 이 점은 프로그램 고객 요구사항에 맞춰 정확하게 개발하는데 있어 큰 장점이라 생각합니다. LMS 시스템의 운영 및 유지보수 업무를 진행하면서 콘텐츠 학습 시 재생 바 제어 금지 요청을 받았습니다. 운영사이트는 수강 기간/수강 종료/첫 영상 학습/진도율로 인한 학습/복습 조건 때문에 어떤 식으로 적용해야 할지 모호했습니다. 그래서 각 조건의 학습일 때 어떤 식으로 제어가 되는지를 파악 후, 필요한 데이터를 프론트 개발자분께 전달해 드려 영상 재생 바 제어할 수 없게끔 하였습니다. 그리고 테스트 결과화면을 콘텐츠 팀장님께 보고 및 처리방안에 대한 방향을 요청했습니다. 이후, 콘텐츠 팀장님께서 고객사 담당자분께 말씀하여 상황을 정리해주셨습니다. 만약 처리 방향 요청을 하지않았다면 고객사가 원하지 않는 결과를 베포하여 반영하는 실수를 했을 것입니다. 이 경험을 통해 소통의 중요성을 느끼게 되었고 협업과 의사소통을 하면서 일을 하는 것이 즐거웠습니다. 이것은 업무진행에서 저의 성향이 장점이 되리라 믿습니다. 하지만 협업을 하면서 어려웠던 점이 다른 사람들과 이해하고 있는 범위가 달라 잘못 이해하거나 이해한 것을 잊어버렸던 적도 있었습니다. 그래서 저는 아직도 제가 이해하고 있는지를 재확인을 받고 이해한 내용을 잊지 않기 위해 메모를 하여 기록하는 습관을 만들어 단점을 극복하기 위해 노력하고 있습니다.');
				
				$("a.full-img4").click(function() {
					$(".inner img").css('width','1300px');
					$(".inner img").css('height','1100px');
					$(".inner-text").text('대표적으로 두가지를 말씀드리겠습니다. 회사에 입사하게 되면 성장형 인재가 되겠습니다.성장형 인재가 되기 위해서 저는 이번년도에 정보처리기사 자격증을 취득할 것입니다.그 이유는 정보처리기사 자격증을 취득하는 과정에서 개발 및 테스트, 소통, 검증 등 업무에 필요한 지식이나 개념 등을 습득하는 과정을 통해 스스로가 풀스택 개발자에 대해 한걸음 다가섰다고 생각합니다. 실제로도 정보처리기사 교재 내용은 실무에서도 많이 쓰이는 용어나 개념이 많이 기록되어 있기 때문에 이 자격증을 취득했다는 것은 개인이 노력하여 성장했다는 결과물이 될 수 있다고 생각합니다. 개인의 성장은 회사의 성장이기 때문에 회사에 꼭 필요로하는 인재가 되는 것이 목표입니다.두 번째로 풀스택 개발을 할 수 있는 인재가 되겠습니다.풀스택이 되기위해 반복적인 Java와 JavaScript 학습을 꾸준히 병행할 것입니다. 또한 프론트엔드 기술을 배울 생각합니다. 당연히 java언어는 계속해서 반복학습이 필요한 점을 제 스스로가 알고있었지만 프론트 기술의 중요성도 느꼈기 때문입니다. 그 이유는 최근에 리액트나 vue.js를 사용하는 기업이 많아졌을 뿐만 아니라 아직 jsp 기술만 사용해봤기 때문입니다. 풀스택 개발자가 된다면 프론트단과 백단의 의사소통이 원활히 이루어질 수 있기때문에 jsp뿐만이 아니라 프론트 기술도 학습해야 할 필요성을 느꼈습니다. 다른 작업자들과 의사소통이 된다는 것은 그만큼 업무 이해도가 높기 때문에 가능한 점이라 생각합니다. 그래서 새로운 기술 습득 또한 제 스스로가 성장했다는 결과물이 될 수 있다고 판단합니다.');
				})
				
				$("a.full-img9").click(function() {
					$(".inner img").css('width','700px');
					$(".inner img").css('height','1100px');
					$("span.inner-text").text('gdgd');
				})
				$("a.full-img10").click(function() {
					$(".inner img").css('width','700px');
					$(".inner img").css('height','1100px');
					$("span.inner-text").text('[ CGV영화예매사이트 : https://github.com/sojiniya/movieProject.git ]');
				})
			});
			</script>
	</body>
</html>