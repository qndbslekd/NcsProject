<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	Enumeration names =  request.getParameterNames();
	
	System.out.println("==MemberModifyProPrameters==");
	while(names.hasMoreElements()){
		System.out.println(names.nextElement().toString());
	}
%>
<body>
</body>
</html>