<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	* {
		margin: 0;
		padding: 0;
		font-family: sans-serif;
		box-sizing: border-box;
	}
	
	body{
		display: flex;
		justify-content: center;
		align-items: center;
		min-height: 100vh;
	}
	
	.calendar{
		width: 300px;
		margin: 50px;
	}
	
	.header{
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
		overflow: visible;
		
	}
	
	.date{
		width: calc(100% / 7);
		padding: 15px;
		text-align: right;
		
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
		color: #fff;
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
	
	.sel{
		background: blue;
	}

	.startDay{
		background: yellowgreen;
	}
	.endDay{
		background: pink;
	}
		
</style>
</head>
<body>
	<section class="duration">
		<input type="text" id="start" placeholder="시작일" readonly>
		<input type="text" id="end" placeholder="종료일" readonly>
		<button onclick="reset()">초기화</button>
	</section>
	<section class='calendar'>
		<div class='header'>
			<div class="year-month"></div>
			<div class="nav">
				<button class="nav-btn go-prev" onclick='prevMonth()'>&lt;</button>
				<button class="nav-btn go-today" onclick='goToday()'>Today</button>
				<button class="nav-btn go-next" onclick='nextMonth()'>&gt;</button>
			</div>
		</div>
		<div class='main'>
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

	//달력을 보여주는 함수
	function renderCalendar(){
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
			el.append(sp);

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
	}
	//달력그리기 & 클릭이벤트 등록
	renderCalendar();
	document.addEventListener('DOMContentLoaded', addEvent);
	
	//달력날짜 초기화
	function clearCalendar(){
		const datesEl = document.querySelector('.dates');
		datesEl.remove();
		let newDatesEl = document.createElement('div');
		newDatesEl.classList.add('dates');
		document.querySelector('.days').after(newDatesEl);
	}

	//전 달로 이동
	function prevMonth(){
		clearCalendar();
		date.setMonth(date.getMonth()-1);	
		renderCalendar();
		addEvent();
	}

	//다음 달로 이동
	function nextMonth(){
		clearCalendar();
		date.setMonth(date.getMonth()+1);
		renderCalendar();
		addEvent();
	}

	//현재날짜로이동
	function goToday(){
		clearCalendar();
		date = new Date();
		renderCalendar();
		addEvent();
	}

	let startFlag = true;
	let startDate;
	let endDate;
	let startTime;
	let endTime;
	
	//이벤트 등록
	function addEvent(){
		let dates = document.querySelectorAll('.dates > div');
		
		for(d of dates){
			//현재달에 포함된 날짜에만 이벤트 등록
			if(d.classList.contains('this')){
				d.onclick = (e)=>{
					//시작날짜와 끝날짜가 등록되어있으면 초기화
					if(startDate !== null && endDate !== null){
						removeStartDay();
						removeEndDay();					
					}				
					//시작날짜 입력
					if(startFlag){				
						setStartDate(e);
						setStartDay(e);
						startFlag = false;
					}
					//시작날짜 입력시 실행
					else{
						setEndDate(e);
						//시작날짜와 끝날짜를 비교하여 시작날짜로 표시하는 경우
						if(reValue()){
							removeStartDay();
							setStartDate(e);
							removeEndDay();
							setStartDay(e);
						}
						//끝날짜로 표시하는 경우
						else{
							setEndDay(e);
							startFlag = true;					
						}
					}
					
				}
			}	
		}
	}
	
	//시작날짜등록
	function setStartDate(e){
		startDate = e.target.textContent;
		startTime =	new Date(date.getFullYear(), date.getMonth(), e.target.textContent);		
	}

	function setStartText(e){
	}
	
	//시작날짜 달력에 등록
	function setStartDay(e){
		
		if(e.target.tagName === 'SPAN'){
			e.target.parentElement.classList.add('startDay');					
		}
		else{
			e.target.classList.add('startDay');			
		}		

		let year = date.getFullYear();
		let month = date.getMonth() + 1;
		let ym = year + '-' + month;
		document.querySelector('#start').value = ym + '-' + startDate;
	}
	
	//시작날짜 달력에서 제거
	function removeStartDay(){
		let startDays = document.querySelectorAll('.startDay'); 
		for(day of startDays){
			day.classList.remove('startDay');
		}
	}

	//종료날짜 등록
	function setEndDate(e){
		endDate = e.target.textContent;
		endTime = new Date(date.getFullYear(), date.getMonth(), e.target.textContent);
	}

	//종료날짜 달력에 등록
	function setEndDay(e){
		
		
		if(e.target.tagName === 'SPAN')
			e.target.parentElement.classList.add('endDay');
		else
			e.target.classList.add('endDay');
		

		let year = date.getFullYear();
		let month = date.getMonth() + 1;
		let ym = year + '-' + month;
		document.querySelector('#end').value = ym + '-' + endDate;		
	}
	
	//시작날짜와 끝날짜 비교 
	//시작날짜를 다시 셋팅하는경우: true
	//종료날짜를 셋팅하는경우: false
	function reValue(){
		
		return startTime-endTime >= 0 ? true : false;
	}	
	
	//종료날짜 달력에서 제거 및 종료날짜 초기화  
	function removeEndDay(){
		if(document.querySelector('.endDay'))
			document.querySelector('.endDay').classList.remove('endDay');
		document.querySelector('#end').value = '';
		endDate = null;
	}

</script>
</body>
</html>