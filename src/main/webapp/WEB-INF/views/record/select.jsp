<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 복약 기록 조회 </title>
<link href="${pageContext.request.contextPath}/resources/css/recordlist.css" rel="stylesheet">
<style>
</style>
</head>
<body>

<p><br>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> </p>
<br><br>

<!-- 조회 날짜 선택 -->
<div id="container">
<form action="${pageContext.request.contextPath}/record/select.do" method="get">
	<label for="takeDate"> 조회 날짜 선택 : </label>
	<input type="date" id="takeDate" name="takeDate" value="${takeDate}">
	<input type="submit" value="조회">
</form> <br><br>

<h1> 복약 기록 조회 </h1>
<c:choose>
	<c:when test="${recordSelectByDate.isEmpty()}">
		<p> 조회할 복약 기록이 없습니다. </p>
	</c:when>
	<c:otherwise>
		<table>
			<thead>
				<tr>
					<th>
						복약로그 ID
					</th>
					<th>
						사용자 ID
					</th>
					<th>
						복용한 약품이름
					</th>
					<th>
						복약한 시간알림 ID
					</th>
					<th>
						복약한 시간 이름
					</th>
					<th>
						복약 날짜
					</th>
					<th>
						복약 성공 여부
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dvo" items="${recordSelectByDate}">
				<tr>
					<td> ${dvo.takeId} </td>
					<td> ${dvo.userId} </td>
					<c:forEach var="sdl" items="${dvo.scheduleList}"><td> ${sdl.scheTitle}</td></c:forEach>
					<td> ${dvo.timeId} </td>
					<c:forEach var="stl" items="${dvo.scheTimeList}"><td> ${stl.timeName}</td></c:forEach>
					<td> ${dvo.takeDate}</td>
					<td> ${dvo.takeSuccess} </td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>
<br><br>
</div>

<p><br><br><jsp:include page="/WEB-INF/views/common/footer.jsp"/><br><br></p>
</body>
</html>