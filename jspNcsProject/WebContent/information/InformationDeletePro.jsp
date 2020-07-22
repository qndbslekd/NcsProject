<%@page import="jspNcsProject.dao.InfomationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	String num = request.getParameter("num");
	InfomationDAO dao = InfomationDAO.getInstance();
	dao.deleteInfo(num);
	response.sendRedirect("informationList.jsp");
%>
<body>
</body>
</html>