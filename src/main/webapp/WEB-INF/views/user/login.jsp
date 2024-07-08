<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/login.css" type="text/css">
</head>
<body>
	<div id="wrap">
		<h1>로그인</h1>
		<form action="${pageContext.request.contextPath}/login.do" method="post">
			<div class="input">
                <span>아이디</span> <input type="text" name="userId"><br>
                <span>비밀번호</span><input type="password" name="userPass"><br>
                <input type="submit" value="로그인" id="btn">
            </div>
		</form>
	</div>
</body>
</html>