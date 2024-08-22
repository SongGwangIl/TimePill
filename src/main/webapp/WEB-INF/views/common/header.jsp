<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/common/header.css" rel="stylesheet">
</head>

<body>
<nav id="nav">
	<ul>
		<li class="menu">
		<c:choose>
			<c:when test="${loginUser.userValid.toString() == 'Y'}">
				<c:out value="${name} 님 환영합니다."></c:out>
			</c:when>
			<c:otherwise>
				<c:out value="${loginUser.userId}"/> 님 환영합니다.	
			</c:otherwise>
		</c:choose>
		</li>
		<li class="menu">
			<a href='${pageContext.request.contextPath}/login'>  | 로그아웃 |</a>
		</li>
		<li class="menu">
			<c:url var="regUrl" value="/schedule/list.do" ></c:url>
			<a href="${regUrl}"> | 스케쥴 리스트  |</a>
		</li>
		<li class="menu">
			<c:url var="recordUrl" value="/record/list.do"></c:url>
			<form id="recordForm" action="${recordUrl}" method="post">
		    	<input type="hidden" name="takeDate" value="${today}" />
		    	<a href="#" onclick="document.querySelector('#recordForm').submit(); return false;"> | 복약 기록 조회  |</a>
			</form>
		</li>
		<li class="menu">
			<c:url var="mainUrl" value="/main" ></c:url>
			<a href="${mainUrl}"> | 메인 화면 | </a><br>
		</li>
		<li>
			<c:url var="myPageUrl" value="/myPage"/>
			<a href="${myPageUrl}"> 나의정보변경 </a>
		</li>
	</ul>
</nav>

	</body>
</html>