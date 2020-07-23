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
	String num = request.getParameter("num");
	if((session.getAttribute("memId") == null||!session.getAttribute("memId").equals("admin"))){%>
	<script>
		alert("관리자만 이용할수 있습니다");
		window.location="informationList.jsp";
	</script>
<%}else{%>
		<body>
			<form action="informationInsertPro.jsp" method="post" enctype="multipart/form-data">
				<table>
					<tr> 
						<td><input type="text" name="subject"/></td>
					</tr> 
					<tr>
						<td><textarea name="content" cols="100" rows="30"></textarea></td>
					</tr>
					<tr>
						<td><input type="file" name="info_img"/></td>
					</tr>
					<tr>
						<td>
							<input type="submit" value="등록"/>
							<input type="reset" value="재입력"/>
							<button onclick="window.location='informationList.jsp'">취소</button>
						</td>
					</tr>
				</table>
			</form>
		</body>
<%} %>
</html>