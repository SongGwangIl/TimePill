// 푸시알림 로직
function notification() {
	let pushUseAt = $('#pushUseAt'); // 푸시알림 활성화 버튼

	// 서비스 워커 및 알림 기능 지원 여부 확인
	if ('serviceWorker' in navigator && 'Notification' in window) {

		// 서비스워커 등록 및 푸시알림 권한 체크
		registerServiceWorker().then(registration => {
			if (registration) {
				// 구독정보 확인 및 구독
				checkAndSubscribePush(registration).then(subscription => {
					// 구독정보가 있을 때
					if (subscription) {
						// green
						pushUseAt.text('브라우저 푸시알림 사용중');
						return;
					}
				});
			}
		});
	} else {
		console.log('푸시알림 미지원 브라우저');
	}
	// red
	pushUseAt.text('브라우저에서 푸시알림 설정을 해보세요!');
}


// 서비스 워커 등록 및 알림 권한 요청
async function registerServiceWorker() {
	try {
		// 서비스 워커 등록
		const registration = await navigator.serviceWorker.register('/resources/js/main/service-worker.js');

		// 푸시알림 권한 확인
		const permission = await Notification.requestPermission();
		if (permission !== 'granted') {
			console.log('알림 권한 : 거부됨');
			return null;
		}
		console.log('알림 권한 : 허용됨');
		return registration;
	} catch (error) {
		console.error('서비스 워커 등록 or 알림 권한 요청 중 오류 발생:', error);
		return null;
	}
}


// 푸시알림 구독정보 확인 및 구독
async function checkAndSubscribePush(registration) {
	try {
		const subscription = await registration.pushManager.getSubscription();
		console.log('구독정보 여부 :', subscription == null ? 'N' : 'Y');

		// 구독정보가 없으면
		if (subscription === null) {
			// 키 암호화
			const applicationServerKey = urlB64ToUint8Array('BCJ48EUchoo9GFCDrx6HU9Zz3FGh1svu4ZpX-sBSJT96afuKl_bjC21EkBHc-7ymkPlcNAOdTE0JRMOp9ecdexg');
			// 신규구독
			const newSubscription = await registration.pushManager.subscribe({
				userVisibleOnly: true,
				applicationServerKey: applicationServerKey
			});
			console.log('신규 구독 :', newSubscription);
			// DB에 구독정보 저장
			sendSubscriptionToServer(newSubscription);
			return newSubscription;
		} else {
			console.log('기존 구독 :', subscription);
			return subscription;
		}
	} catch (error) {
		alert('푸시알림 설정 중 오류가 발생하였습니다.');
		return null;
	}
}


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
			console.log('DB에 저장 성공:', response);
		},
		error: function(error) {
			console.error('DB 저장 실패:', error);
			alert('푸시알림 설정 중 오류가 발생하였습니다.');
		}
	});
}