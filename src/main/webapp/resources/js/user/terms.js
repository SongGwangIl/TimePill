const btn1 = document.querySelector("#btn1")
const policyService = document.querySelector("#policyService")
let psFlag = false;
const btn2 = document.querySelector("#btn2")
const privacy = document.querySelector("#privacy")
let pFlag = false;

btn1.onclick = function(){
	if(!psFlag) {	
    	policyService.style.display = "block";
    	psFlag = true;
    }
    else {
    	policyService.style.display = "none";
    	psFlag = false;
    }
}

btn2.onclick = function(){
    if(!pFlag) {	
    	privacy.style.display = "block";
    	pFlag = true;
    }
    else {
    	privacy.style.display = "none";
    	pFlag = false;
    }
}

const terms_agree = document.querySelector("#terms_agree")
const terms_agree1 = document.querySelector("#terms_agree1")
const terms_agree2 = document.querySelector("#terms_agree2")
let agreeFlag = false;

terms_agree.onclick = function(){
	if(!agreeFlag){
		terms_agree1.checked=true
		terms_agree2.checked=true
		agreeFlag = true;
		
	}
	else if(agreeFlag) {
		terms_agree1.checked=false
		terms_agree2.checked=false
		agreeFlag = false;
	}
}

function check() {
	if(terms_agree1.checkd == false || terms_agree2.checked == false)
		alert("필수 약관에 동의 한 뒤 서비스 이용이 가능합니다.")
	else
		location.href='singup'
}
