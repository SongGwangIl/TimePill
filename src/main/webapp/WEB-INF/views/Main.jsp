<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="TimePill"/>
</c:import>

<link rel="stylesheet" href="/resources/css/main.css">

<div id="contents" class="">

	<!-- 안내 박스-->
    <div class="greeting boxh">
        <h3 class="greetingdesc"> 
            <span class="hilightdesc"><c:out value="${loginUser.nickname}"/></span> 님, <br>
            복약스케줄을 확인하세요!
        </h3>
        <img class="fadein" src="/resources/img/pill.png" style="width: 70px; margin-left: 5%;">
    </div>
	
	<!-- 날짜 표기 -->
    <div class="datebox boxh" style="height: 15%;">
        <h3 id="selectedDay" class="hilightdesc" style="margin-right: 3%;"></h3>
        <div class="round-btn boxh" style="margin: 0;">
            <img class="calender" src="/resources/img/calender.png" style="width: 20px;"> 
        </div>
    </div>
	
	<div class="slider-container boxh">
		<!-- 이전 버튼 -->
        <div class="prev"></div>
	
		<div class="bxslider">
			<c:forEach var="resultAlarm" items="${alarmList}">
				<div class="card" data-alarm-id="${resultAlarm.alarmId}">
					<div class="boxv">
						<%-- 알람타입 --%>
						<h1 style="color: white; text-align: center; margin: 18px;">
							<c:choose>
								<c:when test="${resultAlarm.alarmType eq '1'}">
									아침약
								</c:when>
								<c:when test="${resultAlarm.alarmType eq '2'}">
									점심약
								</c:when>
								<c:when test="${resultAlarm.alarmType eq '3'}">
									저녁약
								</c:when>
								<c:when test="${resultAlarm.alarmType eq '4'}">
									취침전
								</c:when>
							</c:choose>
						</h1>
						
						<%-- 알람시간 --%>
						<fmt:parseDate value="${resultAlarm.alarmTime}" pattern="HH:mm:ss" var="alarmTime"/>
	   					<div class="whiteround boxh">
		   					<input type="time" class="timepick" step="300" name="alarmTime" 
		   						value="<fmt:formatDate value="${alarmTime}" pattern="HH:mm"/>" data-alarm="${resultAlarm.alarmId}" required style="border: 0px; pointer-events: none;">
	   						<p class="alarmdesc gsasdw" style="padding-top: 4px;"> 알림 </p>
	   						<img class="btn-spring" src="/resources/img/gear.png" style="width: 28px;">
						</div>
						
						<%-- 복약 일정 --%>
						<div class="daySchedule">
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<!-- 다음 버튼-->
        <div class="next"></div>
	</div>
	
	<sec:authorize access="principal.username.contains('KAKAO_')">
		<!-- 카카오톡 알림 받기 신청 -->
	    <div  class="boxh kakaobox">
	        <div>
	            <p class="caption"> 카카오 복약 알림을 받고 싶다면? </p>
	             <span class="kakao-span boxh"> <img src="/resources/img/kakao.png" width="15px"> 카카오톡 알림 설정 </span>
	        </div>
	        <div>
	        	<!-- 알림 토글 -->
				<img id="kakaoAlarmToggle" alt="카카오톡 알림 설정 버튼" src="" width="55px" style="margin-left:15%">
	            </label>
	        </div>
	    </div>
		<script>
			$(document).ready(function() {
				// 카카오 알림설정 동작
				$(document).on('click', '#kakaoAlarmToggle', kakaoAlarmToggle);
				// 카카오 알림설정 로드
				$('#kakaoAlarmToggle').click();
			});
		</script>
	</sec:authorize>
</div>

<!-- 모달 창 -->
<div class="modal">
	<div class="modal_body">
		<script src="/resources/js/main/mainFunc.js"></script>
		<!-- 캘린터 선택한 날짜 변수 : selectedDay -->
		<c:import url="/calendar"/>
		<script src="/resources/js/calendar/mainCalendar.js"></script>
	</div>
</div>

<!-- 빈 카드 템플릿 -->
<template id="blank-todo">
	<p class="alarmask">알림이 없습니다.</p>
	<p class="alarmask">지금 알림을 등록해보세요!</p>

	<a href="/medication/reg" class="white-btn">
		<div class="boxh white-btn">
			<img id="logo" src="/resources/img/logo.svg" style="width: 30px; margin: 0;">
			<p style="margin-left: 5px;">등록하기</p>
		</div>
	</a>
</template>

<!-- bxSlider SDK -->
<link rel="stylesheet" href="/resources/css/jquery.bxslider.css">
<script src="https://cdn.jsdelivr.net/npm/bxslider@4.2.17/dist/jquery.bxslider.min.js"></script>

<script>
$(function() {
	const windowWidth = $(window).width();
	let imgSize;
	function bxWitdth() {
		if (windowWidth > 360) {
			return 330; // 데스크탑 크기일 때
		} else {
			return 280; // 모바일 크기일 때
		}
	}
	function adjustButtonSize() {
		if (windowWidth > 360) {
			imgSize = '60px'; // 데스크탑
		} else {
			imgSize = '30px'; // 모바일
		}
	}

	adjustButtonSize();

	const slider = $('.bxslider').bxSlider({
		mode : 'horizontal',
		slideWidth : bxWitdth(),
		infiniteLoop : true,
		nextSelector : '.next',
		touchEnabled : false,
		prevSelector : '.prev',
		onSliderLoad : function() {
			// prev 버튼 처리
			const prevLink = document.querySelector('.prev .bx-prev');
			if (prevLink) {
				prevLink.textContent = ''; // Prev 텍스트 제거
				const prevImgElement = document.createElement('img');
				prevImgElement.src = '/resources/img/left.png'; // prev 이미지 경로
				prevImgElement.style.width = imgSize;
				prevLink.appendChild(prevImgElement);
			}
			// next 버튼 처리
			const nextLink = document.querySelector('.next .bx-next');
			if (nextLink) {
				nextLink.textContent = ''; // Next 텍스트 제거
				const nextImgElement = document.createElement('img');
				nextImgElement.src = '/resources/img/right.png'; // next 이미지 경로
				nextImgElement.style.width = imgSize;
				nextLink.appendChild(nextImgElement);
			}
			// viewport  처리
			const wid = document.querySelector('.bx-viewport');
			if (wid) {
				wid.style.width = '102%';
			}
		},
	});
});
</script>
<script>
// 페이지가 로드되었을 때
window.onload = function () {
    const fadeInElement = document.querySelector('.fadein');
    fadeInElement.style.opacity = '1';
};
</script>
<script>
// 모달 열기 
const modal = document.querySelector('.modal');
const btnOpenModal = document.querySelector('.round-btn');

btnOpenModal.addEventListener("click", () => { 
	modal.style.display = "flex";
	clearCalendar();
	renderCalendar();
	addEvent();
});

// 모달 외부를 클릭했을 때 모달 닫기
modal.addEventListener("click", (event) => {
    // 클릭한 요소가 모달 바디가 아닌 경우
    if (event.target === modal) {
        modal.style.display = "none"; // 모달 닫기
    }
});

</script>

<script>
// 알람시간 변경창 띄우기
$(document).ready(function() {
	$(function () {
	    const timePickImages = document.querySelectorAll('.btn-spring');

	    // 각 이미지에 대해 클릭 이벤트 리스너 추가
	    timePickImages.forEach((img) => {
	        img.addEventListener('click', function (event) {
	            const timeInput = this.closest('.boxh').querySelector('input[type="time"]');
	            if (timeInput) {
	                timeInput.showPicker();  // 시간 선택 팝업 띄우기
	            }
	        });
	    });
	});
	
	// 알람 시간 변경
	$('.timepick').on('change', updateAlarm);
	// 복약 스케줄 완료 체크 동작
	$(document).on('click', '.sche-chk', chkTodo);
	
});
</script>

<%-- footer --%>
<c:import url="/footer" charEncoding="utf-8"/>

