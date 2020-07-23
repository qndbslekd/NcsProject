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

	if(request.getParameter("num") == null){ %>
		<script> alert("잘못된 접근입니다."); history.go(-1);</script>
	<%}else{
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));	
		RecipeContentCommentDAO dao = RecipeContentCommentDAO.getInstance();
		RecipeContentCommentDTO dto = new RecipeContentCommentDTO();
		dto = dao.selectRecipeStepComment(num);
		int ref = dto.getRef();
		String memId = (String )session.getAttribute("memId");
		
		// 유효성 검사
		if(memId == null ){ %>
			<script> alert("로그인 후 이용하세요."); window.location="loginForm.jsp";</script>
		<%}else{
	
			if(memId.equals(dto.getName())){
				int realRef = dao.countRecipeStepCommentRef(ref);
				
				if(realRef >= 2){ // 개수가 2개 이상이면 댓글의 댓글이있는 경우니까 여기서도 나눠서 처리필요					
					RecipeContentCommentDTO comment = dao.selectRecipeStepComment(num);
					if(comment.getReLevel() == 0){
						// (댓글을 지우는 경우 : 댓글의 댓글까지 날려야함)
						dao.deleteRecipeStepAllComment(ref);
					}else if(comment.getReLevel() == 1){
						// (댓글의 댓글을 지우는 경우 : 댓글의 댓글 자체만 날리면됨.)
						dao.deleteRecipeStetpcomment(num);
					}					
				}else if(realRef == 1){
					dao.deleteRecipeStetpcomment(num);
				}			
				%>
				<script> alert("삭제되었습니다."); location.href=document.referrer; </script>		
			<%	
			}else{ %>
				<script> alert("본인 댓글만 삭제할 수 있습니다."); history.go(-1);</script>
			<%}
		}
%>
</head>
<body>
	
</body>
	<%} %>
</html>