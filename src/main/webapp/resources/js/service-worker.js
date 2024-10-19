self.addEventListener('install', (event) => {
	console.log('Service Worker: Installed');
});

self.addEventListener('activate', (event) => {
	console.log('Service Worker: Activated');
	return self.clients.claim();
});

self.addEventListener('fetch', (event) => {
	console.log('Service Worker: Fetching', event.request.url);
	event.respondWith(
		fetch(event.request).catch(() => new Response('Fetch failed'))
	);
});

// 푸시알림
self.addEventListener('push', function(event) {
	console.log('푸시알림 받음');
	// 푸시 메시지의 데이터가 JSON 형식으로 전달된다고 가정
	let data = {};
	if (event.data) {
		data = event.data.json();
	}

	const title = data.title || '기본 제목';
	const options = {
		body: data.body || '기본 메시지 본문',
		icon: data.icon || '/resources/img/logo.svg',
		data: {
			url: data.url || '/'
		}
	};

	// 알림 표시
	event.waitUntil(
		self.registration.showNotification(title, options)
	);
});

// 알림 클릭 이벤트 처리
self.addEventListener('notificationclick', function(event) {
	event.notification.close();

	// 알림 클릭 시 URL로 이동
	event.waitUntil(
		clients.openWindow(event.notification.data.url)
	);
});
