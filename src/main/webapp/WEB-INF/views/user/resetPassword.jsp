<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<input type="password" name="password"><br>
		<label>비밀번호확인</label>
		<input type="password" name="checkPassword">
		<button type="submit">변경</button>	
		<sec:csrfInput/>	
	</form>
	<script>
	<c:if test="${not empty sessionScope.message}">
		alert("<c:out value='${sessionScope.message}'/>");
	<c:remove var="message" scope="session"/>
</c:if>
	</script>
</body>
</html>