<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> param 값 태그 필요 </title>
<%-- <c:out value="${param.title}"/> --%>


<!-- Gmarket Sans SDK -->
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<style>

/* 	스크롤 애니메이션 */
html {
	scroll-behavior: smooth;
}

/* 모든요소 margin, padding 초기화*/
* {
	margin: 0;
	padding: 0;
}

/* 배경 및 전체 폰트 적용 */
body {
	font-family: "GmarketSans";
	width: 100%;
	height: 860px;
	background: url('${pageContext.request.contextPath}/resources/img/background.png') no-repeat;
	background-size: cover;
}

/* 메인타이틀 div */
.title {
	/*border: 1px solid black; /*체크용 border*/
	width: 200px;
	margin-left: 450px;
	margin-top: 70px;
	display: flex; /*div를 flex 배치로 변경 */
	align-items: center; /* 수직 중앙 정렬 */
	justify-content: space-between; /* 좌우 간격을 자동으로 조정 */
}

/* 메인타이틀 text */
.main {
	font-size: 36px;
}

.main a {
	text-decoration: none;
	color: inherit;
}

/* 메인타이틀 로고 */
.logo {
	width: 48px;
	height: 48px;
	background: url('${pageContext.request.contextPath}/resources/img/timpill.svg') no-repeat;
	background-size: contain;
}

.menu1 {
	cursor: pointer;
	position: absolute;
	top: 86px;
	left: 690px;
	width: 121px;
	height: 36px;
	text-align: left;
	letter-spacing: 0px;
	color: #000000;
}

.menu2 {
	cursor: pointer;
	position: absolute;
	top: 86px;
	left: 885px;
	width: 121px;
	height: 36px;
	text-align: left;
	letter-spacing: 0px;
	color: #000000;
}

.menu3 {
	cursor: pointer;
	position: absolute;
	top: 86px;
	left: 1080px;
	width: 121px;
	height: 36px;
	text-align: left;
	letter-spacing: 0px;
	color: #000000;
}

.menu1 ul, .menu2 ul, .menu3 ul {
	display: block;
	position: absolute;
	top: 100%;
	left: -10px;
	width: 100%;
	background-color: rgba(255, 255, 255);
	padding: 10px;
	border: 1px solid #ddd;
	list-style-type: none;
	z-index: 1000;
	font-size: 13px;
	opacity: 0;
	transform: scaleY(0);
	transform-origin: top;
	transition: opacity 0.4s ease, transform 0.4s ease;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	height: auto;
	max-height: 300px;
	overflow-y: auto;
	text-align: center;
}

.menu1:hover ul, .menu2:hover ul, .menu3:hover ul {
	opacity: 1;
	transform: scaleY(1);
}

.menu1 ul li, .menu2 ul li, .menu3 ul li {
	border-radius: 4px;
	padding: 5px;
}

.menu1 ul li:hover, .menu2 ul li:hover, .menu3 ul li:hover {
	background-color: #f0f0f0;
}

.userStatus {
	position: absolute;
	top: 80px;
	left: 1290px;
	width: 270px;
	height: 48px;
	background: #173C6E;
	border-radius: 50px;
	opacity: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #FFFFFF;
	font-size: 14px;
}

.whiteBox {
	margin-top: 100px;
	margin-left: 20%;
	/* border: 1px solid black; /*체크용 border*/
	width: 60%;
	height: 70%;
	background-color: #FFFFFF;
	border-radius: 20px;
	overflow: auto;
}

#footer {
	margin-top: 80px;
	/* border: 1px solid black; 체크용 border */
	width: 100%;
	height: 80px;
	text-align: center;
}
</style>
</head>


<body>
	<header>

		<div class="title">
			<div class="logo"></div>
			<h1 class="main">
				<c:url var="mainUrl" value="/main"/>
				<a href="${mainUrl}">TimePill</a>
			</h1>
		</div>
		
		
		<nav class="GNB">
				<div class="menu1"> 
					<h3> 마이페이지 </h3>
					<ul class="menu1">
						<li>
							<c:url var="myPageUrl" value="/myPage" /> 
							<a href="${myPageUrl}">
								유저정보변경 
							</a>
						</li>
						<li>
							<c:url var="searchUrl" value="/member/search" /> 
							<a href="${searchUrl}"> 
								복용자관계등록 
							</a>
						</li>
						<li>
							<c:url var="mydeviceUrl" value="/mydevice" /> 
							<a href="${mydeviceUrl}"> 
								기기정보변경 
							</a>
						</li>
					</ul>
				</div> 
				
				
				<div class="menu2"> 
					<h3> 내 복약 정보 </h3>
					<ul class="menu2">
						<li>
							<c:url var="regUrl" value="/medication/schedule/list" /> 
							<a href="${regUrl}"> 
								알람 스케줄 등록
							</a>
						</li>
						
						<li>
							<c:url var="recordUrl" value="/record/list.do" />
							<form id="recordForm" action="#" method="get">
								<input type="hidden" name="takeDate" value="${today}" /> 
								<a href="#" onclick="document.querySelector('#recordForm').submit(); return false;">
									복약 기록 조회
								</a>
							</form>
						</li>
					</ul>
				</div> 

				<div class="menu3"> 
					<h3> 고객센터 </h3>
					<ul class="menu3">
						<li>
							<a href="#">공지사항 게시판</a>
						</li>
						<li>
							<a href="#">일대일 문의</a>
						</li>
					</ul>
				</div>
		</nav>

		<div class="userStatus">
			<div> 
				<c:choose> 
					<c:when test="${not empty loginUser.userName}"> <!-- 이름정보 있음 -->
						<c:out value="${loginUser.userName} 님 환영합니다."></c:out>
					</c:when>
					<c:otherwise> <!-- 이름정보 없음 -->
						<c:out value="${loginUser.userId}" /> 님 환영합니다.	
					</c:otherwise>
				</c:choose>
			</div> 
			
			<div> 
				<a href='${pageContext.request.contextPath}/user/login' class="logout">
					로그아웃 
				</a>
			</div>
		</div>
	</header>
	
<div class="whiteBox"> <!-- whiteBox 여는 태그-->




