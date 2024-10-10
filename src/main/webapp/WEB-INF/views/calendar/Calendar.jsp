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
		font-size: 20px
	}
	
	.nav{
		display: flex;
		
	}
	
	.nav-btn{
		width: 28px;
		height: 30px;
		border: none;
		font-size: 16px;
		line-height: 34px;
		background: transparent;
		cursor: pointer;
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
	}
	.date>p{
		position: absolute;
		top: 10px;
		left: 18px;
		font-size: 10px;
		color: black;
	}
	.date>span{
		display: inline-block;
		width: 40px;
		height: 40px;
		cursor: pointer;
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
	
	.today::before{
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%,-50%);
		z-index: -1;
		width: 30px;
		height: 30px;
		display: block;
		background: #e84;
		border-radius: 50%;
		content: '';
	}
	.today{
		position: relative;
 		color: #e84;
	}
	

	.startDay{
		background: yellowgreen;
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
			<div class="year-month"></div>
			<div class="nav">
				<button type="button" class="nav-btn go-prev" onclick='prevMonth()'>&lt;</button>
				<button type="button" class="nav-btn go-today" onclick='goToday()'>Today</button>
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
<script type="text/javascript">

	//리셋버튼동작
	function reset(){
		document.querySelector('#start').value = '';
		document.querySelector('#end').value = '';
		removeStartDay();
		removeEndDay();
		goToday();
	}
	//현재 날짜를 저장
	let date = new Date();
	let firstDate;
	let lastDate;

	//달력을 보여주는 함수
	async function renderCalendar(){
		const viewYear = date.getFullYear();
		const viewMonth= date.getMonth();
		
		//현재 연도와 월 표시
		document.querySelector('.year-month').textContent = viewYear+ "년 " + (viewMonth + 1) +"월";

		//지난달과 이번달의 마지막 날
		const prevLast = new Date(viewYear, viewMonth, 0);
		const thisLast = new Date(viewYear, viewMonth + 1, 0); 
		
		//지난달 마지막날의 날짜와 요일
		const PLDate = prevLast.getDate(); 
		const PLDay = prevLast.getDay(); 

		//이번달 마지막날의 날짜와 요일
		const TLDate = thisLast.getDate();
		const TLDay = thisLast.getDay();
		
		firstDate = viewYear + "-" + (viewMonth+1) + "-01";
		lastDate = viewYear + "-" + (viewMonth+1) + "-" + TLDate;

		//달력합치기
		const prevDates = [];
		const thisDates = [...Array(TLDate + 1).keys()].slice(1);
		const nextDates = [];

		// 지난달 날짜 추가
		if(PLDate !== 6)
			for(let i=0; i<PLDay+1; i++)
				prevDates.unshift(PLDate - i);
		
		// 다음달 날짜 추가
		for(let i=1; i<7-TLDay; i++)
			nextDates.push(i);

		const dates = prevDates.concat(thisDates, nextDates);
		const firstDateIndex = dates.indexOf(1);
		const lastDateIndex = dates.lastIndexOf(TLDate);
		const dateEl = document.querySelector('.dates');

		//날짜를 달력에 추가
		dates.forEach((date, i)=> {
			const condition = (i >= firstDateIndex && i < lastDateIndex + 1) ? 'this' : 'other';
			let el = document.createElement('div');
			el.setAttribute('class', 'date ' + condition);
			let sp = document.createElement('span');
			sp.textContent = date;
			let p = document.createElement('p');
			el.append(sp);
			el.append(p);

			dateEl.append(el);
			
		});

		//오늘날짜 표시하기
		const today = new Date();

		if(viewMonth === today.getMonth() && viewYear === today.getFullYear()){
			for(let date of document.querySelectorAll('.this>span')){
				if(Number(date.innerHTML) === today.getDate()){
					date.classList.add('today');
					break;
				}
			}
		}
		
		// mainFunc.js 한달 일정 카운트 가져오기 함수
		await getUncompScheCntList();
	}
	
</script>
</cBody>
