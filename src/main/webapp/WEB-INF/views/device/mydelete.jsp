<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="data:,">
<meta charset="UTF-8">
<title>mydelete</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/addUserInfo.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
</head>  
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div id="wrap">
		<h1>기기정보변경</h1>
			<ul>
				<li>
					<p>등록된 기기정보가 없습니다.</p>
				</li>
				
			</ul>
			
			</ul>
			<ul id="buttons">
				<li>
					<button type="button" onclick="location.href='device'">기기등록하러 가기</button>
				</li>
				<li>
					<button type="button" onclick="location.href='main'">다음에 하기</button> <br>
				</li>
			</ul>
	</div>
</body>
</html>