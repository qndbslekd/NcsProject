<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String[] subject = request.getParameterValues("subject");
	String[] content = request.getParameterValues("content");
	
	System.out.println(subject.length);
	System.out.println(content.length);
	
	
	
%>
<body>

</body>
</html>