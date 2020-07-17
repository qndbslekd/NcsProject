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
	
	//원문 댓글 가져오기
	RecipeCommentDTO oriComment = dao.selectRecipeComment(num);

	System.out.println(oriComment.getName());

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
		<table>
			<tr>
				<td colspan="2">댓글 수정하기</td>
			</tr>
			<tr>
				<td><textarea name="content" style="resize:none;"><%=oriComment.getContent() %></textarea></td><td><input type="submit" value="댓글수정"/>
			</tr>
		</table>
	</form>
</body>

<%} %>
</html>