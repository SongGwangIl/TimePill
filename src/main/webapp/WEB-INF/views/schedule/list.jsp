<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>복약 정보 확인</h1>
<a href='${pageContext.request.contextPath}/schedule/add.do'>신규 정보 등록</a>
<br><br>
<c:forEach var="vo" items="${lvo}">
	<!-- 고유번호 : <c:out value= "${vo.scheId}"/> <br>  -->
	제목 : <c:out value="${vo.scheTitle}"/> <button>수정</button> <br>
	처방기간 : <c:out value="${vo.scheStartDate}"/> ~ 	<c:out value="${vo.scheEndDate}"/> <br>
	복약횟수 : <c:out value= "${vo.scheTakeNum}"/> <br>
	<!-- forEach문 추가하여 시간까지 표시, 시간 정보가 없다면 없음 경고문구 표시 -->
	<a href="${pageContext.request.contextPath}/schedule/time/add1.do?scheId=${vo.scheId}">알림 시간 등록</a> <br><br>
</c:forEach>


</body>
</html>