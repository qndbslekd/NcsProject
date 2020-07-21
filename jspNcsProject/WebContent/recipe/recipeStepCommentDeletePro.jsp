<%@page import="jspNcsProject.dto.RecipeContentCommentDTO"%>
<%@page import="jspNcsProject.dao.RecipeContentCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>recipeStepCommentDeletePro</title>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	RecipeContentCommentDAO dao = RecipeContentCommentDAO.getInstance();
	RecipeContentCommentDTO dto = new RecipeContentCommentDTO();
	dto = dao.selectRecipeStepComment(num);
	int ref = dto.getRef();
	String memId = (String )session.getAttribute("memId");
	
	if(memId.equals(dto.getName())){
		int realRef = dao.countRecipeStepCommentRef(ref);
		
		if(realRef > 1){
			dao.deleteRecipeStepAllComment(ref);
		}else if(realRef == 1){
			dao.deleteRecipeContentCommentAll(num);
		}
	
		%>
		<script> alert("삭제되었습니다."); location.href=document.referrer; </script>		
	<%	
	}else{ %>
		<script> alert("본인 댓글만 삭제할 수 있습니다."); history.go(-1);</script>
	<%}
%>
</head>
<body>
	
</body>
</html>