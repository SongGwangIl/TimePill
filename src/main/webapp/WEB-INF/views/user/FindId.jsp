<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>아이디찾기 - TimePill </title>
	
	<!-- 파비콘 -->
	<link rel="icon" href="/resources/img/logo.svg">
	
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
<div id="backcontainer" class="boxv">
    <div id="contents" class="bgimg">

       <img src="/resources/img/mainico.png" class="main-ico">

        <div class="boxh">
            <img src="/resources/img/logo.svg" class="logo">
            <h1 class="gsansdown title">아이디찾기</h1>
        </div>

        <div class="wrap">
			<form id="authEmailForm" action="/user/auth-email/" method="post">				                 
                <span>Email</span>	            
                <div class="input password">
                    <input type="email" class="form-input" name="email" id="emailInp" placeholder="등록한 이메일주소를 입력하세요" required="required"/>
                    <span id="msg"></span>
                </div>                       
                <div class="btns boxh">
		            <a class="btn-white btn" id="findId">
		                <p class="btndesc"> 찾기 </p>
		            </a>
				</div>
				<sec:csrfInput/>
				<div id="authNumber">
					<span id="msg"></span><br>
					<label>등록된 아이디</label>
					<input class="form-input" name="userId" type="text" id="viewId" readonly>
					<span id="viewId"></span>
				</div>
			</form>
				<div class="btns boxh" id="btns">
		            <a class="btn-white" id="goLogin">
		                <p class="btndesc"> 로그인화면 </p>
		            </a>
				</div>
        </div>
    </div>
</div>
<template id="findTemp">
	<a class="btn-sky" id="resetPasswordBtn">
        <p class="btndesc"> 비밀번호찾기 </p>
    </a>
</template>
<script src="/resources/js/user/findId.js"></script>
</body>
</html>