<%@page import="jspNcsProject.dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8"); 

	int num = Integer.parseInt(request.getParameter("num"));
	
	FreeBoardDAO dao = FreeBoardDAO.getInstance();	
	
	
	dao.updateRecommend(num);

	String url = "boardContent.jsp?num="+num;
	response.sendRedirect(url);
%>

<body>
</body>
</html>