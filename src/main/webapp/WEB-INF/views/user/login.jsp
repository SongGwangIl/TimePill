<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"		uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimePill - 로그인</title>
<link rel="stylesheet" href="/resources/css/user/login.css" type="text/css">
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
</style>
</head>
<body>
<div class="bg"></div>
	<div id="wrap">
		<h1>로그인</h1>
		<form action="/user/login" method="post">
			<ul class="input">
				<li>
	                <label>아이디</label>
	                <input type="text" name="userId" id="userId" required>
	            <li>
	                <label>비밀번호</label>
	                <input type="password" name="password" id="password">
				</li>
            </ul>
	    	<input type="submit" value="로그인" class="btn">
	    	<sec:csrfInput />
		</form>
		<a href="${pageContext.request.contextPath}/kakao/login">카카오로그인</a>
		<a href="${pageContext.request.contextPath}/user/terms">회원가입</a>
		<a href="/user/findId">아이디를 잃어버렸습니까?</a>
		<a href="/user/authEmail">비밀번호를 잃어버렸습니까?</a>
	</div>
	<div id="footer" class="text4">
	<h3>copyrightⓒtimePill</h3>
</div>

<script>
<c:if test="${not empty sessionScope.message}">
	alert("<c:out value='${sessionScope.message}'/>");
	<c:remove var="message" scope="session"/>
</c:if>
</script>
</body>
</html>