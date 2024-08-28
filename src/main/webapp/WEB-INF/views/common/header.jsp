<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
  
  
  
  
<body>


	<nav>
		<ul>
			<li>
			<c:choose>
				<c:when test="${loginUser.userValid.toString() == 'Y'}">
					<c:out value="${name} 님 환영합니다."></c:out>
				</c:when>
				<c:otherwise>
					<c:out value="${loginUser.userId}"/> 님 환영합니다.	
				</c:otherwise>
			</c:choose>
			</li>
			
			<li>
				<a href='${pageContext.request.contextPath}/login'>  |로그아웃|</a>
			</li>
			
			<li>
				<c:url var="regUrl" value="/schedule/list.do" />
				<a href="${regUrl}"> |스케줄 리스트|</a>
			</li>
			
			<li>
				<c:url var="recordUrl" value="/record/list.do"/>
				<form id="recordForm" action="${recordUrl}" method="get">
			    	<input type="hidden" name="takeDate" value="${today}" />
			    	<a href="#" onclick="document.querySelector('#recordForm').submit(); return false;"> |복약 기록 조회|</a>
				</form>
			</li>
			
			<li>
				<c:url var="mainUrl" value="/main" />
				<a href="${mainUrl}"> |메인 화면| </a><br>
			</li>
			
			<li>
				<c:url var="myPageUrl" value="/myPage"/>
				<a href="${myPageUrl}"> |나의정보변경| </a>
			</li>
			
			<li>
				<c:url var="searchUrl" value="/member/search"/>
				<a href="${searchUrl}"> |사용자보호자등록| </a>
			</li>
			
			<li>
				<c:url var="mydeviceUrl" value="/mydevice"/>
				<a href="${mydeviceUrl}"> |기기정보변경| </a>
			</li>
		</ul>
	</nav>

