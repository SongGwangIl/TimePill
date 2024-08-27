<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>메인 페이지</title>
	<link href="${pageContext.request.contextPath}/resources/css/recordlist.css" rel="stylesheet">
</head>


<body>

	<div id="container">
	
	<!-- 헤더 -->
	<p><br>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<br></p>
	
	<hr>
	
	<h1>TimePill Main</h1>

	
	<br><br>
	
	
	<!-- 오늘 날짜 디폴트 알람 목록 -->
	<h3>${name}님! <br> 오늘 복용해야 할 약품 목록을 확인하세요! </h3>
	<h3 id="current-time"></h3>
	
	<br>
	
	
	<!-- 조회 날짜 선택 -->
	<form action="${pageContext.request.contextPath}/alarmSelect.do" method="get">
		<label for="takeDate"> 조회 날짜 선택 : </label>
		<input type="date" id="takeDate" name="takeDate">
		<input type="submit" value="조회">
	</form> <br><br>
	
	
	<c:choose>
		<c:when test="${alarmList.isEmpty()}">
			<p> 지금 당장 알람을 등록해보세요! </p>
		</c:when>
		<c:otherwise>
			<table>
				<thead>
					<tr>
						<th>
							복용할 약 이름
						</th>
						<th>
							시간 이름
						</th>
						<th>
							설정한 알람 시간
						</th>
						<th>
							복용 체크
						</th>
					</tr>
				</thead>
				<tbody>
				
					<c:forEach var="al" items="${alarmByDateList}">
						<tr>
							<c:forEach var="sdl" items="${al.scheduleList}">
								<td> ${sdl.scheTitle}</td>
							</c:forEach>
							
							<c:forEach var="stl" items="${al.scheTimeList}">
								<td> ${stl.timeName}</td>
							</c:forEach>
							
							<c:forEach var="stl" items="${al.scheTimeList}">
								<td> ${stl.timeAlarm}</td>
							</c:forEach>
							
							<c:forEach var="stl" items="${al.scheTimeList}">
								<td>
									<form action="${pageContext.request.contextPath}/addlog.do" method="post">
										<input type="hidden" name="timeId" value="${stl.timeId}">
								    	<button type="submit">복용 완료!</button>
									</form>
								</td>
							</c:forEach>
							
							<td class="status">
								NO
							</td>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>
	<br><br>
	
	<h3>
		<a href="${pageContext.request.contextPath}/schedule/add.do">신규 알람 등록</a>
	</h3>
	
	<br><br><hr>
	
	<p><br>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<br></p>
	
	</div>
	
	
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/record/nowtime.js"></script>

</body>
</html>