<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
	if(!window.opener){ 
		window.location = '../main.jsp';
	}else{
		var nowUrl = opener.location.href; 
		console.log(nowUrl);
		console.log(!nowUrl == 'http://localhost:8080/jnp/member/memberModifyForm.jsp');
		if(!((nowUrl == 'http://localhost:8080/jnp/member/memberModifyForm.jsp')
				||(nowUrl =='http://localhost:8080/jnp/member/signupForm.jsp'))){
			window.location = '../main.jsp';
		}
	}
</script>
<% 
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String name = request.getParameter("name");	
	System.out.println("id"+id);
	System.out.println("name"+name);
	MemberDAO dao = MemberDAO.getInstance();
	boolean result = false;
	if(id!=null){
		result = dao.confirmId(id);
	}else if(name!=null){
		result = dao.confirmName(name);
	}
%>

<body>
	<%if(id!=null){%>
		<%if(result){%>
			<table>
				<tr>
					<td><%=id %>이미 사용중인 아이디입니다.</td>
				</tr>
			</table>
			<form action="confirmId.jsp">
				<table>
				<tr>
					<td>
						다른아이디를 사용하세요<br>
						<input type="text" name="id"/>
						<input type="submit" value="아이디 중복확인"/>
					</td>
				</tr>
			</table>
			</form>
		<%}else{%>
			<table>
				<tr>
					<td>
						<%=id %>는 사용하실수 있는 아이디입니다.
						<input type="button" value="닫기" onclick="setId()"/> 
					</td>
				</tr>
			</table>
		<%} %>
	<%}else if(name!=null){%>
		<%if(result){%>
			<table>
				<tr>
					<td><%=name %>이미 사용중인 활동명입니다.</td>
				</tr>
			</table>
			<form action="confirmId.jsp">
				<table>
				<tr>
					<td>
						다른활동명를 사용하세요<br>
						<input type="text" name="name"/>
						<input type="submit" value="활동명 중복확인"/>
					</td>
				</tr>
			</table>
			</form>
		<%}else{%>
			<table>
				<tr>
					<td>
						<%=name %>는 사용하실수 있는 활동명입니다.
						<input type="button" value="닫기" onclick="setName()"/> 
					</td>
				</tr>
			</table>
		<%} %>
	<%}%>
</body>
<script type="text/javascript">
	function setId(){
		opener.document.inputForm.id.value = "<%=id%>";
		self.close();
	}
	function setName(){
		opener.document.inputForm.name.value = "<%=name%>";
		self.close();
	}
</script>
</html>