<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	* {
	justify-content:center;
	}
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>복약 정보 확인</h1>
<a href='${pageContext.request.contextPath}/schedule/add.do'>신규 정보 등록</a>
<br><br>
	<table>
		<tbody>
	<c:forEach var="vo" items="${lvo}">
	<!-- 고유번호 : <c:out value= "${vo.scheId}"/> <br>  -->
	<tr>
		<td>제목 : <c:out value="${vo.scheTitle}"/>
		(복약 일 <c:out value= "${vo.scheTakeNum}"/>회)</td>
	</tr>
	<tr>
		<td>처방기간 : <c:out value="${vo.scheStartDate}"/>
		 ~ 	<c:out value="${vo.scheEndDate}"/></td>
	</tr>
	<c:if test="${vo.timeList.isEmpty()}">
		<tr><td>
			<a href="${pageContext.request.contextPath}/schedule/time/add1.do?scheId=${vo.scheId}">알림 시간 등록</a>
		</td></tr>
	</c:if>
	<c:forEach var="timeVo" items="${vo.timeList}">
		<tr><td>
			<c:out value="${timeVo.timeName}"/> - <c:out value="${timeVo.timeAlarm}"/>
		</td></tr>
	</c:forEach>
	<hr>
</c:forEach>
		</tbody>
	</table>



</body>
</html>