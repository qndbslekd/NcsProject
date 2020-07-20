<%@page import="jspNcsProject.dao.MemberDAO"%>
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
	request.setCharacterEncoding("utf-8");
	String offenceUrl = request.getParameter("offenceUrl");
	String member = request.getParameter("member");
	//offenceUrl
	//recipe : R
	//recipe comment : RC
	//recipe content comment : RCC
	//product comment : PC
	//freeboard : F
	
	
	MemberDAO dao = MemberDAO.getInstance();
	dao.updateOffenceColumn(offenceUrl, member);
	
	
	%>
	<script>
		alert("신고 되었습니다.");
		history.go(-1);
	</script>
	<% 
%>
	

</body>
</html>