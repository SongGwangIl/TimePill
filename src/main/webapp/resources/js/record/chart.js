	var jsonObject = JSON.stringify(jsonData);
	var jData = JSON.parse(jsonObject);
	
	//날짜를 기준으로 오름차순 정렬
	jData.sort(function(a, b) {
	     return new Date(a.Date) - new Date(b.Date);
	});
	
	//초기화
	var labelList = [];
	var valueList = [];
	
	//JSON객체를 배열에 주입
	for(var i = 0; i<jData.length; i++) {
		var d = jData[i];
		var fmtDate = parseInt(d.Date.substring(8,10), 10) + "일";
			
		labelList.push(fmtDate);	//가로축
		valueList.push(d.Rate); 	//세로축
	}
	
	//data 세팅
	var data = {
	 		labels: labelList,
	 		datasets: [{
	 		data : valueList,
	 		backgroundColor: 'rgba(75, 192, 192, 0.2)',
			borderColor: 'rgba(75, 192, 192, 1)',
			borderWidth: 1
			}]	
	};
	
	//config 세팅
	var config = {
		    type: 'bar',
		    data: data,
		    options: {
		        scales: {
		            y: {
		                beginAtZero: true,
		                max: 100,
		                ticks: {
		                    stepSize: 20
		                }
		            }
		        },
		        plugins: {
		            title: {
		                display: true,
		                text: '복용 비율',
		                position: 'bottom'
		            }
		        }
		    }
		};
	
	//chart 객체
	var ctx1 = document.getElementById('recordChart').getContext('2d');
	new Chart(ctx1, config);
