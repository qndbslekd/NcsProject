<%@page import="jspNcsProject.dao.BoardCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<%
	if(session.getAttribute("memId") == null || request.getParameter("comment_num") == null){%>
	<script>
		alert("잘못된 접근입니다.");
		history.go(-1);
	</script>
	<% }else{

	int comment_num = Integer.parseInt(request.getParameter("comment_num"));
	BoardCommentDAO dao = BoardCommentDAO.getInstance();
	dao.deleteBoardComment(comment_num);

%>
	<script>
		alert("삭제되었습니다."); location.href = document.referrer;	
	</script>
<%} %>
<body>

</body>
</html>