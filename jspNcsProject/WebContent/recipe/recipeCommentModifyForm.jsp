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
	//댓글의 번호
	int num = Integer.parseInt(request.getParameter("num"));
	RecipeCommentDAO dao = RecipeCommentDAO.getInstance();
	RecipeDAO rDAO = RecipeDAO.getInstance();
	
	//원문 댓글 가져오기
	RecipeCommentDTO oriComment = dao.selectRecipeComment(num);

	oriComment.setContent(oriComment.getContent().replaceAll("<br>", "\n"));

	//본인 글이 맞는지 확인
	String memId = (String) session.getAttribute("memId");
	if(!memId.equals(oriComment.getName()) && !memId.equals("admin")) {
		%>
		<script>
			alert("본인 글만 수정할 수 있습니다."); 
			history.go(-1); 
		</script><%
	} else {
	
	
%>
<body>
	<form method="post" action="recipeCommentModifyPro.jsp">													
	<input type="hidden" name="num" value="<%=num %>" />		
		<table class="nonBorder">
			<tr>
				<td colspan="3"><h1>댓글 수정하기</h1></td>
			</tr>
			<tr>
				<td rowspan="2" style="width:60px; height:60px; vertical-align:top;border:0px;"><img src="/jnp/save/<%=rDAO.selectImgById(memId)%>" style="width:60px; height:60px; border-radius:30px;"/></td>
				<td style="text-align:left; border:0px;padding-bottom:2px;"><Strong> <%= rDAO.selectNameById(memId) %> </Strong>
			</tr>
			<tr>
				<td><textarea name="content" cols="70" rows="5" style="resize:none; border:2px solid #ccc; border-radius:5px;" required><%=oriComment.getContent() %></textarea></td><td><input type="submit" class="greenButton" value="댓글작성" style="height:100%"> </td>
			</tr>
		</table>
	</form>
</body>

<%} %>
</html>