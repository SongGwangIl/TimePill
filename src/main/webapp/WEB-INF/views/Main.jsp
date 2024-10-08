<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="TimePill - 스케줄 관리"/>
</c:import>


<div id="contents">

	<div class="greeting">
	    <h3> <c:out value="${loginUser.nickname}"/> 님, <br>
	        오늘의 복약정보를 확인하세요!
	    </h3>
	</div>
	
	
	<div class="slider-container">
		<div class="bxslider center">
			<c:forEach var="resultAlarm" items="${alarmList}">
				<c:if test="${resultAlarm.alarmType ne previousAlarmType}">
					<c:set var="previousAlarmType" value="${resultAlarm.alarmType}" />
					<div class="card" data-alarm-id="${resultAlarm.alarmId}">
						<%-- 알람타입 --%>
						<c:choose>
							<c:when test="${resultAlarm.alarmType eq '1'}">
								아침
							</c:when>
							<c:when test="${resultAlarm.alarmType eq '2'}">
								점심
							</c:when>
							<c:when test="${resultAlarm.alarmType eq '3'}">
								저녁
							</c:when>
							<c:when test="${resultAlarm.alarmType eq '4'}">
								취침전
							</c:when>
						</c:choose>
						<br>
						<%-- 알람시간 --%>
						<fmt:parseDate value="${resultAlarm.alarmTime}" pattern="HH:mm:ss" var="alarmTime"/>
	   					<input type="time" class="timepick" step="300" name="alarmTime" value="<fmt:formatDate value="${alarmTime}" pattern="HH:mm"/>" data-alarm="${resultAlarm.alarmId}" required style="border: 0px;">
						<br>
						<div class="daySchedule">
						
						</div>
<%-- 						<c:forEach var="result" items="${scheList}"> --%>
<%-- 							<c:if test="${not empty result.medId}"> --%>
<%-- 								<c:if test="${result.alarmType eq resultAlarm.alarmType}"> --%>
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${result.scheChk eq 'Y'}"> --%>
<%-- 											<c:set var="icoUrl" value="/resources/img/ico-checked.png"/> --%>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<%-- 											<c:set var="icoUrl" value="/resources/img/ico-unchecked.png"/> --%>
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
<%-- 									<img class="sche-chk" alt="체크" src="${icoUrl}" width="14px" height="14px" data-med-id="${result.medId}" data-alarm-id="${resultAlarm.alarmId}" style="display: inline-block;"> --%>
<!-- 									<span class="med-title"> -->
<%-- 										${result.medName} --%>
<!-- 									</span> -->
<!-- 									<br> -->
<%-- 								</c:if> --%>
<%-- 							</c:if> --%>
<%-- 						</c:forEach> --%>
						
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
<script src="/resources/js/main/getTodoListCnt.js"></script>
<c:import url="/calendar"/><!-- 캘린터 선택한 날짜 변수 : selectedDay -->
<script src="${pageContext.request.contextPath}/resources/js/calendar/mainCalendar.js"></script>
<script src="/resources/js/main/main.js"></script>

<form action="/kakao/message" method="post">
	<input type="submit" value="메세지 보내기 테스트">
	<sec:csrfInput/>
</form>

</div>



<script>
        $(function () {
            $('.bxslider').bxSlider({
                mode: 'horizontal',
                slideWidth: 300,
                touchEnabled: true,  // 터치 드래그 활성화 (모바일 등 터치 디바이스에서 동작)
            });
        });
</script>
<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>

