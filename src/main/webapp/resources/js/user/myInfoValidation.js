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
}
  
const email = document.querySelector("#email")
const emailMsg = document.querySelector('#userPwdMsg')
let emailVal;
email.oninput = emailCheck 

function emailCheck(){
  const eamilRegExp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i
  emailVal = email.value
  if(!eamilRegExp.test(emailVal)) { // 정규식 조건 만족 X
    email.focus();    
  }
}

