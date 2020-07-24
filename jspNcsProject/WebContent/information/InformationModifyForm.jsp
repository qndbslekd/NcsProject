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
<jsp:include page="../header.jsp"></jsp:include>
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
input[type="file"]{
	border:1px solid #ccc;
	border-radius:5px;
	font-size:1.0em;
	self-align:left;
	margin-left:20px;
	vertical-align:middle;
}
</style>
<%
	if(request.getParameter("num")==null||session.getAttribute("memId") == null||!session.getAttribute("memId").equals("admin")){%>
	<script>
		alert("관리자만 이용할수 있습니다");
		window.location="informationList.jsp";
	</script>
<%}else{
	InfomationDAO dao = InfomationDAO.getInstance();
	InfomationDTO information = dao.getInfomation(request.getParameter("num"));
	%>
<body>
		<form action="informationModifyPro.jsp" method="post" enctype="multipart/form-data" name ="inputForm">
			<table>  
				<!--이미지 있으면 수정 불가 --> 
				<tr>
					<td class="t">제목</td> 
					<td style=" font-size: 100%;">
						<input type="text" value="<%=information.getSubject()%>" name="subject" size="50" required="required"/>
					</td> 
				</tr>
					<tr>
						<td class="t">사진</td>
						<td>
						<%if(information.getImg()==null||information.getImg().equals("null")){%> 
							<img src="img/unnamed.gif" width="454px;" height="353px;" />
						<%}else{ %>
							<img src="img/<%=information.getImg()%>" width="454px;" height="353px;" />
						<%} %> 
						</td>
					</tr>
					<tr>
						<td class="t">수정할 이미지</td>
						<td>
							<input type = "file" name ="info_img">
							<input type = "hidden" name = "info_img_before" value="<%=information.getImg()%>"/>
						</td>
					</tr>
					<tr><td class="t">내용</td>
						<td style="text-align: left; padding-left: 50px; padding-right: 50px; padding-top:20px;">
							<textarea rows="20" cols="100" name="content" required="required"><%=information.getContent()%></textarea>
						</td>
					</tr>
					<tr>
						<td></td>
						<td style="padding-top: 20px;">
							<button type="submit" >수정</button>
							<button type="button" onclick="window.location='informationList.jsp'">수정취소</button>
						</td>
					</tr>	
				<input type="hidden" value= "<%=information.getNum()%>" name="num"/>
			</table>
		</form>
		</body>
	<%} %>
</html>