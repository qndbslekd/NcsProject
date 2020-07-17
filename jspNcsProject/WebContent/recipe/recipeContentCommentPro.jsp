<%@page import="java.sql.Timestamp"%>
<%@page import="jspNcsProject.dao.RecipeContentCommentDAO"%>
<%@page import="jspNcsProject.dto.RecipeContentCommentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>recipeContentCommentPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String comment = request.getParameter("commentContent");
	int contentNum = Integer.parseInt(request.getParameter("contentNum"));
	int recipeNum = Integer.parseInt(request.getParameter("recipeNum"));
	String memName = (String)session.getAttribute("memName");
	int reLevel = Integer.parseInt(request.getParameter("reLevel"));
	int reStep = Integer.parseInt(request.getParameter("reStep"));
	int ref = Integer.parseInt(request.getParameter("ref"));

	
	RecipeContentCommentDTO dto = new RecipeContentCommentDTO();
	RecipeContentCommentDAO dao = RecipeContentCommentDAO.getInstance();
	
	dto.setRecipeNum(recipeNum);
	dto.setContentNum(contentNum);
	dto.setReLevel(reLevel);
	dto.setReStep(reStep);
	dto.setContent(comment);
	dto.setName(memName);
	dto.setReg(new Timestamp(System.currentTimeMillis()));
	dto.setRef(ref);
		
	dao.insertRecipeContentComment(dto);
	
%>
	<script>
		opener.parent.location.reload();
		self.close();
	</script>

<body>

</body>
</html>