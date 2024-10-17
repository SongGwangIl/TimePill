<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>아이디찾기 - TimePill </title>
	
	<!-- jQuery 3.7.1-->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<!-- Gmarket SANS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/GmarketSans/GmarketSans.css"
	    type="text/css" />
	<!-- NotoSans KR-->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	    rel="stylesheet">
	<!-- jQuery UI -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.14.0/themes/base/jquery-ui.css">
	    
	<!-- 기본 템플릿 CSS -->
	<link rel="stylesheet" href="/resources/css/common/common.css">
	<link rel="stylesheet" href="/resources/css/user/findId.css">
	<sec:csrfMetaTags/>
</head>
<body>
<h1>아이디찾기</h1>
<form action="/user/auth-email/" method="post">
	<label>Email: </label>
	<input type="text" name="email" id="emailInp" placeholder="등록한 이메일주소를 입력하세요">
	<button type="button" id="findIdBtn">찾기</button>
	<sec:csrfInput/>
</form>
<div id="authNumber">
	<span id="msg"></span><br>
	<label>등록된 아이디: </label>
	<span id="viewId"></span>
</div>
<button type="button" id="goLoginBtn">로그인화면 이동</button>
<script src="/resources/js/user/findId.js"></script>
</body>
</html>