<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>COVER</title>

    <!-- jQuery 3.7.1-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <!-- Gmarket SANS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/GmarketSans/GmarketSans.css" type="text/css"/>
    <!-- NotoSans KR-->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <!-- 기본 템플릿 CSS -->
    <link rel="stylesheet" href="/resources/css/common.css">
    <link rel="stylesheet" href="/resources/css/cover.css">
</head>
<body>

<div id="backcontainer" class="boxv">
    <div id="contents" class="bgimg">
        <img src="/resources/img/mainico.png" class="main-ico">

        <div class="boxh">
            <img src="/resources/img/logo.svg" class="logo">
            <h1 class="gsansdown title">TimePill</h1>
        </div>

        <div>
            <p class="desc">
                효율적인 복약 관리를 위해 <br>
                <span class="hilightdesc"> TimePill </span> 을 시작해보세요.
            </p>
            <p class="caption">
                시간별 알림 기능과 손쉬운 복용 추가 기능 <br>
                카카오톡 알림 기능으로 건강한 복약 습관을 만들 수 있습니다.
            </p>
        </div>


        <div class="boxv btns">
            <div class="boxh genbtn">
                <a href="/user/login" class="btn-sky">
                    <p class="btndesc"> 일반 로그인 </p>
                </a>
                <a href="/user/terms" class="btn-white">
                    <p class="btndesc"> 일반 회원가입 </p>
                </a>
            </div>            
            <a href="/kakao/login" class="btn-kakao">
                <img src="/resources/img/kakao.png" width="8%" style="margin: 2%;">
                <p class="btndesc"> 카카오톡으로 시작하기 </p>
            </a>
        </div>
    </div>
</div>
</body>
</html>
