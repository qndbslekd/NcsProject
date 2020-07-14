<%@page import="jspNcsProject.dao.DAOtest"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe Content</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String writer = request.getParameter("writer");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
	
	DAOtest daoTest = DAOtest.getInstance();
	daoTest.getRecipe(num);
%>
<body>
	<br />
	<h1 align="center">   content </h1>
</body>
</html>