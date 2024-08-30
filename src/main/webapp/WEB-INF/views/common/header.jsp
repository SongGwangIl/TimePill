<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
	<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
	<style>
	 .background-element {
        position: absolute;
        top: 0px;
        left: 0px;
        width: 1920px;
        height: 1080px;
        background: transparent url('${pageContext.request.contextPath}/resources/img/background.png') 0% 0% no-repeat padding-box;
        opacity: 1;
    }
    
    .ui-element {
        position: absolute;
        top: 80px;
        left: 360px;
        width: 48px;
        height: 48px;
        background: transparent url('${pageContext.request.contextPath}/resources/img/timpill.svg') 0% 0% no-repeat padding-box;
        opacity: 1;
    }
    .logout {
    	color: #FFFFFF;
    }
    
	</style>
</head>
<body>
	<div class="background-element">
		<div class="GmarketSans">
		<span class="text"><c:url var="mainUrl" value="/main" />
				<a href="${mainUrl}" class="GmarketSans">TimePill</a></span>
	
		<span class="text1 GmarketSans">마이페이지
			<ul class="text1 GmarketSans"">
				<li>
					<c:url var="myPageUrl" value="/myPage"/>
					<a href="${myPageUrl}"> 나의정보변경 </a>
				</li>
				<li>
					<c:url var="searchUrl" value="/member/search"/>
					<a href="${searchUrl}"> 사용자보호자등록 </a>
				</li>
				<li>
					<c:url var="mydeviceUrl" value="/mydevice"/>
					<a href="${mydeviceUrl}"> 기기정보변경 </a>
				</li>
			</ul>
		</span>
		
		<span class="text2 GmarketSans">내 복약 정보	
			<ul class="text2 GmarketSans">
				<li>
					<c:url var="regUrl" value="/schedule/list.do" />
					<a href="${regUrl}">스케줄 리스트</a>
				</li>
				<li>
					<c:url var="recordUrl" value="/record/list.do"/>
					<form id="recordForm" action="${recordUrl}" method="get">
				    	<input type="hidden" name="takeDate" value="${today}" />
				    	<a href="#" onclick="document.querySelector('#recordForm').submit(); return false;"> 복약 기록 조회</a>
					</form>
				</li>
			</ul>
		</span>
		
		<span class="text3 GmarketSans">고객센터
			
		</span>
		
		<span class="border GmarketSans">
		<span>
			<c:choose>
				<c:when test="${loginUser.userValid.toString() == 'Y'}">
					<c:out value="${name} 님 환영합니다."></c:out>
				</c:when>
				<c:otherwise>
					<c:out value="${loginUser.userId}"/> 님 환영합니다.	
				</c:otherwise>
			</c:choose>
				<a href='${pageContext.request.contextPath}/login' class="logout">  | 로그아웃</a>
			
		</span>	
	</div>
	</div>
	<div class="ui-element"></div>
</body>
</html>
