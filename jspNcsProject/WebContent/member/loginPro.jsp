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
	//TEST AUTOLOGIN
	System.out.println("AUTO VAL :"+request.getParameter("auto"));
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto ="n";
	if(request.getParameter("auto")!=null){
		auto = "y";
	}
	MemberDAO dao = MemberDAO.getInstance();
	int res = dao.loginCheck(id, pw);
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
	
	if(res == 1){
		session.setAttribute("memId", id);
		session.setAttribute("memPw", pw);
		session.setAttribute("memName", name);
		if(auto.equals("y")){
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
	}else if(res == 0){%>
		<script>
			alert("아이디와 비밀번호를 다시 확인해주세요");
			history.go(-1);
		</script>
	<%}else if(res==-1){%>
		<script>
			alert("강퇴당한 회원입니다");
			history.go(-1);
		</script>
	<% }%>
<body>

</body>
</html>