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
	String num  = request.getParameter("num");
	if(num==null){
		response.sendRedirect("informationList.jsp");
	}else{
		InfomationDAO dao = InfomationDAO.getInstance();
		InfomationDTO information = dao.getInfomation(num);
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
				<tr>
					<td><img src="img/<%=information.getImg()%>"/></td>
				</tr>
				<tr>
					<td style=" font-size: 100%;"><%=information.getSubject() %></td>
				</tr>
					<tr>
						<td><textarea readonly="readonly" rows="20" cols="100"><%=information.getContent()%></textarea></td>
					</tr>
				<%if(id.equals("admin")){ %>
					<tr>
						<td>
							<button onclick="window.location = 'InformationModifyForm.jsp?num=<%=num%>'" >수정페이지로 이동</button>
							<button onclick="window.location = 'InformationDeletePro.jsp?num=<%=num%>'" >삭제</button>
						</td>
					</tr>
				<%}%>
			</table>
		</body>
	<%} %>
</html>