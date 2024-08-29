<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>메인 페이지</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
</head>



<body>

<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<span class="info-text">
	${name}님!<br>
	오늘 복용해야 할 약품 목록을 확인하세요! 
</span>
		

	
<!-- 조회 날짜 선택 -->
<div class="box">
	<div id="current-time" class="current-time"></div>
	<div class="inner-contianer">
	<div id="container">
		<div class="form">
			<form action="${pageContext.request.contextPath}/alarmSelect.do" method="get">
				<label for="takeDate"> 조회 날짜 선택 : </label>
				<input type="date" id="takeDate" name="takeDate">
				<input type="submit" value="조회">
			</form>
		</div>
		
		<c:choose>
			<c:when test="${alarmList.isEmpty()}">
				<p>지금 당장 알람을 등록해보세요!</p>
			</c:when>
			
			<c:otherwise>
				<table >
					<thead>
						<tr>
							<th>복용할 약 이름</th>
							<th>시간 이름	</th>
							<th>설정한 알람 시간</th>
							<th>복용 체크	</th>
						</tr>
					</thead>
					
					<tbody>
					
						<c:forEach var="al" items="${alarmByDateList}">
							<tr>
								
								<c:forEach var="sdl" items="${al.scheduleList}">
									<td>${sdl.scheTitle}</td>
								</c:forEach>

								<c:forEach var="stl" items="${al.scheTimeList}">
									<td>${stl.timeName}</td>
								</c:forEach>

								<c:forEach var="stl" items="${al.scheTimeList}">
									<td>${stl.timeAlarm}</td>
								</c:forEach>

								<c:forEach var="stl" items="${al.scheTimeList}">
									<td>
										<form action="${pageContext.request.contextPath}/addlog.do" method="post">
											<input type="hidden" name="timeId" value="${stl.timeId}">
											<button type="submit">복용 완료!</button>
										</form>
									</td>
								</c:forEach>

								<td>NO</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</c:otherwise>
		</c:choose>

	<span class="text5">
		<a href="${pageContext.request.contextPath}/schedule/add.do">신규 알람 등록</a>
	</span>
	</div>
</div>
</div>
<!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<!-- 현재시간 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/record/nowtime.js"></script>
