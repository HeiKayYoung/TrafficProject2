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
 			<div class="title">����� ����������</div>
 		<hr />	
	</div>
 	
 	<div id="list-box">
		<table>
			<tr>
				<td><a href="parking">����� ����������</a></td>
				<td><a href="electric_charge">����� ������ ������</a></td>
			</tr>
		</table>
	</div>
 	
	    <div style="color : gray; text-align: right;">
	        ��ü ������ : ${vo.totPage } / ���� ������ : ${vo.page } <br />
	        * �� �Խ����� ������� 10�� �̻��� �����常 ��ȸ�� ����Դϴ�.
	    </div>
	
 		<table>
	 		<tr>
				<td>����</td><!-- p_kind_name -->
				<td>�ּ�</td><!-- p_address -->
				<td width="auto;">�̸�</td><!-- p_name -->
				<td>�� �������</td><!-- p_paid_and_free_name -->
				<td>�⺻�ð� �� <br />���</td><!-- p_default_time_min / p_default_price -->
				<td>�߰��ð��� <br />���</td><!-- p_add_price_min / p_add_price -->
				<!-- <td>��ȭ��ȣ</td> -->
	 		</tr>
	 		
	 		<c:if test="${not empty seoul_parking }">
	 			<c:forEach items="${seoul_parking }" var="s">
			 		<input type="hidden" name="no" value="${s.p_code }" />
			 		<tr>
						<td>${s.p_kind_name }</td>
						<td>${s.p_address }</td>
						<td style="text-align: left;"><a href="parking_view?no=${s.p_code }">${s.p_name }</a></td>
						<td>${s.p_total_space }��</td>
						<td>
							<c:if test="${s.p_default_time_min eq '' }">''</c:if>
							<c:if test="${s.p_default_price eq '' }">''</c:if>
							${s.p_default_time_min}�� / ${s.p_default_price }��
						</td>
						<td>${s.p_add_price_min }�� / ${s.p_add_price }��</td>
						<%-- <td>${s.p_tel}</td> --%>
			 		</tr>
		 		</c:forEach>
	 		</c:if>
	 		
		 	<c:if test="${empty seoul_parking }">
		 		<tr>
		 			<td colspan="6" id="search_nothing">�˻� ����� �����ϴ�.</td>
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
						 		<option value="1" selected>�ּ�</option>
						 		<option value="2">����</option>
						 	</select>
			 			</c:when>
			 			<c:when test="${searchType eq 1}">
			 				<select name="searchType" id="searchType">
						 		<option value="1" selected>�ּ�</option>
						 		<option value="2">����</option>
						 	</select>
			 			</c:when>
			 			<c:otherwise>
			 				<select name="searchType" id="searchType">
						 		<option value="1">�ּ�</option>
						 		<option value="2" selected>����</option>
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
			 		
				 	<button type="submit" id="searchbtn">�˻�</button>
		 		</div>
	 	</form>
	 	
</body>
</html>
 