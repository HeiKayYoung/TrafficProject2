<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table width="500" border="1">
	<tr>
		<td>번호</td>
		<td>${n_content.n_no }</td>
		<td>작성일</td>
		<td>${n_content.n_date }</td>
	</tr>	
	<tr>
		<td>제목</td>
		<td>${n_content.n_title }</td>
		<td>조회수</td>
		<td>${n_content.n_hit }</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>${n_content.n_content }</td>
	</tr>
</table>
<a href="notice">목록</a>
</body>
</html>