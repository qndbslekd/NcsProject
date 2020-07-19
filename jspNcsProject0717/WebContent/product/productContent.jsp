<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="../header.jsp"></jsp:include>
<%
	String id = (String)session.getAttribute("memId");
	if(id == null){
		id = "";	
	}
%>
<body>
		<table>
		<%if(id.equals("admin")){ %>
			<tr>
				<td colspan="2">
					<button onclick="window.location = 'productModifyForm.jsp'" >수정페이지로 이동</button>
					<button onclick="window.location = 'productDeleteForm.jsp'" >삭제페이지로 이동</button>
				</td>
			</tr>
		<% }%>
			<tr>
				<td rowspan="2">
					img
				</td>			
				<td>
					name
				</td>
			</tr>
			<tr>
				<td>
					ingredi
				</td>
			<tr>
			<tr>
				<td colspan="2">
					개요
				</td>
			<tr>
			<tr>
				<td colspan="2">
					xxxxxxxxxxxxxxxxxxxxxxxxx
				</td>
			<tr>
		</table>
	</body>
</html>