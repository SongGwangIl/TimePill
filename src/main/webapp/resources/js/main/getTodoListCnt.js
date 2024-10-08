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
