<%@page import="jspNcsProject.dto.RecipeContentCommentDTO"%>
<%@page import="jspNcsProject.dao.RecipeContentCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>recipeStepCommentModifyPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	// 유효성 검사
	if(session.getAttribute("memId") == null ){ %>
		<script> alert("로그인 후 이용하세요."); window.location="loginForm.jsp";</script>
	<%}else{
		// 댓글 고유번호 꺼내기
		int num = Integer.parseInt(request.getParameter("num"));
		// 수정된 글 내용 꺼내기
		String content = request.getParameter("content");
		
		RecipeContentCommentDAO dao = RecipeContentCommentDAO.getInstance();
		RecipeContentCommentDTO dto = new RecipeContentCommentDTO();
		
		dao.updateRecipeStepComment(num, content);
	%>
		<script>
			opener.parent.location.reload();
			self.close();
		</script>
<body>
 	
</body>
<%} %>
</html>