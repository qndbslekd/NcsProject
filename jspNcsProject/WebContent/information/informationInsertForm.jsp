<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
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
</head>
	<jsp:include page="../header.jsp" flush="false"> 
		<jsp:param value="information" name="mode"/>
	</jsp:include>
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
						<td class="t">제목</td>
						<td><input type="text" name="subject" required="required"/></td>
					</tr> 
					<tr>
						<td class="t">내용</td>
						<td><textarea name="content" cols="70" rows="15" required="required"></textarea></td>
					</tr>
					<tr>
						<td class="t">파일</td>
						<td><input type="file" name="info_img"/></td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="submit" class="grayButton" style="width: 80px; height: 30px; text-align: center" >등록</button>
							<button type="reset" class="grayButton" style="width: 80px; height: 30px; text-align: center" >재입력</button> 
							<button onclick="window.location='informationList.jsp'" class="grayButton" style="width: 80px; height: 30px; text-align: center">취소</button>
						</td>
					</tr>
				</table>
			</form>
			<br/>
		<jsp:include page="../footer.jsp" flush="false"/>
		</body>
<%} %>
</html>