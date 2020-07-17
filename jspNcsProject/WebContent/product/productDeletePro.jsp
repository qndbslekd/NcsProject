<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="jspNcsProject.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	String num =  request.getParameter("num");
	ProductDAO dao = ProductDAO.getInstance();
	int result =  dao.deleteProduct(num);
	System.out.println(result+"개의 제품이 삭제되었습니다");
	response.sendRedirect("productList.jsp");
%>
<body>
</body>
</html>