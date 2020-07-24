<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<%
	String id = (String)session.getAttribute("memId");
	if(id==null){
%>
<body>
<jsp:include page="../header.jsp" flush="false" />
	<br/>
	<h1 align="center"> 로그인 </h1>
	<form action="../loginPro.jsp" method="post" name="login">
		<table>
			<input type="hidden" value="default" name="history" />
			<tr>
				<td>아이디</td>
				<td><input type="text" name="id"/></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pw"/></td>
			</tr> 
			<tr>
				<td colspan="3" style="padding-top: 20px;">
					<input type="checkbox" name="auto" value="1"/>자동로그인
					<button class="grayButton" type="submit"  style="width: 80px; height: 30px; text-align: center">로그인</button>
					<button class="grayButton" type="button" onclick="window.location='signupForm.jsp'" style="width: 80px; height: 30px; text-align: center">회원가입</button>
				</td>
			</tr>
		</table>
	</form>
</body>	
<!--로그인시 이전주소 값으로 가기-->
<script type="text/javascript">
	var form = document.login;
	var back = document.referrer; 
	form.history.value = back;
</script>
<%}else{ 
	response.sendRedirect("../main.jsp");	
}%>
</html>