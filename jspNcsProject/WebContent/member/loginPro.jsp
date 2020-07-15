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
	MemberDAO dao = MemberDAO.getInstance();
	boolean res = dao.loginCheck(id, pw);
	String name = dao.getMemberName(id, pw);
	
	Cookie [] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo){
			if(c.getName().equals("autoId")) id = c.getValue();
			if(c.getName().equals("autoPw")) pw = c.getValue();
			if(c.getName().equals("autoCh")) auto = c.getValue();
			if(c.getName().equals("autoName")) name = c.getValue();
		}
	}
	if(res){
		session.setAttribute("memId", id);
		session.setAttribute("memPw", pw);
		session.setAttribute("memName", name);
	/* 
		System.out.println(session.getAttribute("memId"));
		System.out.println(session.getAttribute("memPw"));
		System.out.println(session.getAttribute("memName"));
	*/
		if(auto != null){
			Cookie c1 = new Cookie("autoId", id);
			Cookie c2 = new Cookie("autoPw", pw);
			Cookie c3 = new Cookie("autoCh", auto);
			Cookie c4 = new Cookie("autoName", name);
			c1.setMaxAge(60*60*24);
			c2.setMaxAge(60*60*24);
			c3.setMaxAge(60*60*24);
			c4.setMaxAge(60*60*24);
			response.addCookie(c1);
			response.addCookie(c2);
			response.addCookie(c3);
			response.addCookie(c4);
		}
		response.sendRedirect("main.jsp");
	}else{%>
		<script>
			alert("비밀번호나 아이디가 틀렸습니다");
			history.go(-1);
		</script>
	<%}
%>
<body>

</body>
</html>