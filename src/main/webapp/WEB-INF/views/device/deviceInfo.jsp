<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/cover.css" type="text/css">
</head>
<body>

	<h1>기기등록</h1>
	
	<img alt="" src="${pageContext.request.contextPath}/resources/img/dispensor.jpg">
	
	<div id="wrap">
		<h2>Timepill 시리얼 코드 등록</h2>
		
		<form action="${pageContext.request.contextPath}/device" method="post">
			<ul>
				<li>
	                <input type="text" name="deviceId" id="deviceId" required>
	                <button type="submit">등록하기</button><br>
	            </li>
            </ul>
		</form>
		
		<a href="${pageContext.request.contextPath}/main" >나중에 할게요</a>
	</div>
	
</body>
</html>