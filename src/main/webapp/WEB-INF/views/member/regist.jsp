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
 
2. 보호자는 검색된 사용자에게 관리 신청을 보낼 수 있음 (update,insert) <br>
사용자 n : 1 보호자 <br><br>

보호자가 사용자에게 신청을 보내면 사용자 테이블의 보호자 아이디 컬럼에 insert하기<br><br>

사용자 쪽에서 거절을 하면 사용자 테이블의 보호자 아이디를 delete하기 <br><br>

신청도중은 상태 컬럼을 하나 만들어서 T, F표기<br>
사용자 쪽에서 승낙을 해야만 해당 상태 컬럼을 T로 전환<br>
보호자 아이디 컬럼이 채워져 있고 상태 컬럼이 T인 경우에만 정보 연동이 가능 <br><br>

3. 신청을 받은 사람은 신청을 수락하거나 거절할 수 있음<br>
3-1. 신청을 수락받은 사람은 서로의 정보에 조회가 가능<br>
보호자 아이디 컬럼에 아이디가 있고, 상태 컬럼이 T인 경우에만 조회가 가능 <br><br>
</div>


<!-- 검색 -->
<div>
	<form action="${pageContext.request.contextPath}/member/regist" method="post">
	
	<!-- 로그인한 유저의 사용자 타입에 따라서 
		검색분류를 자동으로 출력예정 (사용자면 보호자 검색, 보호자면 사용자 검색) -->
	<!-- 사용자 타입에 대한 정보 조회가 필요함 -->
	<div>
		<h3> 사용자의 유저 타입 : ${userSelect} </h3>
		<h3> 분류 : 
			<c:if test='${userSelect eq "user"}'>
				보호자 검색
				<input type="hidden" name="type" value="user">
			</c:if>
			<c:if test='${userSelect eq "protector"}'>
				사용자 검색
				<input type="hidden" name="type" value="protector">
			</c:if>
		</h3>
	</div>
	
	<div>
		검색 분류 : <select name="searchKey">
						<option value="0"> 선택 </option>
						<option value="1"> 이름 </option>
						<option value="2"> 아이디 </option>
					</select>
		검색 내용: <input type="text" name="searchValue" value="${recordVO.searchValue}">
	</div>
	
	<div>
		<button>검색</button>
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
			<c:forEach var="tvo" items="${recordSelectByDate}">
				<tr>
					<td> ${tvo.takeDate} </td>
					<td> ${tvo.takeSuccess} </td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>


<!-- footer -->
<hr><p><br><jsp:include page="/WEB-INF/views/common/footer.jsp"/></p><br>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/record/nowtime.js"></script>
</body>
</html>