const termsAgreeAll = document.querySelector("#termsAgreeAll")
const termsAgree1 = document.querySelector("#termsAgree1")
const termsAgree2 = document.querySelector("#termsAgree2")
const termsAgree3 = document.querySelector("#termsAgree3")
let agreeFlag = false;

termsAgreeAll.onclick = function(){
	if(!agreeFlag){
		termsAgree1.checked=true
		termsAgree2.checked=true
		termsAgree3.checked=true		
		agreeFlag = true;
		
	}
	else if(agreeFlag) {
		termsAgree1.checked=false
		termsAgree2.checked=false
		termsAgree3.checked=false
		agreeFlag = false;
	}
}

function check() {
	if(termsAgree1.checkd == false || termsAgree2.checked == false || termsAgree3.checked == false)
		alert("필수 약관에 동의 한 뒤 서비스 이용이 가능합니다.")
	else
		location.href='singup'
}
