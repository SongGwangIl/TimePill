<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/resources/css/calendar/calendar.css">

<cBody>
<section class='calendar'>
	<div class='calHeader'>
		<div class="nav">
			<button type="button" class="nav-btn go-prev" onclick='prevMonth()'>
				<img class="move" alt="prevMonth" src="/resources/img/left-arrow.png">
			</button>
			<div class="year-month"></div>
			<button type="button" class="nav-btn go-next" onclick='nextMonth()'>
				<img class="move" alt="nextMonth" src="/resources/img/right-arrow.png">
			</button>
		</div>
	</div>
	<div class='calMain'>
		<div class="days">
			<div class="day">일</div>
			<div class="day">월</div>
			<div class="day">화</div>
			<div class="day">수</div>
			<div class="day">목</div>
			<div class="day">금</div>
			<div class="day">토</div>
		</div>
		<div class="dates"></div>
	</div>
</section>
</cBody>
