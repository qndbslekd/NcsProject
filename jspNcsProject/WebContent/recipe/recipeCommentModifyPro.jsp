<%@page import="jspNcsProject.dao.RecipeCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정 처리</title>
</head>
<%
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));
String content = request.getParameter("content");

content = content.replaceAll("\n", "<br>");

RecipeCommentDAO dao = RecipeCommentDAO.getInstance();
dao.updateRecipeComment(num, content);

	%>
	<script>
	opener.parent.location.reload();
	self.close();
	</script>
	

<body>

</body>
</html>