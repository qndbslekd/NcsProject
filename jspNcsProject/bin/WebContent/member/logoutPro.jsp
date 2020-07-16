<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
request.setCharacterEncoding("UTF-8");
//쿠키삭제
	Cookie[] coo = request.getCookies();
	if(coo != null){	// 체크하고 지워야됨 쿠키가 있으면 지워라. 반복문을 바로 돌리면 nullPointerException 뜰 수도 있음
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