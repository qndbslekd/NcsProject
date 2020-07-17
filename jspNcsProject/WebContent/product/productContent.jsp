<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="jspNcsProject.dto.ProductDTO"%>
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
	String num = request.getParameter("num");
	
	//if num DB 에 존재하지 않으면 Back
	ProductDAO dao = ProductDAO.getInstance();
	ProductDTO dto = dao.selectProduct(num); 
%>
<body>
		<table>
		<%if(id.equals("admin")){ %>
			<tr>
				<td colspan="2">
					<button onclick="window.location = 'productModifyForm.jsp?num=<%=dto.getNum() %>'" >수정페이지로 이동</button>
					<button onclick="window.location = 'productDeletePro.jsp?num=<%=dto.getNum() %>'" >삭제하기</button>
				</td>
			</tr>
		<% }%>
			<tr>
				<td rowspan="2">
					<%if(dto.getProduct_img()!=null){ %>
					<img src="/jnp/product/imgs/<%=dto.getProduct_img()%>">
					<%}else{ %>
					<img src="/jnp/product/imgs/unnamed.gif">
					<%} %>
				</td>			
				<td>
					<%=dto.getName() %>
				</td>
			</tr> 
			<tr>
				<td>
					<%=dto.getIngredients() %>
				</td>
			<tr>
			<tr>
				<td colspan="2">
					개요
				</td>
			<tr>
			<tr>
				<td colspan="2">
					<%=dto.getDetail()%>
				</td>
			<tr>
		</table>
	</body>
</html>