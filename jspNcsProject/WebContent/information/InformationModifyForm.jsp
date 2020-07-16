<%@page import="jspNcsProject.dto.InfomationDTO"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dao.InfomationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<%

	InfomationDAO dao = InfomationDAO.getInstance();
	List<InfomationDTO> information = dao.getInfomation();
%>
<body>
	<form action="informationModifyPro.jsp" method="post">
		<table>
			<tr>
				<td>
					<input type="submit" value="수정">
				</td>
			</tr>			
		<%for(int i=0;i<information.size();i++){%> 
			<tr>
					<th style=" font-size: 100%;"><input type="text" value="<%=information.get(i).getSubject()%>" name="subject"/></th>
			</tr>
			<tbody>
				<tr>
					<td style="text-align: left;"><textarea rows="20" cols="100" name="content"> <%=information.get(i).getContent()%></textarea></td>
				</tr>
			</tbody> 
		<%} %>
		</table>
	</form>
	</body>
</html>