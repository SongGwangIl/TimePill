<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/record/main.css">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">

<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>


<span class="info-text GmarketSans" >
	${name}님!<br>
	오늘 복용할 알약 목록을 확인하세요! 
</span> 

 
<!-- 조회 날짜 선택 -->
<div class="box GmarketSans">
	<div id="current-time" class="current-time GmarketSans"></div>
	<div class="inner-contianer">
	<div id="container">
		<div class="form">
			<form action="${pageContext.request.contextPath}/alarmSelect.do" method="get">
				<label for="takeDate"> 조회 날짜 선택 : </label>
				<input type="date" id="takeDate" name="takeDate" class="GmarketSans">
				<input type="submit" value="조회">
			</form>
		</div>
		
		<c:choose>
			<c:when test="${alarmList.isEmpty()}">
				<p>지금 당장 알람을 등록해보세요!</p>
			</c:when>
			
			<c:otherwise>
				<table class="table" >
					<thead>
						<tr>
							<th>복용할 약 이름</th>
							<th>알람 이름	</th>
							<th>설정 알람 시간</th>
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
									<td> ${stl.timeAlarm} </td>
								</c:forEach>

								<c:forEach var="stl" items="${al.scheTimeList}">
									<td>
										<form id="submitFrm" action="${pageContext.request.contextPath}/addlog.do" method="post">
											<input type="hidden" name="timeId" value="${stl.timeId}">
											<a id = "okaybtn" href="#" onclick="document.querySelector('#submitFrm').submit(); return false;"> 완료 </a>
										</form>
									</td>
								</c:forEach>
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
