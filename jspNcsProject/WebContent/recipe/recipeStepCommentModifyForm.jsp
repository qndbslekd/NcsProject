<%@page import="jspNcsProject.dto.RecipeContentCommentDTO"%>
<%@page import="jspNcsProject.dao.RecipeContentCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>recipeStepCommentModifyForm</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>

</head>
<%
	request.setCharacterEncoding("UTF-8");

	// 댓글 고유번호 꺼내기
	int num = Integer.parseInt(request.getParameter("num"));
	// 댓글 정보 가져오기
	RecipeContentCommentDAO dao = RecipeContentCommentDAO.getInstance();
	RecipeContentCommentDTO dto = new RecipeContentCommentDTO();
	dto = dao.selectRecipeStepComment(num);
	
	// 본인 글이 맞는지 확인 
	String memName = (String)session.getAttribute("memName");	
	if(!memName.equals(dto.getName()) && !memName.equals("관리자")){
		// 관리자도 아니고 글쓴이도 아니면 수정 못하게 막기  %>
		<script>
			alert("본인글만 수정할 수 있습니다.");
			history.go(-1);
		</script>
	<%}else{
		
%>
<body>
	<form action="recipeStepCommentModifyPro.jsp" method="post">
	<input type="hidden" name="num" value="<%= num %>"/>
		<table>
			<tr>
				<td>
				 	댓글 수정
				</td>
			</tr>
			<tr>
				<td>
					<textarea name="content" style="resize:none;"><%= dto.getContent() %></textarea>
					<input type="submit" value="수정"/>
				</td>
			</tr>
		</table>
	</form>



</body>

<%} %>
</html>