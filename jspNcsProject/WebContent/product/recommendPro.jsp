<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="org.apache.catalina.ha.backend.Sender"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<%
	System.out.println("PRO페이지 호출");
	ProductDAO dao = ProductDAO.getInstance();
	dao.updateRecommend(request.getParameter("num"));
	response.sendRedirect(request.getParameter("history"));
%>
</body>
</html>