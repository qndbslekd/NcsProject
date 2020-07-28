<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String num = request.getParameter("num");
	String name = request.getParameter("name");
	String backNum = request.getParameter("backNum");
	
	
%>
<body>
	<form action="modifyCommentPro.jsp">
		<input type="text" name="modifycomment"/>
		<input type="hidden" name="num" value="<%=num%>"/>
		<input type="hidden" name="name" value="<%=name%>"/>
		<input type="hidden" name="backNum" value="<%=backNum%>"/>
		<input type="submit" value="수정"/>
		<input type="button" value="취소" onclick="window.close()"/>
		
	</form>
</body>
</html>