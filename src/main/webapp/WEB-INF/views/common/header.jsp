<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
	
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title}</title>

<sec:csrfMetaTags/>
<sec:authorize access="isAuthenticated()" var="auth">
<sec:authentication property="principal" var="principal"/>
</sec:authorize>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- Gmarket Sans SDK -->
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<!-- Noto Sans Kor SDK-->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<!-- bxSlider SDK -->
<link rel="stylesheet" href="/resources/css/template.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bxslider@4.2.17/dist/jquery.bxslider.min.css">
<script src="https://cdn.jsdelivr.net/npm/bxslider@4.2.17/dist/jquery.bxslider.min.js"></script>

</head>
<body>
<div id="backcontainer">

<!-- 헤더 : main logo, user status -->

<header id="header">
    <div class="boxh title">
        <img id="logo" src="/resources/img/timpill.svg">
        <h1 onclick="location.href='/'" onmouseover="this.style.cursor='pointer';"> TimePill </h1>
    </div>
    <div class="boxh logout">
        <c:choose>
			<c:when test="${auth eq true}">
				<div class="boxh userstatus">
					<h3 onclick="document.getElementById('logoutForm').submit();">로그아웃</h3>
					<form id="logoutForm" method="POST" action="/user/logout" style="display: none;">
						<sec:csrfInput/>
					</form>
				</div>
			</c:when>
			<c:otherwise>
				<div class="boxh userstatus">
					<h3 onclick="location.href='/user/login'">로그인</h3>
				</div>
			</c:otherwise>
		</c:choose>
    </div>
</header>