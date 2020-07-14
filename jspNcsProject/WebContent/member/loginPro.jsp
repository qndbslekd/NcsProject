<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");	
	
	Cookie [] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo){
			if(c.getName().equals("autoId")) id = c.getValue();
			if(c.getName().equals("autoPw")) pw = c.getValue();
			if(c.getName().equals("autoCh")) auto = c.getValue();
		}
	}
	
%>
<body>

</body>
</html>