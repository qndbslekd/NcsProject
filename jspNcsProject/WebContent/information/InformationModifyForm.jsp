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
	InfomationDTO information = dao.getInfomation(request.getParameter("num"));
	if(session.getAttribute("memId") == null||!session.getAttribute("memId").equals("admin")){%>
	<script>
		alert("관리자만 이용할수 있습니다");
		window.location="informationList.jsp";
	</script>
<%}%>
<body>
	<form action="informationModifyPro.jsp" method="post" enctype="multipart/form-data" name ="inputForm">
		<table> 
			<tr>
				<td>
					<input type="submit" value="수정">
					<input type="button" value="수정취소" onclick="window.location='informationList.jsp'"/>
				</td>
			</tr>			
			<!--이미지 있으면 수정 불가 -->
			<tr>
				<th style=" font-size: 100%;">
					<input type="text" value="<%=information.getSubject()%>" name="subject"/>
				</th> 
			</tr>
			<tbody>
				<tr>
					<td><img src="img/<%=information.getImg()%>" /></td>
				</tr>
				<tr>
					<td>
						수정할 이미지
						<input type = "file" name ="info_img">
						<input type = "hidden" name = "info_img_before" value="<%=information.getImg()%>"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: left;">
						<textarea rows="20" cols="100" name="content"><%=information.getContent()%></textarea>
					</td>
				</tr>
			</tbody>
			<input type="hidden" value= "<%=information.getNum()%>" name="num"/>
		</table>
	</form>
	</body>
</html>