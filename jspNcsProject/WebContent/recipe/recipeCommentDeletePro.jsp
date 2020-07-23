<%@page import="jspNcsProject.dto.RecipeCommentDTO"%>
<%@page import="jspNcsProject.dao.RecipeCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 삭제</title>
</head>
<%
request.setCharacterEncoding("utf-8");

if(request.getParameter("num") != null) {
	
	int num = Integer.parseInt(request.getParameter("num"));
	
	String memId = (String) session.getAttribute("memId");
	
	RecipeCommentDAO dao = RecipeCommentDAO.getInstance();
	RecipeCommentDTO comment = dao.selectRecipeComment(num);
	
	if(memId.equals(comment.getName())) {
		dao.deleteRecipeComment(num);
		%> <script> alert("삭제되었습니다."); location.href = document.referrer; </script> <%
	} else {
		%> <script> alert("본인 댓글만 삭제할 수 있습니다."); history.go(-1); </script> <%
	}
	
} else {
	%> <script> alert("잘못된 접근입니다."); history.go(-1); </script> <%
}


%>
<body>

</body>
</html>