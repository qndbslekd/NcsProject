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
	int num = Integer.parseInt(request.getParameter("num"));
	String mode = request.getParameter("mode");
	String category = request.getParameter("category");
	String sel =request.getParameter("sel");
	String search= request.getParameter("search");
	String pageNum =request.getParameter("pageNum");
	String ch = request.getParameter("ch");
	
	FreeBoardDAO dao = FreeBoardDAO.getInstance();	
	dao.fixArticle(num,ch);
	
	String url = "boardContent.jsp?num="+num+"&mode="+mode+"&category="+category+"&sel="+sel+"&search="+search+"&pageNum="+pageNum;
	response.sendRedirect(url);

%>
<body>

</body>
</html>