<%@page import="jspNcsProject.dao.RecipeCommentDAO"%>
<%@page import="jspNcsProject.dto.RecipeCommentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답댓글 달기</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
</head>

<%
	//원문 댓글의 번호
	int num = Integer.parseInt(request.getParameter("num"));

	RecipeCommentDAO dao = RecipeCommentDAO.getInstance();
	//원문 댓글 가져오기
	RecipeCommentDTO oriComment = dao.selectRecipeComment(num);

	
%>
<body>
	<form method="post" action="recipeCommentInsertPro.jsp">													
		<input type="hidden" name="recipeNum" value="<%=oriComment.getRecipeNum()%>"/>
		<input type="hidden" name="reLevel" value="1"/>
		<input type="hidden" name="ref" value="<%=oriComment.getRef()%>"/>
		<input type="hidden" name="name" value="<%=session.getAttribute("memId")%>"/>
		<input type="hidden" name="receiver" value="<%=oriComment.getName()%>"/>
		
		<table>
			<tr>
				<td colspan="2">답댓글 달기</td>
			</tr>
			<tr>
				<td><textarea name="content" style="resize:none;" required></textarea></td><td><input type="submit" value="댓글작성"/>
			</tr>
		</table>
	</form>
</body>
</html>