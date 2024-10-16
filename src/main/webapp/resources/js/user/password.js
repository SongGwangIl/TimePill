let pwVal = "", pwReVal = ""
const pw = document.querySelector('#password')
const pwMsg = document.querySelector('#userPwdMsg')
pw.addEventListener('change', () => {
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
    pw.value = null;
  }
  
});

/*** SECTION - PASSWORD RECHECK ***/
const pwRe = document.querySelector('#checkUserPwd')
const pwReMsg = document.querySelector('#checkUserPwdMsg')
pwRe.addEventListener('change', () => {
  checkPwValid()
});

// 비밀번호와 재입력 값 일치 여부
function checkPwValid() {
	pwReVal = pwRe.value
    
    if(pwReVal === "") { // 미입력
      pwReMsg.textContent = "다시 입력해 주세요"
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
}

