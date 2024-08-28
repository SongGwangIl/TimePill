<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<p>사용자 검색</p>

<form action="${pageContext.request.contextPath}/member/search" method="post">
	<div>
		시리얼 코드 입력  <input type="text" name="searchValue" value="${searchValue}">
	</div>
	<div>
		<button>검색</button>
	</div>
</form>


<div>
	<p>사용자 정보 검색 결과 </p>
	<table>
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${userInfoVO.userId}</td>
				<td>${userInfoVO.userName}</td>
			</tr>
		</tbody>
	</table>
</div>


<form action="${pageContext.request.contextPath}/member/regist" method="post">
	<input type="hidden" name="userId" value="${userInfoVO.userId}">
	<button>관계 신청하기</button>
</form>

	
	