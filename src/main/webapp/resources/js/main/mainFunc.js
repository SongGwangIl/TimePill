// csrf 토큰
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

// 미완료 일정 리스트
let uncompTodoCntList;

// 한달 미완료 일정 리스트 가져오기(캘린더용) 
async function getUncompScheCntList() {
	await $.ajax({
		url: '/month-schedule',
		type: 'post',
		data: {
			mthStartDate: firstDate,
			mthEndDate: lastDate
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/json");
		},
		success: function(mthScheList) {
//			 console.log(mthScheList);
			uncompTodoCntList = mthScheList; // 날짜별 미완료 스케줄 리스트
		},
		error: function(error) {
			console.error('Error occurred: ' + error);
			alert('오류가 발생했습니다.');
		}
	});

	// mainCalendar.js 함수 (캘린더에 등록)
	setTodoList();
}


// 하루 일정 가져오기
function getDaySche() {
	$.ajax({
		url: '/day-schedule',
		type: 'post',
		data: {
			selectedDay: selectedDay
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/json");
		},
		success: function(dayScheList) {
//			console.log(dayScheList);
			createTodo(dayScheList);
		},
		error: function(error) {
			console.error('Error occurred: ' + error);
			alert('오류가 발생했습니다.');
		}
	});
}

// Todo 리스트 생성 (하루 일정)
function createTodo(dayScheList) {
	
	// 선택 날짜 표시
	document.querySelector('#selectedDay').textContent = selectedDaySpan;

	// Todo 초기화
	let alarmDiv = document.querySelectorAll('div.card');
	for (let result of alarmDiv) {
		result.querySelector('.daySchedule').innerHTML = '';
	}
	
	
	// Todo 생성 시작
	for (const daySchedule of dayScheList) {
		// 담을 박스 선택
		let alarmDiv = document.querySelectorAll('div.card[data-alarm-id="' + daySchedule.alarmId + '"]');

		// 체크박스 생성
		let newImg = document.createElement('img');
		newImg.className = "sche-chk";
		newImg.alt = "체크";
		newImg.width = 14;
		newImg.height = 14;
		newImg.setAttribute('data-med-id', daySchedule.medId);
		newImg.setAttribute('data-alarm-id', daySchedule.alarmId);
		newImg.style.display = 'inline-block';
		if (daySchedule.scheChk == "Y") {
			newImg.src = "/resources/img/ico-checked.png";
		} else {
			newImg.src = "/resources/img/ico-unchecked.png";
		}

		// 약이름 생성
		let newSpan = document.createElement('span');
		newSpan.textContent = daySchedule.medName;

		let br = document.createElement('br');

		// 생성된 element 담기
		for (let result of alarmDiv) {
			if (!result.classList.contains('bx-clone')) { // bx슬라이더 클론 제외
//				console.log(result);
				result.querySelector('.daySchedule').append(newImg);
				result.querySelector('.daySchedule').append(newSpan);
				result.querySelector('.daySchedule').append(br);
			}
		}

	}
	
	// 빈 daySchedule 처리
	let cards = document.querySelectorAll('.daySchedule');
	for(card of cards) {
		// 내용이 비어있는지 확인 및 bx슬라이더 클론 제외
		if (card.innerHTML.trim() === '' && !card.classList.contains('bx-clone')) {
			let newSpan = document.createElement('span');
			newSpan.textContent = '등록된 복약일정이 없습니다.';
			let br = document.createElement('br');
			let medRegistLink = document.createElement('a');
			medRegistLink.href = '/medication/reg';
			medRegistLink.textContent = '복약등록 바로가기'
		    card.append(newSpan);
		    card.append(br);
		    card.append(medRegistLink);
		}
	}
}




//알람 시간 변경
function updateAlarm() {
	const timepick = $(this);
	const alarmTime = timepick.val();
	const alarmId = timepick.data('alarm');

	$.ajax({
		url: '/alarm',
		type: 'post',
		data: {
			alarmTime: alarmTime,
			alarmId: alarmId
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/json");
		},
		success: function(response) {
			alert('알람 시간이 수정되었습니다.');
		},
		error: function(error) {
			console.error('Error occurred: ' + error);
			alert('오류가 발생했습니다.');
		}
	});
}

// 복약 스케줄 완료 체크 동작
function chkTodo(e) {
	e.stopPropagation();
	const chk = $(this);

	// 클릭 이벤트 중복 방지
	if (chk.hasClass('disabled')) {
		return false;
	}

	// 클릭 이벤트 방지 클래스 추가
	chk.addClass('disabled');

	// 변수 정의
	const icoSrc = chk.attr('src');
	const medId = chk.data('med-id');
	const alarmId = chk.data('alarm-id');
	const scheChk = icoSrc === '/resources/img/ico-checked.png' ? 'N' : 'Y';

	// ajax 요청
	$.ajax({
		url: '/log',
		type: 'post',
		data: {
			medId: medId,
			alarmId: alarmId,
			scheChk: scheChk
		},
		dataType: 'text',
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/json");
		},
		success: function(scheChk) {
			if (scheChk === 'Y') {
				chk.attr('src', '/resources/img/ico-checked.png');
			} else if (scheChk === 'N') {
				chk.attr('src', '/resources/img/ico-unchecked.png');
			} else {
				alert('처리 중 문제가 발생했습니다.');
			}
			chk.removeClass('disabled');
		},
		error: function(error) {
			console.error('Error occurred: ' + error);
			alert('오류가 발생했습니다.');
			chk.removeClass('disabled');
		}
	});
}



// 카카오톡 알림설정
function kakaoAlarmToggle() {
	event.stopPropagation();
	const chk = $(this);

	// 클릭 이벤트 중복 방지
	if (chk.hasClass('disabled')) {
		return false;
	}

	// 클릭 이벤트 방지 클래스 추가
	chk.addClass('disabled');

	// 변수 정의
	const icoSrc = chk.attr('src');
	let tokenUseAt = '';
	if (icoSrc === '/resources/img/ico-off.png') {
		if(!confirm('카카오 알림톡을 활성화 하시겠습니까?')) return false;
		tokenUseAt = 'Y'
	} else if (icoSrc === '/resources/img/ico-on.png') {
		if(!confirm('카카오 알림톡을 비활성화 하시겠습니까?')) return false;
		tokenUseAt = 'N'
	}
	

	// ajax 요청
	$.ajax({
		url: '/kakao/message',
		type: 'post',
		data: {
			tokenUseAt: tokenUseAt
		},
		dataType: 'text',
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/json");
		},
		success: function(result) {
			if (result == '') {
				alert('오류 : 카카오 복약 알림에 대한 권한이 없습니다.');
				chk.attr('src', '/resources/img/ico-off.png');
			} else if (result === 'Y') {
				chk.attr('src', '/resources/img/ico-on.png');
			} else if (result === 'N') {
				chk.attr('src', '/resources/img/ico-off.png');
			} else {
				window.location.href = result;
			}
			chk.removeClass('disabled');
		},
		error: function(error) {
			console.error('Error occurred: ' + error);
			alert('오류가 발생했습니다.');
			chk.removeClass('disabled');
		}
	});
}
