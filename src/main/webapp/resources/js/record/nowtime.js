//시계 구현
	function displayCurrentTime() {
		var now = new Date();
		var year = now.getFullYear();
		var month = (String)(now.getMonth() + 1).padStart(2,'0');
		var day = (String)(now.getDate()).padStart(2,'0');
		var hours = (String)(now.getHours()).padStart(2,'0');
		var minutes = (String)(now.getMinutes()).padStart(2,'0');
		var seconds = (String)(now.getSeconds()).padStart(2,'0');

		var currentDateTimeString = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
		document.getElementById('current-time').textContent = "현재 시각 " + currentDateTimeString;
	}

	displayCurrentTime();
	setInterval(displayCurrentTime, 1000);