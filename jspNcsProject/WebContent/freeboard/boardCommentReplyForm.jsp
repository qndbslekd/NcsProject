<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답 댓글 달기</title>
</head>
<%
	 int freeboard_num = Integer.parseInt(request.getParameter("freeboard_num"));
	 int ref = Integer.parseInt(request.getParameter("ref"));
	 int re_level = Integer.parseInt(request.getParameter("re_level"));
	 String receiver = request.getParameter("receiver");

%>
<body>
	<form action="boardCommentPro.jsp" method="post">
		<input type="hidden" name="freeboard_num" value="<%=freeboard_num%>"/>
		<input type="hidden" name="ref" value="<%=ref%>"/>
		<input type="hidden" name="re_level" value="<%=re_level%>"/>
		<input type="hidden" name="receiver" value="<%=receiver%>"/>
		<input type="hidden" name="writer" value="<%=session.getAttribute("memId")%>"/>
		<table>
			<tr>
				<td><textarea name="content" cols="70" rows="3" style="resize:none;"></textarea></td>
				<td><input type="submit" value="댓글작성"/></td>
			</tr>		
		</table>
	</form>
</body>
</html>