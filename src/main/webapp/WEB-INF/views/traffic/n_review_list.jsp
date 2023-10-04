<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script>
	function searchExecute(){
		var keyword = document.getElementById("keyword").value;
        
        // 검색 결과 조회
        location.replace("n_review?page=1&keyword="+ keyword);
	}
</script>

<form action="n_review_list">
    	<input type="hidden" name="page" value="1" />
    	
    	<div>
    		<br />
    		<span>
    			<c:if test="${empty keyword || keyword eq ''}">
            		<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" autocomplete="off">
            	</c:if>
                <c:if test="${not empty keyword}">
            		<input type="text" id="keyword" name="keyword" value="${keyword}" autocomplete="off">
            	</c:if>
    		</span>
    		<span>
    			<input type="submit" class="button" value="검색" onclick="searchExecute();">
    		</span>
    	</div>
    	<br><br>
		<div>
			<table width="500" border="1">
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성일</td>
					<td>조회수</td>
				<tr>
				
				<tbody id="searchData">
				<c:forEach items="${dto }" var="n_review">
					<tr>
						<td>${n_review.n_no }</td>
						<td><a href="n_review_content?n_no=${n_review.n_no }">${n_review.n_title }</a></td>
						<td>${n_review.n_date }</td>
						<td>${n_review.n_hit }</td>
					</tr>
				</c:forEach>
				</tbody>			
			</table>
		</div>
		<div>
        	<br />
        	<div id="paging">
        		<c:if test="${vo.page>1}">
					<a href="n_review?page=1&keyword=${param.keyword}"><i class="fa-solid fa-angles-left"></i></a>
					<a href="n_review?page=${vo.page-1 }&keyword=${param.keyword}"><i class="fa-solid fa-circle-chevron-left"></i></a>
				</c:if>
	        	<c:forEach begin="${vo.pageStart}" end="${vo.pageEnd }" var="i">
	        	
	        		<c:choose>
	        			<c:when test="${ i ne param.page }">
	        				<a href="n_review?page=${i}&keyword=${keyword}">${i}</a>
	        			</c:when>
	        			<c:otherwise>
	        				<span>${i}</span>
	        			</c:otherwise>
	        		</c:choose>
	        		
	        	</c:forEach>
	        	<c:if test="${vo.page < vo.totPage}">
					<a href="n_review?page=${vo.page+1 }&keyword=${param.keyword}"><i class="fa-solid fa-circle-chevron-right"></i></a>
					<a href="n_review?page=${vo.totPage }&keyword=${param.keyword}"><i class="fa-solid fa-angles-right"></i></a>
				</c:if>
        	</div>
		</div>
		<a href="n_review_write_view">후기작성</a> <br>
		<a href="n_review_list">후기목록</a>
</form>
</body>
</html>