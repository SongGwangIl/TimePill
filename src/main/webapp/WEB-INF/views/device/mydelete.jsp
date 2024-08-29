<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>mydelete</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/common/jquery-3.7.1.min.js"></script>
</head>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<span class="info-text">기기정보변경</span>
	
	<div class="box">
		<h1>기기정보변경</h1>
			<ul>
				<li>
					<p>등록된 기기정보가 없습니다.</p>
				</li>
			</ul>
			
			<ul>
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