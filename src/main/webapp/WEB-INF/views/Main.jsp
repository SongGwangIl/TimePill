<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="TimePill - 스케줄 관리"/>
</c:import>

<style>
	.input-container {
	    position: relative;
	    display: inline-block;
	}
	.input-container input {
	    position: relative;
	    z-index: 1;
	}
	.input-container::after {
	    content: '';
	    position: absolute;
	    top: 0;
	    left: 0;
	    width: 80%;
	    height: 100%;
	    background: rgba(255, 255, 255, 0.0); /* 반투명 막 */
	    pointer-events: auto; /* 클릭 불가 */
	    z-index: 2;
	}
</style>

<div id="contents">

	<div class="greeting">
	    <h3> <c:out value="${loginUser.nickname}"/> 님, <br>
	        오늘의 복약정보를 확인하세요!
	    </h3>
	</div>
	
	<span id="selectedDay"></span>
	
	<div class="slider-container">
		<div class="bxslider center">
			<c:forEach var="resultAlarm" items="${alarmList}">
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
   					<div class="input-container">
   					<input type="time" class="timepick" step="300" name="alarmTime" 
   						value="<fmt:formatDate value="${alarmTime}" pattern="HH:mm"/>" data-alarm="${resultAlarm.alarmId}" required style="border: 0px;">
					</div>
					<br>
					
					<%-- 복약 일정 --%>
					<div class="daySchedule"></div>
				</div>
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
	        touchEnabled: false,  // 터치 드래그 활성화 (모바일 등 터치 디바이스에서 동작)
	    });
	});
	$('.bxslider').on('click', 'input', function(event) {
	    event.stopPropagation();
	});
</script>
<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>

