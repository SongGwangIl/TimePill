<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<sec:csrfMetaTags/>
<title>TimePill - 회원가입</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.14.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/addFrm.css" type="text/css">
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
<div id="wrap">
	<h1>회원가입</h1>
	<form:form action="${pageContext.request.contextPath}/user/singup" modelAttribute="userVO" method="post">
		<ul class="input">
			<li>
               	<label class="label">아이디</label>
               	<form:input type="text" path="userId" id="userId" placeholder="4-15자리 영문과 숫자로 입력" required="required"/><br>				
               	<p id="idCheck"></p>
               	<form:errors path="userId"></form:errors>
			</li>
			<li>
               	<label class="label">이름</label>
               	<form:input type="text" path="nickname" id="nickname" required="required"/><br>
               	<form:errors path="nickname"></form:errors>
			</li>
			<li>
               	<label class="label">비밀번호</label>
               	<form:input type="password" path="password" id="password" placeholder="8-20자리 영문 대,소문자 숫자 특수문자 포함" required="required"/><br>
               	<p id="userPwdMsg"></p>
               	<form:errors path="password"></form:errors>
			</li>
			<li>
               	<label class="label">비밀번호 확인</label>
               	<input type="password" name="checkUserPwd" id="checkUserPwd" required="required"/><br>
               	<p id="checkUserPwdMsg"></p>
			</li>
			<li>
               	<label class="label">이메일</label>
               	<form:input type="email" path="email" placeholder="이메일 입력" id="email" onkeyup='autoEmail("email",this.value)' required="required"/><br>
               	<form:errors path="email"></form:errors>
			</li>
			
           </ul>
		<button class="btn" type="submit">회원가입</button>
		<button class="btn" type="button" onclick="location.href='/cover'">취소</button>    
		<sec:csrfInput />  
	</form:form>
</div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/user/frontValidation.js"></script>
	
<div id="footer" class="text4">
	<h3>copyrightⓒtimePill</h3>
</div>
</body>
</html>