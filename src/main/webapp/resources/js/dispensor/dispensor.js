/*const sse = new EventSource("http://localhost:6060/kopo/dispensor");

sse.addEventListener('connect', (e) => {
	const { data: receivedConnectData } = e;
	consol.log('connect event data: ', receivedConnectData);
});

sse.addEventListener('update', (e) => {
	const { data: receivedUpdateData } = e;
	consol.log('update event!', receivedUpdateData);

});*/

	$(document).ready(function (){
		var alarms;
		getAlarms();		
		
		for(let i=0; i<3; i++){
			setTimeout(setAlarm,3000*(i+1));
		}
		function getAlarms () {

			$.ajax({
				url: '/kopo/dispensor/getAlarms',
				type: 'post',
				
				success: function(o) {
					alarms = o.arlarms;
					console.log(alarms);
				},
				error: function(error) {
					console.error('Error occurred: ' + error);
				}
			});
		}
		function setAlarm(i){
			console.log('alarm');
		}
	});