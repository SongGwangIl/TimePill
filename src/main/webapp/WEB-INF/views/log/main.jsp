<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="TimePill - 메인"/>
</c:import>


<div class="whiteBox">


<span class="info-text GmarketSans" >
	${loginUser.nickname} 님!<br>
	오늘 복용 처방약 목록을 확인하세요! 
</span> 
	<div id="clock" class="clock"></div>
	
	<p> 조회 날짜에 따라서 목록이 바뀌는 fetch </p>
	<p> 오늘 먹어야 하는 처방약 목록 </p>
	<p> 세션에 저장된 유저아이디값을 활용하여 </p>
	<p> 시작날짜 만료 날짜 고려하여 약 목록</p>
	<p> 등록 테이블 조인해서 알람타입하고 시간도 가져와야함 </p>
	
	
	
	
	

 
<!-- <!-- 조회 날짜 선택 -->
<!-- <div class="box GmarketSans"> -->
<!-- 	<div class="inner-contianer"> -->
<!-- 	<div id="container"> -->
<!-- 		<div class="form"> -->
<%-- 			<form action="${pageContext.request.contextPath}/alarmSelect.do" method="get"> --%>
<!-- 				<label for="takeDate"> 조회 날짜 선택 : </label> -->
<!-- 				<input type="date" id="takeDate" name="takeDate" class="GmarketSans"> -->
<!-- 				<input type="submit" value="조회"> -->
<!-- 			</form> -->
<!-- 		</div> -->
		
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${alarmList.isEmpty()}"> --%>
<!-- 				<p>지금 당장 알람을 등록해보세요!</p> -->
<%-- 			</c:when> --%>
			
<%-- 			<c:otherwise> --%>
<!-- 				<table class="table" > -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th>복용할 약 이름</th> -->
<!-- 							<th>알람 이름	</th> -->
<!-- 							<th>설정 알람 시간</th> -->
<!-- 							<th>복용 체크	</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
					
<!-- 					<tbody> -->
					
<%-- 						<c:forEach var="al" items="${alarmByDateList}"> --%>
<!-- 							<tr> -->
<%-- 								<c:forEach var="sdl" items="${al.scheduleList}"> --%>
<%-- 									<td>${sdl.scheTitle}</td> --%>
<%-- 								</c:forEach> --%>

<%-- 								<c:forEach var="stl" items="${al.scheTimeList}"> --%>
<%-- 									<td>${stl.timeName}</td> --%>
<%-- 								</c:forEach> --%>

<%-- 								<c:forEach var="stl" items="${al.scheTimeList}"> --%>
<%-- 									<td> ${stl.timeAlarm} </td> --%>
<%-- 								</c:forEach> --%>

<%-- 								<c:forEach var="stl" items="${al.scheTimeList}"> --%>
<!-- 									<td> -->
<%-- 										<form id="submitFrm" action="${pageContext.request.contextPath}/addlog.do" method="post"> --%>
<%-- 											<input type="hidden" name="timeId" value="${stl.timeId}"> --%>
<!-- 											<a id = "okaybtn" href="#" onclick="document.querySelector('#submitFrm').submit(); return false;"> 완료 </a> -->
<!-- 										</form> -->
<!-- 									</td> -->
<%-- 								</c:forEach> --%>
<!-- 							</tr> -->
<%-- 						</c:forEach> --%>

<!-- 					</tbody> -->
<!-- 				</table> -->
<%-- 			</c:otherwise> --%>
<%-- 		</c:choose> --%>

<!-- 	<span class="text5"> -->
<%-- 		<a href="${pageContext.request.contextPath}/schedule/add.do">신규 알람 등록</a> --%>
<!-- 	</span> -->
<!-- 	</div> -->
<!-- </div> -->
<!-- </div> -->



<!-- 현재시간 -->
<script type="text/javascript">

	//시계 구현
	function currentTime() {
		var now = new Date();
		var year = now.getFullYear();
		var month = (String)(now.getMonth() + 1).padStart(2,'0');
		var day = (String)(now.getDate()).padStart(2,'0');
		var hours = (String)(now.getHours()).padStart(2,'0');
		var minutes = (String)(now.getMinutes()).padStart(2,'0');
		var seconds = (String)(now.getSeconds()).padStart(2,'0');
	
		var clock = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
		document.getElementById('clock').textContent = "현재 시각 : " + clock;
	}
	
	currentTime();
	
	//1초 간격으로 함수 실행 
	setInterval(currentTime, 1000);
</script>

</div>
<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>