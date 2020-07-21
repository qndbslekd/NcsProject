<%@page import="jspNcsProject.dao.InfomationDAO"%>
<%@page import="jspNcsProject.dto.InfomationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="../header.jsp"></jsp:include>
<%

	InfomationDAO dao = InfomationDAO.getInstance();
	List<InfomationDTO> information = dao.getInfomation();
	
	String id = (String)session.getAttribute("memId");
	if(id == null){
		id = "";	
	}
	
	Cookie[] cookies = request.getCookies();
	System.out.println("cookies"+cookies.length);
%>
<body>
<h1 align="center">채식정보 페이지</h1>
		<hr/>
		<table>
		<%if(id.equals("admin")){ %>
			<tr>
				<td>
				
					<button onclick="window.location = 'InformationModifyForm.jsp'" >수정페이지로 이동</button>
					<button onclick="window.open('http://localhost:8080/jnp/member/confirmId.jsp', '_blank');" >수정페이지로 이동</button>
				</td>
			</tr>
		<% }%>
		<%for(int i=0;i<information.size();i++){%> 
			<tr>
					<th style=" font-size: 100%;"><%=information.get(i).getSubject() %></th>
			</tr>
			<tbody>
				<tr>
					<td style="text-align: left;"><%=information.get(i).getContent()%></td>
				</tr>
			</tbody> 
		<%} %>
		</table>
	</body>
</html>