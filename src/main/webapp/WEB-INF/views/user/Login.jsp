<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>로그인 - TimePill</title>

    <!-- jQuery 3.7.1-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <!-- Gmarket SANS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/GmarketSans/GmarketSans.css" type="text/css" />
    <!-- NotoSans KR-->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <!-- 기본 템플릿 CSS -->
    <link rel="stylesheet" href="/resources/css/common/common.css">
    <link rel="stylesheet" href="/resources/css/user/login.css">
</head>
<body>

<div id="backcontainer" class="boxv">
    <div id="contents" class="bgimg">
        <!-- 약병 그림 -->
        <img src="/resources/img/mainico.png" class="main-ico">

        <!-- 타이틀 -->
        <div class="boxh">
            <img src="/resources/img/logo.svg" class="logo">
            <h1 class="gsansdown title">TimePill</h1>
        </div>

        <div>
            <form id="loginform" action="/user/login" method="post">

                <table class="loginform">
                    <tr>
                        <td><h3 class="margin-init">아이디</h3></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="input password">
                                <input type="text" name="userId" class="form-input" placeholder="아이디를 입력해주세요.">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td><h3 class="margin-init">비밀번호</h3></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="input password">
                                <input type="password" name="password" id="pwd" class="form-input pwd" placeholder="비밀번호를 입력해주세요.">
                                <img class="eye" src="/resources/img/eye.png"></img>
                            </div>
                        </td>
                    </tr>
                </table>
                <sec:csrfInput />
            </form>
        </div>


        <div class="btns boxv genbtn">
            <a href="" id="login" class="btn-sky">
                <p class="btndesc"> 로그인 </p>
            </a>
            <a href="/kakao/login" class="btn-kakao">
                <img src="/resources/img/kakao.png" width="10%" style="margin: 2%;">
                <p class="btndesc"> 카카오톡으로 로그인 </p>
            </a>

			<p class="caption">
				<a href="/user/find-id">아이디 찾기</a> / <a href="/user/auth-email">비밀번호 찾기</a>
			</p>

			</div>
    </div>
</div>

    <script>
        // eye 이미지 클릭 시 패스워드 필드 토글
        document.querySelector('.eye').addEventListener('click', function() {
            const pwdfiled = document.querySelector('.pwd');
            const type = pwdfiled.getAttribute('type');
            
            if (type === 'password') {
                pwdfiled.setAttribute('type', 'text');
                this.src = '/resources/img/eyeno.png';
            } else {
                pwdfiled.setAttribute('type', 'password');
                this.src = '/resources/img/eye.png';
            }
        });

        // '로그인' 버튼 클릭 시 form 제출
        document.getElementById('login').addEventListener('click', submitLogin);
       
        document.querySelector('#pwd').addEventListener('keydown', function (event) {
			if (event.key === 'Enter') {
				submitLogin();
			}
		});
        
        // form제출
        function submitLogin () {
            event.preventDefault();
            document.getElementById('loginform').submit();
    }
   


<c:if test="${not empty sessionScope.message}">
	alert("<c:out value='${sessionScope.message}'/>");
	<c:remove var="message" scope="session"/>
</c:if>
</script>
</body>
</html>