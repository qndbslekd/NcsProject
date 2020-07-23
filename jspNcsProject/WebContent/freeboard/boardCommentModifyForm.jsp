<%@page import="jspNcsProject.dto.BoardCommentDTO"%>
<%@page import="jspNcsProject.dao.BoardCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정폼</title>
</head>
<%
	 int comment_num = Integer.parseInt(request.getParameter("comment_num"));
	 BoardCommentDAO dao =BoardCommentDAO.getInstance();
	 BoardCommentDTO comment = dao.selectBoardComment(comment_num);
	
%>
<body>
	<form action="boardCommentModifyPro.jsp" method="post">
		<input type="hidden" name="comment_num" value="<%=comment_num%>"/>
		<table>
			<tr>
				<td><textarea name="content" cols="70" rows="3" style="resize:none;"><%=comment.getContent()%></textarea></td>
				<td><input type="submit" value="댓글수정"/></td>
			</tr>		
		</table>
	</form>
</body>
</html>
</html>