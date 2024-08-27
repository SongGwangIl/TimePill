<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- header -->
<p><br><jsp:include page="/WEB-INF/views/common/header.jsp"/></p><br><hr>



<div>
1. 보호자가 사용자를 검색할 수 있는 기능 <br>
- 검색 키워드는 기기 시리얼코드로만 가능하다 : 결과값은 항상 1개(정확한 일치) 혹은 0개(불일치) <br>
 
2. 보호자는 검색된 사용자에게 관리 신청을 보낼 수 있음 (update, 이미 있는 행에 내용추가) <br>
사용자 n : 1 보호자 <br><br>

보호자가 사용자에게 신청을 보내면 사용자 테이블의 보호자 아이디 컬럼에 update하기<br><br>
!!여기까진 구현완료!! 같은 vo의 같은 속성값 이름을 계속 사용해서 redirect할때나 등등..자꾸 파라미터 값이 유지되어서 돌아다님 <br><br>

사용자쪽에서 요청이 온 것을 select 할 수 있는 기능 추가<br>
사용자 쪽에서 거절을 하면 사용자 테이블의 보호자 아이디를 delete용으로 update하기 <br><br>
큰일났다 FK라서 null로 update하려면 데이터베이스가 거부한다....<br>
사용자가 아닌 안쓰는 user를 하나 만들어서 해당 조건일 때는 null값과 동일한 취급을 하면 될 것 같기도 하고... <br><br>

신청도중은 상태 컬럼을 하나 만들어서 T, F표기<br>
사용자 쪽에서 승낙을 해야만 해당 상태 컬럼을 T로 전환<br>
보호자 아이디 컬럼이 채워져 있고 상태 컬럼이 T인 경우에만 정보 연동이 가능 <br><br>

3. 신청을 받은 사람은 신청을 수락하거나 거절할 수 있음<br>
3-1. 신청을 수락받은 사람은 서로의 정보에 조회가 가능<br>
보호자 아이디 컬럼에 아이디가 있고, 상태 컬럼이 T인 경우에만 조회가 가능 <br><br>
</div>


<!-- 검색 -->
<div>
	<form action="${pageContext.request.contextPath}/member/search" method="post">	
		<div>
			유저 타입 : ${userSelect eq 'user' ? '사용자' : '보호자'} <br>
			분류 : 
				<c:if test='${userSelect eq "user"}'>
					나의 보호자 정보 조회, 보호자에게 초대코드 보내기
				</c:if>
				<c:if test='${userSelect eq "protector"}'>
					사용자 검색
					<div>
						검색 내용: <input type="text" name="searchValue" value="${searchValue}">
					</div>
					<div>
						<button>검색</button>
					</div>
				</c:if>			
		</div>
	</form>
</div>

	<div>
		<table>
			<thead>
				<tr>
					<th>
						아이디
					</th>
					<th>
						이름
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td> ${userInfoVO.userId} </td>
					<td> ${userInfoVO.userName} </td>
				</tr>
			</tbody>
		</table>
	</div>

	<form action="${pageContext.request.contextPath}/member/regist" method="post">
		<input type="hidden" name="userId" value="${userInfoVO.userId}">
		<button>관계 신청하기</button>
	</form>

<!-- footer -->
<hr><p><br><jsp:include page="/WEB-INF/views/common/footer.jsp"/></p><br>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/record/nowtime.js"></script>
</body>
</html>