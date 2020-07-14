<%@page import="jspNcsProject.dao.DAOtest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<!--CSS-->
<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
<body>
<%
	DAOtest test = DAOtest.getInstance();
	test.getTest();

%>
</body>
</html>