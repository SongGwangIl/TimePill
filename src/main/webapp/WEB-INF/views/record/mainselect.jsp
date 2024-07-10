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


<p><br>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> </p>
<br><br>

<hr>

<div id="container">
<h1>메인 페이지</h1><br><br>


 

<!-- 오늘 날짜 디폴트 알람 목록 -->
<h1> 오늘의 알람 </h1><br><br>
<h3 id="current-time"></h3>

<!-- 조회 날짜 선택 -->
<form action="${pageContext.request.contextPath}/alarmSelect.do" method="post">
	<label for="takeDate"> 조회 날짜 선택 : </label>
	<input type="date" id="takeDate" name="takeDate" value="${takeDate}">
	<input type="submit" value="조회">
</form> <br><br>


<c:choose>
	<c:when test="${alarmByDateList.isEmpty()}">
		<h3> 지금 당장 알람을 등록해보세요! </h3>
	</c:when>
	<c:otherwise>
		<table>
			<thead>
				<tr>
					<th>
						복용 약물 이름
					</th>
					<th>
						시간이름
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
					<c:forEach var="sdl" items="${al.scheduleList}"><td> ${sdl.scheTitle}</td></c:forEach>
					<c:forEach var="stl" items="${al.scheTimeList}"><td> ${stl.timeName}</td></c:forEach>
					<c:forEach var="stl" items="${al.scheTimeList}"><td> ${stl.timeAlarm}</td></c:forEach>
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

<a href='${pageContext.request.contextPath}/schedule/add.do'>신규 알람 등록</a>


<p><br><br><jsp:include page="/WEB-INF/views/common/footer.jsp"/><br><br></p>
</div>

<script>
		function displayCurrentTime() {
			var now = new Date();
			var year = now.getFullYear();
		    var month = now.getMonth() + 1; // getMonth()는 0부터 시작하므로 +1 해줌
		    var day = now.getDate();
		    var hours = now.getHours();
		    var minutes = now.getMinutes();
		    var seconds = now.getSeconds();
		
		    var currentDateTimeString = year + '-' + addZero(month) + '-' + addZero(day) + ' ' + addZero(hours) + ':' + addZero(minutes) + ':' + addZero(seconds);
		    document.getElementById('current-time').textContent = "현재 시각 " + currentTimeString;
		}
		
		// 페이지 로드 시에 한 번 호출하거나, setInterval을 사용하여 일정 간격으로 업데이트 가능
		displayCurrentTime();
		setInterval(displayCurrentTime, 1000); // 1초마다 업데이트
</script>
</body>
</html>