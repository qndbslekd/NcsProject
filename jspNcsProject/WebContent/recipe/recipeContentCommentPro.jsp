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
	// 유효성 검사
	if(session.getAttribute("memId") == null ){ %>
		<script> alert("로그인 후 이용하세요."); window.location="loginForm.jsp";</script>
	<%}else{
		request.setCharacterEncoding("UTF-8");
		String comment = request.getParameter("commentContent");
		int contentNum = Integer.parseInt(request.getParameter("contentNum"));
		int recipeNum = Integer.parseInt(request.getParameter("recipeNum"));
		String memId = (String)session.getAttribute("memId");
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
		dto.setName(memId);
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
	<%} %>
</html>