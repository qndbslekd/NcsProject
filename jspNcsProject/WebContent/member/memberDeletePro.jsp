<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<%
	if(session.getAttribute("memId") == null||request.getParameter("pw")==null){%>
		<%if(session.getAttribute("memId") == null){%>
			<script>
				alert("로그인 후 이용하세요");
				window.location="loginForm.jsp";
			</script>
		<%}%>
		<%if(request.getParameter("pw")==null){%>
			<script>
				alert("올바른 접근이 아닙니다");
				window.location="loginForm.jsp";
			</script>
		<%} %>
	<%}else{
		
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("memId");
		System.out.println(id);
		String pw = request.getParameter("pw");
		
		MemberDAO dao = MemberDAO.getInstance();
		boolean res = false;
		int res_= dao.loginCheck(id, pw);
		if(res_==1)res = true;
		if(res){
			dao.deleteMember(id);
			session.invalidate();
			Cookie[] coo = request.getCookies();
			if(coo != null){
				for(Cookie c : coo){
					if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("autoCh")){
						c.setMaxAge(0);
						response.addCookie(c);
					}
				}
			}%>
<body>
	<table>
		<tr>
			<td> 회원 정보가 삭제 되었습니다. </td>
		</tr>
		<tr>
			<td><button onclick="window.location='main.jsp'"> 메인으로 </button></td>
		</tr>
	</table>
		<%}else{%>
		<script>
		alert("비밀번호를 잘못 기입하셨습니다.")
		history.go(-1);
	</script>
</body>
		<%} 
	}%>
</html>