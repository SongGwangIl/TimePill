<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
	
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${param.title}</title>

<!-- 시큐리티 csrf토큰 -->
<sec:csrfMetaTags/>
<!-- 시큐리티 로그인 여부 -->
<sec:authorize access="isAuthenticated()" var="auth">
	<sec:authentication property="principal" var="principal"/>
</sec:authorize>

<!-- 파비콘 -->
<link rel="icon" href="/resources/img/logo.svg">

<!-- Gmarket SANS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/GmarketSans/GmarketSans.css" type="text/css"/>
<!-- NotoSans KR-->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<!-- 기본 템플릿 CSS -->
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/header.css">
<link rel="stylesheet" href="/resources/css/footer.css">
<link rel="stylesheet" href="/resources/css/main.css">

<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
	<div id="backcontainer" class="boxv">
		<!-- 헤더 : main logo, user status -->
		<header id="header" class="boxh">
			<div class="boxh headerbar">
				<a href="/">
					<div class="boxh title">
						<img id="logo" src="/resources/img/logo.svg">
						<h1>TimePill</h1>
					</div>
				</a>
				<div class="boxh logout">
					<c:if test="${auth eq true}">
						<a href="#" onclick="document.getElementById('logoutForm').submit();">
							<img src="/resources/img/logout.png" alt="로그아웃" style="width: 35px;">
						</a>
						<form id="logoutForm" method="POST" action="/user/logout" style="display: none;">
							<sec:csrfInput/>
						</form>
					</c:if>
				</div>
			</div>
		</header>