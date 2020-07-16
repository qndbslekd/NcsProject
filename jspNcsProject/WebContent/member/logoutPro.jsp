<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
request.setCharacterEncoding("UTF-8");
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo){
			if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("autoCh")||c.getName().equals("autoName")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
	}
	session.invalidate();
	response.sendRedirect("main.jsp");

%>
<body>
</body>
</html>