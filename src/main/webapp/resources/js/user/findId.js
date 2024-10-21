let header = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
let token = document.querySelector("meta[name='_csrf']").getAttribute("content");

document.querySelector('#findId').onclick = findId;
document.querySelector('#goLogin').onclick = goLogin;

const btns = document.querySelector('#btns');

// MutationObserver 설정
const observer = new MutationObserver((mutations) => {
    mutations.forEach(mutation => {
        if (mutation.type === 'childList') {
        	let btn = document.querySelector('#resetPasswordBtn');
			btn.onclick = goResetPw;
        }
    });
});

// 관찰할 대상과 설정
observer.observe(btns, { childList: true });


function findId(){
	let userEmail = document.querySelector('#emailInp');
	let viewIdInp = document.querySelector('#viewId');
	let msgSp = document.querySelector('#msg');
	const template = document.querySelector('#findTemp');
	$.ajax({
		url: "/user/find-id",
		type: "post",
		data: {email: userEmail.value},
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/String");
		},
		success: function(result){
			if(result === ''){
				msgSp.innerText = "등록되지 않은 이메일 입니다.";
			}else{
				let rPBtn = document.querySelector('#resetPasswordBtn');
				if(rPBtn)
					rPBtn.remove();
					
				msgSp.textContent = "";
				viewIdInp.value = result;
				let clone = document.importNode(template.content, true);				
				document.querySelector('#btns').prepend(clone);
			}
		},
		error: function(){
			alert("서버요청실패");
		}				
	});
}

function goResetPw(){
	document.querySelector('#authEmailForm').submit();
}

function goLogin(){
	window.location.href = "/user/login";
}