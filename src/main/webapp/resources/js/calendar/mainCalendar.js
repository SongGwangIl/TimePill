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
//달력그리기 & 클릭이벤트 등록
renderCalendar();
document.addEventListener('DOMContentLoaded', function() {
	addEvent();
	// mainFunc.js 하루 일정 가져오기 함수
	getDaySche();
});

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

let selectedDay = date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate();
let selectedDaySpan = date.getFullYear() + '.' + String(date.getMonth()+1).padStart(2,'0') + '.' + String(date.getDate()).padStart(2,'0');
//이벤트 등록
function addEvent(){
	let dates = document.querySelectorAll('.dates > div');
	
	for(d of dates){
		//현재달에 포함된 날짜에만 이벤트 등록
		if(d.classList.contains('this')){
			d.querySelector('span').addEventListener('click', (e)=>{
					
					let selectedDay = document.querySelector('.selectedDay');
					if(selectedDay)	
						selectedDay.classList.remove('selectedDay');
					setSelectedDay(e);
					modal.style.display = "none"; // 모달 닫기
					// mainFunc.js 하루 일정 가져오기 함수
					getDaySche();				
			});
		}	
	}
}

//선택날짜 달력에 등록
function setSelectedDay(e){
	
	if(e.target.tagName === 'SPAN'){
		e.target.parentElement.classList.add('selectedDay');					
	}
	else{
		e.target.classList.add('selectedDay');			
	}		

	let year = date.getFullYear();
	let month = date.getMonth() + 1;
	let ym = year + '-' + month;
	selectedDay = ym + '-' + e.target.textContent;
	selectedDaySpan = year + '.' + String(month).padStart(2,'0') + '.' + e.target.textContent.padStart(2,'0');
}

//선택날짜 달력에서 제거
function removeSelectedDay(){
	document.querySelector('.selectedDay').remove(); 
}


// todo 리스트 캘린터에 추가
function setTodoList(){
	let keys = Object.keys(uncompTodoCntList).map(key=>+key.substring(8));
	let values = Object.values(uncompTodoCntList);
	let thisSpans = document.querySelectorAll('.this>span');
	
	for(let i=0; i<keys.length; i++){
		for(thisSpan of thisSpans){
			if(keys[i] == thisSpan.textContent){
				thisSpan.nextElementSibling.textContent = values[i];				
			}
		}
	}	
}