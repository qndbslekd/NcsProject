<%@page import="jspNcsProject.dao.BoardCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 
	request.setCharacterEncoding("utf-8");

	if(session.getAttribute("memId") == null || request.getParameter("comment_num") == null){%>
	<script>
		alert("잘못된 접근입니다.");
		history.go(-1);
	</script>
<% 	 }else{

	
	int comment_num = Integer.parseInt(request.getParameter("comment_num"));
	String content = request.getParameter("content");
	System.out.println(content);
	
	BoardCommentDAO dao = BoardCommentDAO.getInstance();
	dao.updateBoardComment(comment_num, content);
%>	
	<script>
		alert("댓글이 수정되었습니다.")
		opener.parent.location.reload();
		self.close();		
	</script>
<%	}%>
<body>

</body>
</html>