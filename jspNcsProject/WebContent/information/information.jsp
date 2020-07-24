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
<style>
table td {
	font-size:1.4em;
	vertical-align:middle;
}
td * {
	margin:0;
	padding:0;
	vertical-align:middle;
	text-align:left;
}
.t {
	text-align:right;
	padding:20px;
	border-right:2px solid #ccc;
	font-size:1.4em;
}
input {
	border:1px solid #ccc;
	border-radius:5px;
	font-size:1.4em;
	self-align:left;
	margin-left:20px;
	vertical-align:middle;
	
}
</style>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="information" name="mode"/>
	</jsp:include>
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
					<td class="t">제목</td>
					<td><%=information.getSubject() %></td>
				</tr>
				<tr> 
					<td class="t">사진</td>
					<td > 
					<%if(information.getImg()==null||information.getImg().equals("null")){%> 
						<img src="img/unnamed.gif" width="454px;" height="353px;" />
					<%}else{ %>
						<img src="img/<%=information.getImg()%>" width="454px;" height="353px;" />
					<%} %> 
					</td>
				</tr>
				<tr>
					<td class="t">내용</td>
					<td style="text-align: left; padding-left: 50px; padding-right: 50px; padding-top:20px;">
					<textarea readonly="readonly" rows="20" cols="100" style="border: none"><%=information.getContent()%></textarea></td>
				</tr>
				<%if(id.equals("admin")){ %>
					<tr>
						<td></td>
						<td style="padding-top: 20px;">
							<button onclick="window.location = 'InformationModifyForm.jsp?num=<%=num%>'" >수정페이지로 이동</button>
							<button onclick="window.location = 'InformationDeletePro.jsp?num=<%=num%>'" >삭제</button>
						</td>
					</tr>
				<%}%>
			</table>
		</body>
	<%} %>
</html>