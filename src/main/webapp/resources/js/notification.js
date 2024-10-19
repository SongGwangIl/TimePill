// 암호화
function urlB64ToUint8Array(base64String) {
	const padding = '='.repeat((4 - base64String.length % 4) % 4);
	const base64 = (base64String + padding)
		.replace(/-/g, '+')
		.replace(/_/g, '/');

	const rawData = window.atob(base64);
	const outputArray = new Uint8Array(rawData.length);

	for (let i = 0; i < rawData.length; ++i) {
		outputArray[i] = rawData.charCodeAt(i);
	}
	return outputArray;
}

// 서버에 구독 전송
function sendSubscriptionToServer(subscription) {
	console.log('서버에 구독전송 실행')
	$.ajax({
		url: '/subscribe',
		type: 'post',
		contentType: 'application/json',
		data: JSON.stringify(subscription),
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/json");
		},
		success: function(response) {
			alert('성공');
			console.log(response);
		},
		error: function(error) {
			console.error('Error occurred: ' + error);
			alert('오류가 발생했습니다.');
		}
	});
}


// 서비스 워커 실행
function notification() {
	// 서비스 워커와 푸시 알림 지원 여부 확인
	if ('serviceWorker' in navigator && 'Notification' in window) {
		let pushFlag = false;
		// 서비스 워커 등록
		navigator.serviceWorker.register('/resources/js/service-worker.js')
			.then((registration) => {
				console.log('서비스 워커 등록');
	
				// 알림 권한 요청
				return Notification.requestPermission().then((permission) => {
	
					// 사용자가 알림 권한을 허용한 경우
					if (permission === 'granted') {
						pushFlag = true;
						console.log('알림 권한 허용');
	
						// 현재 브라우저의 푸시 구독 정보 확인
						return registration.pushManager.getSubscription().then((subscription) => {
							console.log('구독정보', subscription);
	
							// 푸시 구독 정보가 없는 경우, 새로운 구독 설정
							if (subscription === null) {
								
								// VAPID
								const applicationServerKey = urlB64ToUint8Array('BCJ48EUchoo9GFCDrx6HU9Zz3FGh1svu4ZpX-sBSJT96afuKl_bjC21EkBHc-7ymkPlcNAOdTE0JRMOp9ecdexg');
								
								// 신규 구독
								return registration.pushManager.subscribe({
									userVisibleOnly: true,
									applicationServerKey: applicationServerKey
								}).then((subscription) => {
									// DB에 구독정보 저장
									sendSubscriptionToServer(subscription);
									return subscription;
								}).catch((error) => {
									console.error('Subscription failed', error);
									alert('푸시알림 설정 중 오류가 발생하였습니다.');
									throw error;
								});
								
							} else {
								// 구독 정보가 이미 있는 경우, 기존 구독 반환
								return Promise.resolve(subscription);
							}
						});
					} else {
						// 사용자가 알림 권한을 거부한 경우
						pushFlag = false;
						alert('브라우저 알림 권한이 거부되었습니다.\n권한을 다시 허용하려면 브라우저 설정에서 변경해주세요.');
						console.log('알림 권한 거부');
					}
				});
			})
			.then((subscription) => {
				if(pushFlag && subscription != undefined) {
					alert('브라우저 푸시 알림이 설정되었습니다.');
				}
			})
			.catch((error) => {
				// 서비스 워커 등록 또는 알림 권한 요청 중 오류 발생 시
				// console.error(error);
				alert(error);
				alert('푸시알림 서비스 오류');
			});
	} else {
		alert('브라우저 푸시알림을 지원하지 않는 브라우저입니다.');
	}
}

// 서버에 구독 취소 정보 전송
function removeSubscriptionFromServer() {
	fetch('/api/subscription/unsubscribe', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ /* 구독 취소에 필요한 정보 */ })
	}).then(function(response) {
		if (!response.ok) {
			throw new Error('Failed to remove subscription from server');
		}
	}).catch(function(error) {
		console.error('Error removing subscription from server:', error);
	});
}

// 구독 취소
function unsubscribeUser() {
	navigator.serviceWorker.ready.then(function(registration) {
		registration.pushManager.getSubscription().then(function(subscription) {
			if (subscription) {
				// 구독 취소
				return subscription.unsubscribe();
			}
		}).then(function() {
			console.log('User is unsubscribed.');
			// 서버에 구독 취소 정보 전송
			// removeSubscriptionFromServer();
		}).catch(function(error) {
			console.error('Error unsubscribing', error);
		});
	});
}