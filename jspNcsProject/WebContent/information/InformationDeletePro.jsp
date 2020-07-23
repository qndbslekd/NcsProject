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
	if( num==null||session.getAttribute("memId")==null||!session.getAttribute("memId").equals("admin") ){%>
		<script>
			alert("올바른 접근이 아닙니다.");
			history.go(-1);
		</script>
	<%}else{ 

	InfomationDAO dao = InfomationDAO.getInstance();
	dao.deleteInfo(num);
	response.sendRedirect("informationList.jsp");
	}%>
<body>
</body>
</html>