<%@page import="jspNcsProject.dao.RecipeDAO"%>
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
	RecipeDAO rDAO = RecipeDAO.getInstance();
	String memId = (String) session.getAttribute("memId");
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
		
		<table class="nonBorder">
			<tr>
				<td rowspan="2" style="width:60px; height:60px; vertical-align:top;border:0px;"><img src="/jnp/save/<%=rDAO.selectImgById(memId)%>" style="width:60px; height:60px; border-radius:30px;"/></td>
				<td style="text-align:left; border:0px;padding-bottom:2px;"><Strong> <%= rDAO.selectNameById(memId) %> </Strong>
			</tr>
			<tr>
				<td><textarea name="content" cols="70" rows="5" style="resize:none; border:2px solid #ccc; border-radius:5px;" required></textarea></td><td><input type="submit" class="greenButton" value="댓글작성" style="height:100%"> </td>
			</tr>
		</table>
	</form>
</body>
</html>