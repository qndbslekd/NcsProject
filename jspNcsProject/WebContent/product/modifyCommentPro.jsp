<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
	String name = request.getParameter("name");
	String backNum = request.getParameter("backNum");
	String modifycomment = request.getParameter("modifycomment");
	
	ProductDAO dao = ProductDAO.getInstance();
	dao.modifycomment(num, modifycomment);%>
	
	<script>
		opener.location.reload();
		window.close();
	</script>
<body>

</body>
</html>