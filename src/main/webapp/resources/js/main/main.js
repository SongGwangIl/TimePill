$(document).ready(function() {
	
	// 알람 시간 변경
	$('.timepick').on('focusout', function() {
		const timepick = $(this);
		const alarmTime = timepick.val();
		const alarmId = timepick.data('alarm');

		$.ajax({
			url: '/alarm',
			type: 'post',
			data: {
				alarmTime: alarmTime
				, alarmId: alarmId
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
	});

	// 복약 스케줄 완료 체크 동작
	$(document).on('click', '.sche-chk', function(e) {
		e.stopPropagation();
		const chk = $(this);

		// 클릭 이벤트 중복 방지
		if (chk.hasClass('disabled')) {
			return false;
		}

		// 클릭 이벤트 방지 클래스 추가
		chk.addClass('disabled');

		const icoSrc = chk.attr('src');
		const medId = chk.data('med-id');
		const alarmId = chk.data('alarm-id');
		const scheChk = icoSrc === '/resources/img/ico-checked.png' ? 'N' : 'Y';


		$.ajax({
			url: '/log',
			type: 'post',
			data: {
				medId: medId
				, alarmId: alarmId
				, scheChk: scheChk
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
				xhr.setRequestHeader("Accept", "application/json");
			},
			success: function(response) {
				if (response.scheChk === 'Y') {
					chk.attr('src', '/resources/img/ico-checked.png');
				} else if (response.scheChk === 'N') {
					chk.attr('src', '/resources/img/ico-unchecked.png');
				} else {
					alert('처리 중 문제가 발생했습니다.');
				}
				chk.removeClass('disabled');
			},
			error: function(error) {
				console.error('Error occurred: ' + error);
				alert('오류가 발생했습니다.');
			}
		});
	});
	
	// 하루 일정 가져오기
	// getDaySche();
});