let header = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
let token = document.querySelector("meta[name='_csrf']").getAttribute("content");

document.querySelector('#findIdBtn').onclick = findId;
document.querySelector('#goLoginBtn').onclick = goLogin;

const authNumDiv = document.querySelector('#authNumber');

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
observer.observe(authNumDiv, { childList: true });


function findId(){
	let userEmail = document.querySelector('#emailInp');
	let viewIdSp = document.querySelector('#viewId');
	let msgSp = document.querySelector('#msg');
	
	$.ajax({
		url: "/user/find-id",
		type: "post",
		data: {email: userEmail.value},
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/String");
		},
		success: function(result){
			console.log(result);
			if(result === ''){
				msgSp.innerText = "등록되지 않은 이메일 입니다.";
			}else{
				let rPBtn = document.querySelector('#resetPasswordBtn');
				if(rPBtn)
					rPBtn.remove();
					
				msgSp.textContent = "";
				viewIdSp.innerText = result;
				let resetPwBtn = document.createElement('button');
				resetPwBtn.type = 'button';
				resetPwBtn.id = 'resetPasswordBtn';
				resetPwBtn.textContent = "비밀번호 재설정"
				document.querySelector('#authNumber').append(resetPwBtn);
			}
		},
		error: function(){
			alert("서버요청실패");
		}				
	});
}

function goResetPw(){
	window.location.href = "/user/auth-email";
}

function goLogin(){
	window.location.href = "/user/login";
}