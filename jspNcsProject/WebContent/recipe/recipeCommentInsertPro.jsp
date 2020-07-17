<%@page import="jspNcsProject.dao.RecipeCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 작성 처리</title>
</head>
<%
request.setCharacterEncoding("utf-8");

String num = request.getParameter("recipeNum");
%>

<jsp:useBean id="comment" class="jspNcsProject.dto.RecipeCommentDTO"/>
<jsp:setProperty property="*" name="comment"/>
<%
RecipeCommentDAO dao = RecipeCommentDAO.getInstance();
dao.insertRecipeComment(comment);
%>
<script>
	alert("댓글이 작성되었습니다.");
</script>
<%response.sendRedirect("recipeContent.jsp?num="+num); %>
<body>

</body>
</html>