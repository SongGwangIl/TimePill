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