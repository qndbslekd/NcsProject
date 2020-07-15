<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
MemberDAO dao = MemberDAO.getInstance();
boolean result = dao.confirmId(id);
%>
<body>
	<%if(result){%>
		<table>
			<tr>
				<td><%=id %>이미 사용중인 아이디입니다.</td>
			</tr>
		</table>
		<form action="cofirmId.jsp">
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
	<script type="text/javascript">
		function setId(){
			opener.document.inputForm.id.value = "<%=id%>";
			self.close();
		}
	</script>
</body>
</html>