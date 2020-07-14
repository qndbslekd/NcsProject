<%@page import="jspNcsProject.dao.MemberDAO"%>
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
	
	MemberDAO dao = MemberDAO.getInstance();
	boolean res = dao.loginCheck(id, pw);
	
	if(res){
		session.setAttribute("memId", id);
		session.setAttribute("memPw", pw);
		
		
		if(auto != null){
			Cookie c1 = new Cookie("autoId", id);
			Cookie c2 = new Cookie("autoPw", pw);
			Cookie c3 = new Cookie("autoCh", auto);
			c1.setMaxAge(60*60*24);
			c2.setMaxAge(60*60*24);
			c3.setMaxAge(60*60*24);
			response.addCookie(c1);
			response.addCookie(c2);
			response.addCookie(c3);
		}
		response.sendRedirect("main.jsp");
	}else{
		
	}
	
%>
<body>

</body>
</html>