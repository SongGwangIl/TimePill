<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:choose>
	<c:when test="${name != null}">
		<c:out value="${name} 님 환영합니다."></c:out>
	</c:when>
	<c:otherwise>
		<c:out value="${loginUser.userId}"/> 님 환영합니다.	
	</c:otherwise>
</c:choose>
| <a href='${pageContext.request.contextPath}/login'>로그아웃</a>
	| <c:url var="regUrl" value="/schedule/list.do" ></c:url>
	<a href="${regUrl}">스케쥴 리스트</a>
	| <c:url var="recordUrl" value="/record/list.do" ></c:url>
	<a href="${recordUrl}"> 복약 기록 조회</a>
	| <c:url var="mainUrl" value="/main" ></c:url>
	<a href="${mainUrl}"> 메인 화면 </a><br>

</body>
</html>