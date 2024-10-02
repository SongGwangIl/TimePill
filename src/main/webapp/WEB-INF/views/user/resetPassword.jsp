<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<sec:csrfMetaTags/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>비밀번호 변경</h1>
	
	<form action="/user/resetPassword" method="post">
		<label>새비밀번호</label>
		<input type="text" name="password"><br>
		<label>비밀번호확인</label>
		<input type="text" name="checkPassword">
		<button type="button">변경</button>	
		<sec:csrfInput/>	
	</form>
	<script>
	
	</script>
</body>
</html>