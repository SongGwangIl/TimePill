var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

let userId = document.querySelector("#userId");
let idCheck = document.querySelector("#idCheck");
userId.oninput = checkId;

function checkId(){
	console.log('아이디체크동작');
  let userIdVal = userId.value;
  let idFlag = false;
  const idRegExp = /^[a-zA-Z0-9]{4,15}$/;
  if(!idRegExp.test(userIdVal)){
    idCheck.innerText = "4~15자리의 영문이나 숫자를 가져야 합니다."
    idCheck.style.color = "#dc3545";
    idCheck.style.fontSize = '16px';
    userId.focus();  
  }
  else {
    idFlag = true;  
  }    
  
  if(idFlag == true){
    $.ajax({
		url : "/user/check-id",
		type: "post",
		data: {userId:userIdVal},
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/json");
		},
		success: function(result){
        	if(result == 1){
          		idCheck.innerText = "이미 사용중인 아이디입니다.";
          		idCheck.style.color = "#dc3545";
          		idCheck.style.fontSize = '16px';
          		idCheck.setAttribute('check', 'false');
          		check();
        	}
        	else if(result == 0){
          		idCheck.innerText = "사용할 수 있는 아이디입니다."
          		idCheck.style.color = "#2fb380"    
          		idCheck.style.fontSize = '16px';
          		idCheck.setAttribute('check', 'true');
          		check();
        	}
		},
      	error: function(){
        	alert("서버요청실패")
      	}
    });
  }
  
  
}
  

let pwVal = "", pwReVal = ""
const pw = document.querySelector('#password')
const pwMsg = document.querySelector('#userPwdMsg')
pw.addEventListener('input', () => {
  const pwRegExp = /^(?=.*[A-z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{10,20}$/
  pwVal = pw.value
  if(pwRegExp.test(pwVal)) { // 정규식 조건 만족 O
    pwMsg.textContent = "조건만족"
    pwMsg.style.color = "#2fb380"
    pwMsg.style.fontSize = '16px';
  } 
  else { // 정규식 조건 만족 X
    pwMsg.textContent = "10~20자 영문, 숫자, 특수문자를 사용하세요."
    pwMsg.style.color = "#dc3545";
    pw.focus();
//    pw.value = null;
  }
  check();
  
});

/*** SECTION - PASSWORD RECHECK ***/
const pwRe = document.querySelector('#checkUserPwd')
const pwReMsg = document.querySelector('#checkUserPwdMsg')
pwRe.addEventListener('change', () => {
  checkPwValid()
});

// 비밀번호와 재입력 값 일치 여부
function checkPwValid() {
	pwVal = pw.value;
	pwReVal = pwRe.value;
	const pwRegExp = /^(?=.*[A-z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{10,20}$/
    
    if(pwReVal === "") { // 미입력
      pwReMsg.textContent = "다시 입력해 주세요"
    }
    else if(!pwRegExp.test(pwReVal)){ // 정규식 조건 만족 X
    	pwReMsg.style.color = "#dc3545";
		pwReMsg.textContent = "10~20자 영문, 숫자, 특수문자를 사용하세요.";
		pwReMsg.style.fontSize = '16px';
		pwRe.value = null;
    	pwRe.focus();
    }
    else if(pwVal === pwReVal) { // 비밀번호 재입력 일치      
      pwReMsg.style.color = "#2fb380";
      pwReMsg.textContent = "일치";
      pwReMsg.style.fontSize = '16px';
    }
    else { // 비밀번호 재입력 불일치
      pwReMsg.style.color = "#dc3545";
      pwReMsg.textContent = "불일치";
      pwReMsg.style.fontSize = '16px';
      
      pwRe.value = null;
      pwRe.focus();
    }
    check();
}

function autoEmail(a,b){
  
  const mailId = b.split('@'); // 메일계정의 ID만 받아와서 처리하기 위함
  const mailList = ['naver.com','gmail.com','daum.net','hanmail.net','yahoo.com','outlook.com','nate.com','kakao.com']; // 메일목록
  let availableCity = new Array; // 자동완성 키워드 리스트
  
  if(true){  

    for(let i=0; i < mailList.length; i++ ){
      availableCity.push( mailId[0] +'@'+ mailList[i] ); // 입력되는 텍스트와 메일목록을 조합
    }
    $("#"+a).autocomplete({
      source: availableCity // jQuery 자동완성에 목록을 넣어줌
    });
  }
  else{
    availableCity = new Array;
    $("#"+a).autocomplete({    
      source: availableCity      
    });
  }
  emailCheck();
}
  
const email = document.querySelector("#email");
const emailP = document.querySelector('#emailCheck');
let emailVal;
email.addEventListener('input', emailCheck);

function emailCheck(){
  const eamilRegExp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i
  emailVal = email.value
  let emailFlag = false;
  if(!eamilRegExp.test(emailVal)) { // 정규식 조건 만족 X
    emailP.textContent = "이메일 형식이 아닙니다.";
	emailP.style.color = "#dc3545";
	emailP.style.fontSize = '16px';
	emailP.setAttribute('check', 'false');
	email.focus();    
	check();
  }else
  	emailFlag = true;  
  	
  if(emailFlag == true){
    $.ajax({
		url : "/user/check-email",
		type: "post",
		data: {email:emailVal},
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
			xhr.setRequestHeader("Accept", "application/String");
		},
		success: function(result){			
        	if(result == 0){
          		emailP.textContent = "등록 가능한 메일입니다."
          		emailP.style.color = "#2fb380"    
          		emailP.style.fontSize = '16px';
          		emailP.setAttribute('check', 'true');
          		check();
        	}
        	else{        	
          		emailP.textContent = "이미 등록된 메일입니다.";
          		emailP.style.color = "#dc3545";
          		emailP.style.fontSize = '16px';
          		emailP.setAttribute('check', 'false');
    			email.focus();
    			check();
        	}
		},
      	error: function(){
        	alert("서버요청실패");
      	}
    });
  }
  
}