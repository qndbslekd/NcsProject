<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<%
	String num = request.getParameter("num");
	if(session.getAttribute("memId") == null||!session.getAttribute("memId").equals("admin")){%>
	<script>
		alert("관리자만 이용할수 있습니다");
		window.location="informationList.jsp";
	</script>
<%}%>
<body>
<form action="informationModifyPro.jsp" method="post">
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
					<input type="text" name="subject"/>
				</th>
			</tr>
			<tbody>
				<tr>
					<td style="text-align: left;">
						<textarea rows="20" cols="100" name="content"></textarea>
					</td>
				</tr>
			</tbody>
			<input type="hidden"  name="num"/>
		</table>
	</form>

</body>
</html>