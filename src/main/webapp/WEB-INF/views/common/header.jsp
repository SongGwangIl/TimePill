<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
				<a href='${pageContext.request.contextPath}/login'>  |로그아웃|</a>
			</li>
			
			<li class="menu">
				<c:url var="regUrl" value="/schedule/list.do" ></c:url>
				<a href="${regUrl}"> |스케줄 리스트|</a>
			</li>
			
			<li class="menu">
				<c:url var="recordUrl" value="/record/list.do"></c:url>
				<form id="recordForm" action="${recordUrl}" method="get">
			    	<input type="hidden" name="takeDate" value="${today}" />
			    	<a href="#" onclick="document.querySelector('#recordForm').submit(); return false;"> |복약 기록 조회|</a>
				</form>
			</li>
			
			<li class="menu">
				<c:url var="mainUrl" value="/main" ></c:url>
				<a href="${mainUrl}"> |메인 화면| </a><br>
			</li>
			
			<li class="menu">
				<c:url var="myPageUrl" value="/myPage"/>
				<a href="${myPageUrl}"> |나의정보변경| </a>
			</li>
			
			<li class="menu">
				<c:url var="registUrl" value="/myPage"/>
				<a href="${registUrl}"> |사용자보호자등록| </a>
			</li>
			
			<li class="menu">
				<c:url var="mydeviceUrl" value="/mydevice"/>
				<a href="${mydeviceUrl}"> |기기정보변경| </a>
			</li>
			
		</ul>
	</nav>
	
	
<!-- <script type="text/javascript">

// 	//오늘 날짜의 Date 객체 생성
// 	var today = new Date();


// 	var year = today.getFullYear();
// 	var month = String(today.getMonth() + 1).padStart(2, '0');
// 	var day = String(today.getDate()).padStart(2, '0');

// 	// yyyy-MM-dd 형식의 문자열 생성
// 	var fmtDate = "${year}-${month}-${day}";

	
</script> -->


</body>
</html>