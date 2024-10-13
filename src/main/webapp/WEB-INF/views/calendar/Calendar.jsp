<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<head>
<meta charset="UTF-8">

<style type="text/css">

	cBody * {
		clear: both;
	}
	
	cBody{
		margin: 0;
		padding: 0;
		box-sizing: border-box;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.calendar{
		width: 300px;
		margin: 50px;
	}
	
	.calHeader{
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.year-month {
		font-size: 20px;
	}
	
	.nav{
		margin: 0 auto;
		display: flex;
		
		
	}
	
	.nav-btn{
		width: 50px;
		height: 30px;
		border: none;
		font-size: 16px;
		line-height: 34px;
		background: transparent;
		cursor: pointer;
		padding-left: 10px;
		padding-right: 10px;
		
	}
	
	.go-today {
		width: 75px;
	}
	
	.days{
		display: flex;
		margin: 25px 0 10px;
	}
	
	.day{
		width: calc(100% / 7);
		text-align: center;
	}
	
	.dates{
		display: flex;
		flex-flow: row wrap;
		height: 300px;
		align-items: center;
	}
	
	.date{
		width: calc(100% / 7);
		text-align: center;
		height: calc(100%/7);
		position: relative;	
		border-radius: 5px;
	}
	.date>p{
		position: absolute;
		top: 10px;
		left: 18px;
		font-size: 10px;
		color: black;
		pointer-events: none;
	}
	.date.this>span{
		display: inline-block;
		width: 40px;
		height: 40px;
		cursor: pointer;
	}
	.date>p[data-id]{
		top: 20px;
		left: 8px;
	}
	
	.day:nth-child(7n + 1),
	.date:nth-child(7n + 1) {
		color: #d13e3e;
	}
	
	.day:nth-child(7n),
	.date:nth-child(7n) {
		color: #396ee2;
	}
	
	.other{
		opacity: 0.3;
	}

	.today{
		position: relative;
		font-weight: 900;
		color: #1188dd;
	}
	

	.startDay{
		background: yellowgreen;
	}
	.period{
		background: yellow;
	}
		
	.endDay{
		background: pink;
	}
	.selectedDay{
		background: olive;
	}
</style>
</head>

<cBody>
<!-- 	<section> -->
<!-- 		<input id="start" readonly> -->
<!-- 		<input id="end" readonly> -->
<!-- 	</section> -->
	<section class='calendar'>
		<div class='calHeader'>
			<div class="nav">
				<button type="button" class="nav-btn go-prev" onclick='prevMonth()'>&lt;</button>
				<div class="year-month"></div>
				<button type="button" class="nav-btn go-next" onclick='nextMonth()'>&gt;</button>
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
