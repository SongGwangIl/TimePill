<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<sec:csrfMetaTags/>
<title>TimePill - 회원가입</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/jquery-ui.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/addFrm.css" type="text/css">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<style>
.bg { 
	width:1920px;
	height:700px;
	position:absolute;
	left:0px;
	top:80px;
	background-image:url(/resources/img/background.png);
	background-repeat:no-repeat;
	background-size:cover;
}
	.text4 {
        position: absolute;
        top: 830px;
        left:880px;
        width: 262px;
        height: 20px;
        text-align: left;
        font: normal normal normal 14px/20px 'Noto Sans CJK KR';
        letter-spacing: 0px;
        color: #000000;
        opacity: 1;
    }
</style>
</head>

<body>

<div class="bg"></div>
	<div id="wrap">
		<h1>회원가입</h1>
		<form action="${pageContext.request.contextPath}/user/singup" method="post">
			<ul class="input">
				<li>
                	<label class="label">아이디</label>
                	<input type="text" name="userId" id="userId" placeholder="6-15자리 영문과 숫자로 입력" required><br>				
                	<p id="idCheck"></p>
				</li>
				<li>
                	<label class="label">이름</label>
                	<input type="text" name="nickname" id="nickname" required><br>
				</li>
				<li>
                	<label class="label">비밀번호</label>
                	<input type="password" name="password" id="password" placeholder="8-20자리 영문 대,소문자 숫자 특수문자 포함" required><br>
                	<p id="userPwdMsg"></p>
				</li>
				<li>
                	<label class="label">비밀번호 확인</label>
                	<input type="password" name="checkUserPwd" id="checkUserPwd" required><br>
                	<p id="checkUserPwdMsg"></p>
				</li>
				<li>
                	<label class="label">이메일</label>
                	<input type="email" name="email" placeholder="이메일 입력" id="email" onkeyup='autoEmail("email",this.value)' required><br>
				</li>
				
            </ul>
			<button class="btn" type="submit">회원가입</button>
			<button class="btn" type="button" onclick="location.href='/cover'">취소</button>    
			<sec:csrfInput />  
		</form>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/user/add.js"></script>
	
<div id="footer" class="text4">
	<h3>copyrightⓒtimePill</h3>
</div>
</body>
</html>