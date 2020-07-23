<%@page import="jspNcsProject.dao.BoardCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 
	request.setCharacterEncoding("utf-8");
	int comment_num = Integer.parseInt(request.getParameter("comment_num"));
	String content = request.getParameter("content");
	
	BoardCommentDAO dao = BoardCommentDAO.getInstance();
	dao.updateBoardComment(comment_num, content);
%>	
	<script>
		alert("댓글이 수정되었습니다.")
		opener.parent.location.reload();
		self.close();		
	</script>

<body>

</body>
</html>