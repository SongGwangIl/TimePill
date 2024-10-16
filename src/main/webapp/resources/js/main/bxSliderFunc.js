$(document).ready(function() {
	const windowWidth = $(window).width();
	let imgSize;
	
	// bx슬라이더 데스크탑 및 모바일 너비 설정
	function getBxWidth() {
		return windowWidth >= 480 ? 330 : 280
	}
	function adjustButtonSize() {
		imgSize = windowWidth >= 480 ? '30px' : '20px';
	}

	adjustButtonSize();

	$('.bxslider').bxSlider({
		mode : 'horizontal',
		slideWidth : getBxWidth(),
		infiniteLoop : true,
		nextSelector : '.next',
		touchEnabled : false,
		prevSelector : '.prev',
		onSliderLoad : function() {
			// prev 버튼 처리
			const prevLink = document.querySelector('.prev .bx-prev');
			if (prevLink) {
				prevLink.textContent = ''; // Prev 텍스트 제거
				const prevImgElement = document.createElement('img');
				prevImgElement.src = '/resources/img/left.png'; // prev 이미지 경로
				prevImgElement.style.width = imgSize;
				prevLink.appendChild(prevImgElement);
			}
			// next 버튼 처리
			const nextLink = document.querySelector('.next .bx-next');
			if (nextLink) {
				nextLink.textContent = ''; // Next 텍스트 제거
				const nextImgElement = document.createElement('img');
				nextImgElement.src = '/resources/img/right.png'; // next 이미지 경로
				nextImgElement.style.width = imgSize;
				nextLink.appendChild(nextImgElement);
			}
		},
	});
});