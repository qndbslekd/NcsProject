<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<%
	if(session.getAttribute("memId") == null){%>
		<script>
			alert("로그인 후 이용하세요");
			window.location="loginForm.jsp";
		</script>
	<%}
%>
<body>
<<<<<<< HEAD
<h1 align="center"> 마이 페이지 </h1> 
=======
<h1 align="center"> 마이 페이지 </h1>
<form>
>>>>>>> branch 'develop' of https://github.com/ysk0951/codinnnnng.git
	<table>
		<tr>
			<td>
				<a onclick="window.location='memberModifyForm.jsp'"><img src="../resource/modify.png"><br/>정보 수정</a>
			</td>
			<td>
				<a onclick="window.location='memberDeleteForm.jsp'"><img src="../resource/delete.png"><br/>회원 탈퇴</a>
			</td>
		</tr>
		<tr>
			<td>
				<a onclick="window.location='memberModifyForm.jsp'"><img src="../resource/modify.png"><br/>정보 수정</a>
			</td>
			<td>
				<a onclick="window.location='memberDeleteForm.jsp'"><img src="../resource/delete.png"><br/>회원 탈퇴</a>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button onclick="window.location='main.jsp'">메인으로</button>
				<button onclick="window.location='logoutPro.jsp'">로그아웃</button>
			</td>
		</tr>
	</table>
</body>
</html>