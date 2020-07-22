<%@page import="jspNcsProject.dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int num = Integer.parseInt(request.getParameter("num"));

	FreeBoardDAO dao = FreeBoardDAO.getInstance();
	dao.deleteArticle(num);
	
	response.sendRedirect("board.jsp");


%>

</body>
</html>