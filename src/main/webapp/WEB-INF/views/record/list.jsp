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
</head>
<body>


<div id="container">

<!-- 헤더 -->
<p><br>
<jsp:include page="/WEB-INF/views/common/header.jsp"/> </p>
<br><br>

<hr>



<h3> ${name} 님의 복약 상황을 확인해보세요! </h3>

<!-- 리스트 조회 날짜 선택 -->
<form action="${pageContext.request.contextPath}/record/list.do" method="post">
	<label for="takeDate"> 조회 날짜 선택 : </label>
	<input type="date" id="takeDate" name="takeDate">
	<input type="submit" value="조회">
</form> <br>

<div style="width:600px; height:400px; margin : 0 auto">
	<canvas id="recordChart"></canvas>
</div>


<!-- 로그 조회 -->
 	<c:choose>
		<c:when test="${takeDate eq today}">
			<h1>오늘의 복용기록 </h1>
		</c:when>
		<c:otherwise>
			<h1>${takeDate}의 복용기록 </h1>
		</c:otherwise>
	</c:choose>
	
	<c:choose>
	<c:when test="${recordSelectByDate.isEmpty()}">
		<p> 조회할 복약 기록이 없습니다. </p>
	</c:when>
	<c:otherwise>
		<table>
			<thead>
				<tr>
<!-- 					<th> -->
<!-- 						복약로그 ID -->
<!-- 					</th> -->
					<th>
						사용자 성명
					</th>
					<th>
						복용한 약품이름
					</th>
<!-- 					<th> -->
<!-- 						복약한 시간알림 ID -->
<!-- 					</th> -->
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
				<c:forEach var="tvo" items="${recordSelectByDate}">
				<tr>
<%-- 					<td> ${tvo.takeId} </td> --%>
					<td> ${name} </td>
					<c:forEach var="sdl" items="${tvo.scheduleList}"><td> ${sdl.scheTitle}</td></c:forEach>
<%-- 					<td> ${tvo.timeId} </td> --%>
					<c:forEach var="stl" items="${tvo.scheTimeList}"><td> ${stl.timeName}</td></c:forEach>
					<td> ${tvo.takeDate} </td>
					<td> ${tvo.takeSuccess} </td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>
<br><br>


<h1> 기간별 복용기록 조회 (페이지네이션 너무절실) </h1>
<c:choose>
	<c:when test="${recordSelectByAll.isEmpty()}">
		<p> 조회할 복약 기록이 없습니다. </p>
	</c:when>
	<c:otherwise>
		<table>
			<thead>
				<tr>
<!-- 					<th> -->
<!-- 						복약로그 ID -->
<!-- 					</th> -->
					<th>
						사용자 성명
					</th>
					<th>
						복용한 약품이름
					</th>
<!-- 					<th> -->
<!-- 						복약한 시간알림 ID -->
<!-- 					</th> -->
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
				<c:forEach var="avo" items="${recordSelectByAll}">
				<tr>
<%-- 					<td> ${avo.takeId} </td> --%>
					<td> ${name} </td>
					<c:forEach var="sdl" items="${avo.scheduleList}"><td> ${sdl.scheTitle}</td></c:forEach>
<%-- 					<td> ${avo.timeId} </td> --%>
					<c:forEach var="stl" items="${avo.scheTimeList}"><td> ${stl.timeName}</td></c:forEach>
					<td> ${avo.takeDate} </td>
					<td> ${avo.takeSuccess} </td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>
</div>

<p><br><br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<br><br></p>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
	//JSON객체선언
	var jsonData = ${JSON}
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/record/chart.js"></script>
</body>
</html>