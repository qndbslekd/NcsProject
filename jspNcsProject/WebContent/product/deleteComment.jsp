<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String num = request.getParameter("num");
	String name = request.getParameter("name");
	String backNum = request.getParameter("backNum");
	
	ProductDAO dao = ProductDAO.getInstance();
	int result = dao.deleteComment(num, name);
	response.sendRedirect("productContent.jsp?num="+backNum);
	
%>
<body>

</body>
</html>