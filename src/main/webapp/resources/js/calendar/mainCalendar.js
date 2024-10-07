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

let selectedDay = date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate();
//이벤트 등록
function addEvent(){
	let dates = document.querySelectorAll('.dates > div');
	
	for(d of dates){
		//현재달에 포함된 날짜에만 이벤트 등록
		if(d.classList.contains('this')){
			d.onclick = (e)=>{
				let selectedDay = document.querySelector('.selectedDay');
				if(selectedDay)	
					selectedDay.classList.remove('selectedDay');
				setSelectedDay(e);
				

				
			}
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
}

//선택날짜 달력에서 제거
function removeSelectedDay(){
	document.querySelector('.selectedDay').remove(); 
}

