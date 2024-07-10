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
	<input type="date" id="takeDate" name="takeDate">
	<input type="submit" value="조회">
</form> <br><br>


<c:choose>
	<c:when test="${alarmList.isEmpty()}">
		<p> 조회할 복약 기록이 없습니다. </p>
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
				<c:forEach var="al" items="${alarmList}">
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


<p>	추가 구현 필요 : <br>
	체크 버튼을 누르면 메인리스트에서도 takeDate 로그 출력, <br> 
	takelog 테이블에서 date 데이터를 받아와서 출력해야 하므로 ajax로 해야 할 것 같다.... <br>
	복용을 표시하는 on/off 토글 (해당 페이지의 변화를 유지해야 함) <br>
	날짜 변경을 통한 조회 페이지 갱신 (ajax) <br>
	날짜 변경용 DATE form (일주일 단위, 한달 단위) <br>
	체크 버튼을 누르면 현재 시간으로 등록, 다시 누르면 update(use_at의 비활성화) <br>
	미래의 복용체크는 누르지 못하도록, 시간이 지난 약은 복용체크를 할 수 없음
</p>

<p><br><br><jsp:include page="/WEB-INF/views/common/footer.jsp"/><br><br></p>
</div>

<script>

	function displayCurrentTime() {
		var now = new Date();
		var year = now.getFullYear();
		var month = (String)(now.getMonth() + 1).padStart(2,'0');
		var day = (String)(now.getDate()).padStart(2,'0');
		var hours = (String)(now.getHours()).padStart(2,'0');
		var minutes = (String)(now.getMinutes()).padStart(2,'0');
		var seconds = (String)(now.getSeconds()).padStart(2,'0');

		var currentDateTimeString = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
		document.getElementById('current-time').textContent = "현재 시각 " + currentDateTimeString;
	}

	displayCurrentTime();
	setInterval(displayCurrentTime, 1000);
</script>
</body>
</html>