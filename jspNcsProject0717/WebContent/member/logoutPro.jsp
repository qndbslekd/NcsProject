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
	

	session.invalidate();	// 세션삭제
	response.sendRedirect("main.jsp");	//로그아웃 처리후 메인으로 이동
%>
<body>
</body>
</html>