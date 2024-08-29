<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h3> ${name} 님의 복약 상황을 확인해보세요! </h3>

<!-- 조회 날짜 선택 -->
<form action="${pageContext.request.contextPath}/record/list.do" method="get">
	<label for="takeDate"> 조회 날짜 선택 : </label>
	<input type="date" id="takeDate" name="takeDate" value="${takeDate}">
	<input type="submit" value="조회">
</form> <br>

<!-- 차트 조회 -->
<div style="width:600px; height:400px; margin : 0 auto">
	<canvas id="recordChart"></canvas>
</div>


<!-- 로그 조회 -->
 	<c:choose>
		<c:when test="${takeDate eq today || takeDate.isEmpty()}">
			<h1>오늘의 복용기록 </h1>
		</c:when>
		<c:otherwise>
			<h1>${takeDate}의 복용기록 </h1>
		</c:otherwise>
	</c:choose>
	
	<c:choose>
	<c:when test="${recordSelectByDate.isEmpty()}">
		<p> 조회할 복용 기록이 없습니다. </p>
	</c:when>
	<c:otherwise>
		<table>
			<thead>
				<tr>
					<th>
						복용한 약품이름
					</th>
					<th>
						복용한 시간 이름
					</th>
					<th>
						복용 날짜
					</th>
					<th>
						복용 성공 여부
					</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="tvo" items="${recordSelectByDate}">
				<tr>
					<c:forEach var="sdl" items="${tvo.scheduleList}"><td> ${sdl.scheTitle}</td></c:forEach>
					<c:forEach var="stl" items="${tvo.scheTimeList}"><td> ${stl.timeName}</td></c:forEach>
					<td> ${tvo.takeDate} </td>
					<td> ${tvo.takeSuccess} </td>
					<td> 
						<form action="${pageContext.request.contextPath}/record/off" method="post">
							<input type="hidden" name="takeId" value="${tvo.takeId}">
					    	<button type="submit">복용 Off</button>
						</form>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>


<h1> 전체 복용기록 조회 </h1>

<br>

<!-- 검색 -->
<div>
	<form>
	<input type="hidden" id="takeDate" name="takeDate" value="${takeDate}">
	<div>
		분류 : <select name="searchKey">
				<option value="0">선택</option>
				<option value="1" ${recordVO.searchKey == 1 ? 'selected' : ''}>약품명</option>
				<option value="2" ${recordVO.searchKey == 2 ? 'selected' : ''}>시간명</option>
				<option value="3" ${recordVO.searchKey == 3 ? 'selected' : ''}>성공여부</option>
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

<c:choose>
	<c:when test="${recordSelectByAll.isEmpty()}">
		<p> 조회할 복용 기록이 없습니다. </p>
	</c:when>
	<c:otherwise>
		<table>
			<thead>
				<tr>
					<th>
						복용한 약품이름
					</th>
					<th>
						복용한 시간 이름
					</th>
					<th>
						복용 날짜
					</th>
					<th>
						복용 성공 여부
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="avo" items="${recordSelectByAll}">
				<tr>
					<c:forEach var="sdl" items="${avo.scheduleList}"><td> ${sdl.scheTitle}</td></c:forEach>
					<c:forEach var="stl" items="${avo.scheTimeList}"><td> ${stl.timeName}</td></c:forEach>
					<td> ${avo.takeDate} </td>
					<td> ${avo.takeSuccess} </td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>

		<!-- 페이지네이션 인덱스 -->
		<c:url var="listUrl" value="/record/list.do">
			<c:param name="takeDate" value="${takeDate}"/>
			<c:param name="currentPage" value=""/>
		</c:url>
		
		<div>
		<ul>
			<li> <a href = "${listUrl}1${recordVO.query}">처음</a></li>
			<li> <a href = "${listUrl}${recordVO.prev}${recordVO.query}">이전</a></li>
			<c:forEach var="page" items="${recordVO.list}">
				<li> <a class="page-link" href ="${listUrl}${page}${recordVO.query}"> ${page} </a></li>
			</c:forEach>
			<li> <a href = "${listUrl}${recordVO.next}${recordVO.query}">다음</a></li>
			<li> <a href = "${listUrl}${recordVO.lastPage}${recordVO.query}">마지막</a></li>
		</ul>
		</div>





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script>
	//JSON객체선언
	var jsonData = ${JSON}
</script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/record/chart.js"></script>
