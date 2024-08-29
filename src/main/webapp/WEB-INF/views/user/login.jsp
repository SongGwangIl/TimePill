<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css" type="text/css">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<style>
.bg { 
	width:1920px;
	height:700px;
	position:absolute;
	left:0px;
	top:80px;
	background-image:url(resources/img/background.png);
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
</head>


</style>
</head>
<body>
<div class="bg"></div>
	<div id="wrap">
		<h1>로그인</h1>
		<form action="${pageContext.request.contextPath}/login" method="post">
			<ul class="input">
				<li>
	                <label>아이디</label>
	                <input type="text" name="userId" id="userId" required>
	            <li>
	                <label>비밀번호</label>
	                <input type="password" name="userPwd" id="userPwd">
				</li>
            </ul>
	    	<input type="submit" value="로그인" class="btn">	
		</form>
		<a href="${pageContext.request.contextPath}/singup">회원가입</a>
		<a href="#">아이디를 잃어버렸습니까?</a>
		<a href="#">비밀번호를 잃어버렸습니까?</a>
	</div>
	<div id="footer" class="text4">
	<h3>copyrightⓒtimePill</h3>
</div>
</body>
</html>