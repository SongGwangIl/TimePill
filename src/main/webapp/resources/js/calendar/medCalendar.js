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
		if(condition === 'this')
		el.setAttribute('data-time', viewYear+'-'+(viewMonth+1)+'-'+date);
		let sp = document.createElement('span');
		sp.textContent = date;
		let p = document.createElement('p');
		p.setAttribute('data-id', date);
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
	setCalendarText();
	removeCalendarDuration();
	setCalendarDuration();
}

//다음 달로 이동
function nextMonth(){
	clearCalendar();
	date.setMonth(date.getMonth()+1);
	renderCalendar();
	addEvent();
	setCalendarText();
	removeCalendarDuration();
	setCalendarDuration();
}

let startFlag = true;
let startDate;
let endDate;
let startTime;
let endTime;


let selectedDay = date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate();

//이벤트 등록
function addEvent(){
	let dates = document.querySelectorAll('.dates > div');
	
	for(d of dates){
		//현재달에 포함된 날짜에만 이벤트 등록
		if(d.classList.contains('this')){
			d.onclick = (e)=>{
				removeCalendarDuration()
				
				//<시작끝날등록 이벤트 시작>
				//시작날짜와 끝날짜가 등록되어있으면 초기화
				if(startDate !== null && endDate !== null){
					removeStartDay();
					removeEndDay();					
				}				
				//시작날짜 입력
				if(startFlag){
					setStartDate(e);
					setStartDay(e);
					setStartText();
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
						setStartText();
					}
					//끝날짜로 표시하는 경우
					else{
						setEndDay(e);
						setEndText();
						setCalendarDuration()
						startFlag = true;					
					}
				}
				//<시작끝날 이벤트 종료>				
			}
		}	
	}
}

//시작날짜등록
function setStartDate(e){
	startDate = e.target.textContent;
	startTime =	new Date(date.getFullYear(), date.getMonth(), e.target.textContent);		
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
	let month = String(date.getMonth() + 1).padStart(2,'0');
	let ym = year + '-' + month;
	
	document.querySelector('#start').value = ym + '-' + startDate.padStart(2,'0');
	
}
//시작일 달력에 표시
function setStartText(){
	let startD = +String(startInp.value).substring(8);
	document.querySelector('.this [data-id="' + startD + '"]').textContent = '시작일';
}

//종료일 달력에 표시
function setEndText(){
	let endD = +String(endInp.value).substring(8);
	document.querySelector('.this [data-id="' + endD + '"]').textContent = '종료일';
}

//시작날짜 달력에서 제거
function removeStartDay(){
	let startDays = document.querySelectorAll('.startDay'); 
	for(day of startDays){
		day.classList.remove('startDay');
		day.querySelector('p').textContent = '';
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
	let month = String(date.getMonth() + 1).padStart(2,'0');
	let ym = year + '-' + month;
	document.querySelector('#end').value = ym + '-' + endDate.padStart(2,'0');		
}

//시작날짜와 끝날짜 비교 
//시작날짜를 다시 셋팅하는경우: true
//종료날짜를 셋팅하는경우: false
function reValue(){
	
	return startTime-endTime >= 0 ? true : false;
}	

//종료날짜 달력에서 제거 및 종료날짜 초기화  
function removeEndDay(){
	let endDay = document.querySelector('.endDay');
	if(endDay){
		endDay.classList.remove('endDay');
		endDay.querySelector('p').textContent = '';	
	}
	document.querySelector('#end').value = '';
	endDate = null;
}


let startInp = document.querySelector('#start');
let endInp = document.querySelector('#end');

// 처방일자 만료일자 달력에 표시
function setCalendarText(){
	setCalendarStartText();
	setCalendarEndText();	
}

//시작일텍스트 달력에 표시
function setCalendarStartText(){
	let yearMonth = date.getFullYear() + '-' + String(date.getMonth()+1).padStart(2,'0');
	let startYM = String(startInp.value).substring(0,7);
	let startD = +String(startInp.value).substring(8);
	let daySpans = document.querySelectorAll('.date.this span');
	let tagP = document.querySelectorAll('.date.this p');

	if(startInp.value){
		if(yearMonth === startYM){
			for(let daySpan of daySpans){
				if(daySpan.textContent == startD){
					daySpan.parentElement.classList.add('startDay');
					setStartText();
				}
			}
		}			
	}
}

//종료일텍스트 달력에 표시
function setCalendarEndText(){
	let yearMonth = date.getFullYear() + '-' + String(date.getMonth()+1).padStart(2,'0');
	let endYM = String(endInp.value).substring(0,7);
	let endD = +String(endInp.value).substring(8);
	let daySpans = document.querySelectorAll('.date.this span');
	let tagP = document.querySelectorAll('.date.this p');

	if(endInp.value){
		if(yearMonth === endYM){
			for(let daySpan of daySpans){
				if(daySpan.textContent == endD){
					daySpan.parentElement.classList.add('endDay');
					setEndText();
				}
			}
		}
	}
}

//처방기간 달력에 표시
function setCalendarDuration(){
	let times = document.querySelectorAll('[data-time]');
	for(let time of times){
		let dataTime = new Date(time.getAttribute('data-time'));
		let startTime = new Date(startInp.value);
		let endTime = new Date(endInp.value);
		
		if(dataTime > startTime && dataTime < endTime){
			if(!time.classList.contains('endDay'))
				time.classList.add('period');
		}
	}
}

//처방기간 달력에서 제거
function removeCalendarDuration(){
	let selectsPeriod = document.querySelectorAll('.period');
	if(selectsPeriod)
		for(period of selectsPeriod)
		period.classList.remove('period');
}

setCalendarText();
setCalendarDuration();