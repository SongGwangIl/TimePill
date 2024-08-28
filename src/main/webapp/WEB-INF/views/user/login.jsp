<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/login.css" type="text/css">
<!-- <style>
/* 	.bg{ */
/* 		top: 0px; */
/* 		left: 0px; */
/* 		width: 1920px; */
/* 		height: 1080px; */
/* 		/* UI Properties */ */
/* 		background: transparent url('${pageContext.request.contextPath}/resources/img/background.png') 0% 0% no-repeat padding-box; */
/* 		opacity: 1; */
/* 	} */
</style> -->
</head>
<body class="bg">
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
	    	<input type="submit" value="로그인" id="btn">	
		</form>
		<a href="${pageContext.request.contextPath}/singup">회원가입</a><br>
		<a href="#">아이디를 잃어버렸습니까?</a><br>
		<a href="#">비밀번호를 잃어버렸습니까?</a>
	</div>
</body>
</html>