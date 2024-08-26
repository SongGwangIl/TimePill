<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- header -->
<p><br><jsp:include page="/WEB-INF/views/common/header.jsp"/></p><br><hr>

1. 상대 역할의 등록된 사람들을 검색할 수 있는 기능 (search select) (이름, 아이디로만)

2. 검색된 사람에게 관리 신청을 보낼 수 있음 (update,insert) (쌍방 모두 보낼 수 있음)
2-1. 사용자는 신청을 보낸 후에는 다른 관리자에게는 신청을 보낼 수 없음 
사용자 n : 1 보호자 

사용자가 보호자에게 신청을 보내면 사용자 테이블의 보호자 아이디 컬럼에 insert하기 
보호자가 사용자에게 신청을 보내면 사용자 테이블의 보호자 아이디 컬럼에 역시나 insert하기

어느쪽이든 거절을 하면 사용자 테이블의 보호자 아이디를 delete하기 

신청도중은 상태 컬럼을 하나 만들어서 T,F표기
양쪽에서 승낙을 하면 해당 상태 컬럼을 T로 전환
보호자 아이디 컬럼이 채워져 있고 상태 컬럼이 T인 경우에만 정보 연동이 가능 

3. 신청을 받은 사람은 신청을 수락하거나 거절할 수 있음
3-1. 신청을 수락받은 사람은 서로의 정보에 조회가 가능
보호자 아이디 컬럼에 아이디가 있고, 상태 컬럼이 T인 경우에만 조회가 가능 

<!-- 검색 -->
<div>
	<form>
	<div>
		분류 : <select name="searchKey">
				<option value="0">선택</option>
				<option value="1" ${recordVO.searchKey == 1 ? 'selected' : ''}>사용자</option>
				<option value="2" ${recordVO.searchKey == 2 ? 'selected' : ''}>보호자</option>
			</select>
	</div>
	<div>
		검색 내용: <input type="text" name="searchValue" value="${recordVO.searchValue}">
	</div>
	<div>
		<button>검색</button>
	</div>
	</form>
</div>


<!-- footer -->
<hr><p><br><jsp:include page="/WEB-INF/views/common/footer.jsp"/></p><br>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/record/nowtime.js"></script>
</body>
</html>