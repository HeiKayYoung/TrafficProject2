<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</head>
<body>
	
	<style>
	
		#content{
			height: auto;
			width: 1200px;
			margin-left: auto;
			margin-right: auto;
		}
		
		table {
			padding: 5px;
			width: 1200px;
			height: auto;
			font-size: 14px;
			border-bottom: 1px solid #f3f3f3;
			margin-top: 10px;
			text-align: center;
			margin-left: auto;
			margin-right: auto;
		}
		tr:first-child {
			height: auto;
			font-size: 20px;
			font-style: bold;
			background-color: #f5f5f5;
			border-top-color: black;
			color: #525252;
		}
		
		td {
			border-right: 1px solid black;
			border-bottom: 1px solid grey;
			padding-top: 15px;
			padding-bottom: 15px;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		
		td:last-child {
			border-right-style: none;
		}
		
		.title {
			margin-top: 5px;
			margin-bottom: 5px;
			font-size: 28px;
			text-align: center;
		}
		
		#paging {
			text-align: center;
			margin-bottom: 5px;
			font-size: 18px;
		}
		
		#search {
			text-align: center;
		}
		hr {
			margin: 0 0 0 0;
			width: 1200px;
		}
		#searchForm {
	        padding: 10px; 
	        border-radius: 5px; 
	    }
	
	    #searchType {
	        margin-right: 10px; 
	        padding: 5px;
	    }
	
	    #keyword {
	        padding: 5px; 
	    }
	
	    #searchbtn {
	        background-color: #f5f5f5;
   	        color: #525252;
	        border: 1px solid grey; 
	        padding: 5px 10px; 
	        border-radius: 5px; 
	    }
	    a {
	    	text-decoration: none;
	    }
	    a:hover {
	    	text-decoration: underline;
	    }
	    #list-box table {
	    	margin-top: 10px;
	    	margin-bottom: 10px;
	    	width: 1200px;
	    	height: 20px;
	    }
	    #list-box table td {
	    	border: 1px solid grey;
	    }
	    #list-box table td a{
	    	text-decoration: none;
	    	cursor: pointer;
	    }
	    #list-box table td a:hover{
	    	text-decoration: underline;
	    }
	    #search_nothing {
	    	font-size: 20px;
	    	text-align: center;
	    }
	</style>
	
	<script>
		document.getElementById("searchForm").addEventListener("submit", function(event) {
		    event.preventDefault();
	
		    var searchType = document.getElementById("searchType").value;
		    var keyword = document.getElementById("keyword").value;
	
		    sendToService(searchType, keyword);
		});
	</script>

	<div style="text-align: center;">
		<hr />
 			<div class="title">서울시 공영주차장</div>
 		<hr />	
	</div>
 	
 	<div id="list-box">
		<table>
			<tr>
				<td><a href="http://localhost:8090/traffic/user/parking">서울시 공영주차장</a></td>
				<td><a href="http://localhost:8090/traffic/user/electric_charge">서울시 전기차 충전소</a></td>
			</tr>
		</table>
	</div>
 	
 	<div style="display: flex; justify-content: space-between; ">
	    <div>
	        <!-- <a href="#">주차대수 많은 순</a> | <a href="#">기본시간 많은 순</a> -->
	        <button id="sortByParking">주차대수 많은 순</button> | <button id="sortByDefaultTime">기본시간 많은 순</button>
	    </div>
	    <div style="color : gray; text-align: right;">
	        전체 페이지 : ${vo.totPage } / 현재 페이지 : ${vo.page } <br />
	        * 본 게시판은 주차대수 10대 이상의 주차장만 조회한 결과입니다.
	    </div>
	</div>

	<div id="result"></div>
	
	<script>
	    $(document).ready(function () {
	        // 주차대수 많은 순으로 정렬하는 버튼 클릭 이벤트
	        $("#sortByParking").click(function () {
	            sortBy("p_total_space");
	        });
	
	        // 기본시간 많은 순으로 정렬하는 버튼 클릭 이벤트
	        $("#sortByDefaultTime").click(function () {
	            sortBy("p_default_time_min");
	        });
	
	        // 정렬 기준에 따라 서버에 요청을 보내고 결과를 출력하는 함수
	        function sortBy(sortKey) {
	            $.ajax({
	                type: "GET",
	                url: "http://localhost:8090/TrafficProject/user/parking",
	                data: {
	                    param1: 1,
	                    param2: 10,
	                    sortBy: sortKey  // 변수를 사용하여 동적으로 값을 전달
	                },
	                success: function (data) {
	                    // 서버에서 받은 데이터를 출력하거나 처리하는 부분
	                    $("#result").html(data);
	                },
	                error: function (error) {
	                    console.log("Error:", error);
	                }
	            });
	        }
	    });
	</script>

	
 		<table>
	 		<tr>
				<td>종류</td><!-- p_kind_name -->
				<td>주소</td><!-- p_address -->
				<td width="auto;">이름</td><!-- p_name -->
				<td>총 주차대수</td><!-- p_paid_and_free_name -->
				<td>기본시간 및 <br />요금</td><!-- p_default_time_min / p_default_price -->
				<td>추가시간당 <br />요금</td><!-- p_add_price_min / p_add_price -->
				<!-- <td>전화번호</td> -->
	 		</tr>
	 		
	 		<c:if test="${not empty seoul_parking }">
	 			<c:forEach items="${seoul_parking }" var="s">
			 		<input type="hidden" name="no" value="${s.p_code }" />
			 		<tr>
						<td>${s.p_kind_name }</td>
						<td>${s.p_address }</td>
						<td style="text-align: left;"><a href="parking_view?no=${s.p_code }">${s.p_name }</a></td>
						<td>${s.p_total_space }대</td>
						<td>
							<c:if test="${s.p_default_time_min eq '' }">''</c:if>
							<c:if test="${s.p_default_price eq '' }">''</c:if>
							${s.p_default_time_min}분 / ${s.p_default_price }원
						</td>
						<td>${s.p_add_price_min }분 / ${s.p_add_price }원</td>
						<%-- <td>${s.p_tel}</td> --%>
			 		</tr>
		 		</c:forEach>
	 		</c:if>
	 		
		 	<c:if test="${empty seoul_parking }">
		 		<tr>
		 			<td colspan="6" id="search_nothing">검색 결과가 없습니다.</td>
		 		</tr>
		 	</c:if>
	 	</table>
	 	
	 	<div id="paging">
       		<c:if test="${vo.page>1}">
				<a href="parking?page=1&searchType=${searchType }&keyword=${keyword}"><i class="fa-solid fa-angles-left"></i></a>
				<a href="parking?page=${vo.page-1 }&searchType=${searchType }&keyword=${keyword}"><i class="fa-solid fa-circle-chevron-left"></i></a>
			</c:if>
				
			<c:forEach begin="${vo.pageStart}" end="${vo.pageEnd }" var="i">
				<c:choose>
					<c:when test="${i ne param.page}">
						<a href="parking?page=${i}&searchType=${searchType }&keyword=${keyword}">${i}</a>
					</c:when>
					<c:otherwise>
						<span>${i}</span>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${vo.page < vo.totPage }">
				<a href="parking?page=${vo.page+1 }&searchType=${searchType }&keyword=${keyword}"><i class="fa-solid fa-circle-chevron-right"></i></a>
				<a href="parking?page=${vo.totPage }&searchType=${searchType }&keyword=${keyword}"><i class="fa-solid fa-angles-right"></i></a>
			</c:if>
       	</div>
	 	
	 	<form action="parking" id="searchForm">
	 		<input type="hidden" name="page" value="1" />
		 		<div id="search">
			 		<c:choose>
			 			<c:when test="${empty searchType }">
			 				<select name="searchType" id="searchType">
						 		<option value="1" selected>주소</option>
						 		<option value="2">종류</option>
						 	</select>
			 			</c:when>
			 			<c:when test="${searchType eq 1}">
			 				<select name="searchType" id="searchType">
						 		<option value="1" selected>주소</option>
						 		<option value="2">종류</option>
						 	</select>
			 			</c:when>
			 			<c:otherwise>
			 				<select name="searchType" id="searchType">
						 		<option value="1">주소</option>
						 		<option value="2" selected>종류</option>
						 	</select>
			 			</c:otherwise>
			 		</c:choose>
			 		
			 		<c:choose>
			 			<c:when test="${keyword ne ''}">
			 				<input type="text" name="keyword" id="keyword" value="${keyword }" autocomplete=off;/>
			 			</c:when>
			 			<c:otherwise>
			 				<input type="text" name="keyword" id="keyword"/>
			 			</c:otherwise>
			 		</c:choose>
			 		
				 	<button type="submit" id="searchbtn">검색</button>
		 		</div>
	 	</form>
	 	
</body>
</html>
 