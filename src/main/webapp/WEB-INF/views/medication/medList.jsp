<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header --%>
<c:import url="/header" charEncoding="utf-8">
	<c:param name="title" value="TimePill - 스케줄 관리"/>
</c:import>

<style>
.content-wrapper {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 90%;
	margin: 20px auto;
}
.single-line {
	width: 90%;
	text-align: center;
	padding: 10px;
	margin: 10px;
}

.same-line {
	justify-content: center;
	display: flex;
	width: 100%;
}

.med-title .med-info {
	border: 1px solid #ccc;
	border-radius: 3px;
	display: none;
	position: absolute;
	background-color: #fff;
	z-index: 1000;
}

.med-title:hover .med-info {
	display: block;
}

p, span {
	margin: 5px;
}
</style>

<div class="whiteBox">
	<div class="content-wrapper">
		<h2>복약 리스트</h2>
		<div>
			<table>
				<tbody>
					<c:forEach var="resultMed" items="${medList}">
						<tr>
							<td>${resultMed.medName}</td>
							
							<td><fmt:formatDate value="${resultMed.startDate}" pattern="yyyy-MM-dd"/>
							~ <fmt:formatDate value="${resultMed.endDate}" pattern="yyyy-MM-dd"/></td>
							<td><img alt="수정" src="/resources/img/ico-edit.png" width="14px" height="14px" onclick="location.href='/medication/${resultMed.medId}'"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${empty medList}">
				<div class="tablewrap">
					<p>등록된 약이 없습니다.</p>
				</div>
			</c:if>
		</div>
		<div>
			<button onclick="location.href='/medication/reg'">
				복약 추가
			</button>
		</div>
	</div>
</div>


</div>
<%-- footer --%>
<c:import url="/WEB-INF/views/common/footer.jsp" charEncoding="utf-8"/>

