var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

let uncompTodoCntList;

async function getUncompTodoCntList() {
	await $.ajax({
		url: '/mthSchedule',
		type: 'post',
		data: {
			mthStartDate: firstDate
			, mthEndDate: lastDate
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/json");
		},
		success: function(response) {
			// 							console.log(response.mthScheList);
			uncompTodoCntList = response.mthScheList; // 날짜별 미완료 스케줄 리스트

		},
		error: function(error) {
			console.error('Error occurred: ' + error);
			alert('오류가 발생했습니다.');
		}
	});
	setTodoList();
}

// 하루 일정 가져오기
function getDaySche () {
	$.ajax({
		url: '/daySchedule',
		type: 'post',
		data: {
			selectedDay: selectedDay
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/json");
		},
		success: function(response) {
			// console.log(response.dayScheList);
			getTodo(response.dayScheList);
		},
		error: function(error) {
			console.error('Error occurred: ' + error);
			alert('오류가 발생했습니다.');
		}
	});
}
	
// Todo 리스트 생성
function getTodo (dayScheList) {
	for (const daySchedule of dayScheList) {
	    
		// 담을 박스 선택
		let alarmDiv = $('div[data-alarm-id="'+ daySchedule.alarmId +'"]');

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
		alarmDiv.find('.daySchedule').get(0).appendChild(newImg);
	    alarmDiv.find('.daySchedule').get(0).appendChild(newSpan);
	    alarmDiv.find('.daySchedule').get(0).appendChild(br);
	}
}
