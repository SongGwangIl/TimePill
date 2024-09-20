<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title><c:out value="${param.title}"/></title>

<!-- Gmarket Sans SDK -->
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">

<!-- Noto Sans Kor SDK-->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

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
	/* border: 1px solid black; /*체크용 border */
	margin-right: 20px;
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
	width: 55px;
	height: 55px;
	background: url('${pageContext.request.contextPath}/resources/img/timpill.svg') no-repeat;
	background-size: contain;
}

#GNB {
	margin: 0 auto;
	margin-top: 2%;
	margin-bottom: 3%;
	display: flex;
	height: 150px;
	width: 70%;
	/* border: 1px solid black; /*체크용 border*/
	align-items: center; /* 수직 중앙 정렬 */
	justify-content: space-between; /* 좌우 간격을 자동으로 조정 */
}

/* menu div */
.menubox {
	cursor: pointer;
	margin: 0 auto;
	/* border: 1px solid black; /*체크용 border*/
	width: 200px;
	height: 40px;
	text-align: center;
	letter-spacing: 0px;
	color: #000000;
	font-size: 22px;
	font-weight: 700;
	display: flex;
	justify-content: center; /* 수평 정렬 */
	align-items: center; /* 수직 정렬 */
	position: relative; /* 하위 요소 absolute 사용시 기준점 */
}

.menubox h3 {
	width: 100%;
	height: 100%;
	margin: 0;
	display: flex; /* Flexbox 설정 추가 */
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
}

.menubox ul {
	margin: 0 auto;
	width: 70%;
	background-color: rgba(255, 255, 255, 0.7); /* 투명도 50% */
	padding: 20px;
	border: 1px solid #ddd;
	list-style-type: none;
	z-index: 1000;
	font-size: 16px;
	font-weight: 600;
	transform: scaleY(0);
	transform-origin: top;
	transition: opacity 0.4s ease, transform 0.4s ease;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	height: auto;
	max-height: 300px;
	overflow-y: auto;
	text-align: center;
	position: absolute;
	top: 100%; /* 부모 요소의 바로 아래에 위치 */
}

.menubox:hover ul {
	opacity: 10;
	transform: scaleY(1);
}

.menubox ul li {
	border-radius: 4px;
	padding: 10px;
}

.menubox ul li:hover {
	background-color: #173C6E;
}

.menubox ul li:hover a {
	color: #FFFFFF;
}

.menubox ul li a {
	text-decoration: none;
	color: #000000;
}

.userStatus {

	letter-spacing: -1px;
	width: 350px;
	height: 60px;
	background: #173C6E;
	border-radius: 50px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #FFFFFF;
	font-size: 20px;
	font-weight: 500;
}

.userStatus a {
	text-decoration: none;
	color: #FFFFFF;
}

.userStatus p {
	margin: 10px;
}

.sans {
	font-family: "Noto Sans KR", sans-serif;
}

.whiteBox {
	margin: 0 auto;
	/* border: 1px solid black; /*체크용 border*/
	width: 60%;
	height: 70%;
	background-color: #FFFFFF;
	border-radius: 20px;
	overflow: auto;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
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
		<nav id="GNB">
			<div class="title">
				<div class="logo"></div>
				<h1 class="main">
					<c:url var="mainUrl" value="/main" />
					<a href="${mainUrl}">TimePill</a>
				</h1>
			</div>
			
			<div class="menubox">
				<h3>마이페이지</h3>
				<ul class="menu">
					<li>
						<c:url var="myPageUrl" value="/myinfo/edit" /> 
						<a href="${myPageUrl}"> 유저정보변경 </a>
					</li>
					<li>
						<c:url var="searchUrl" value="/member/search" /> 
						<a href="${searchUrl}"> 복용자관계등록 </a>
					</li>
				</ul>
			</div>


			<div class="menubox">
				<h3>내 복약 정보</h3>
				<ul class="menu">
					<li>
						<c:url var="regUrl" value="/medication/schedule/list" />
						<a href="${regUrl}"> 알람 스케줄 등록 </a>
					</li>

					<li>
						<c:url var="recordUrl" value="/medication/schedule/list" />
						<form id="recordForm" action="#" method="get">
							<input type="hidden" name="takeDate" value="${today}" /> 
							<a href="#" onclick="document.querySelector('#recordForm').submit(); return false;">
								복약 기록 조회 
							</a>
						</form>
					</li>
				</ul>
			</div>

			<div class="menubox">
				<h3>고객센터</h3>
				<ul class="menu">
					<li>
						<c:url var="noticeUrl" value="/notice" />
						<a href="${noticeUrl}">공지사항 게시판</a>
					</li>
					<li>
						<a href="#">일대일 문의</a>
					</li>
				</ul>
			</div>

		<div class="userStatus sans">
			<div>
				<c:choose>
					<c:when test="${not empty loginUser.userName}">
						<!-- 이름정보 있음 -->
						<p class="sans"> <c:out value="${loginUser.userName}"/> 님 환영합니다. </p>
					</c:when>
					<c:otherwise>
						<!-- 이름정보 없음 -->
						<p class="sans"> <c:out value="${loginUser.userId}"/> 님 환영합니다. </p>	
					</c:otherwise>
				</c:choose>
			</div>

			<div>
				<p> <a href='/user/kakao-logout' class="sans"> |  로그아웃 </a> </p> 
			</div>
		</div>
		
		</nav>
	</header>