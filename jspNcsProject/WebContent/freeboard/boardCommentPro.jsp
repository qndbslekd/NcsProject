<%@page import="jspNcsProject.dao.BoardCommentDAO"%>
<%@page import="jspNcsProject.dto.BoardCommentDTO"%>
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

	System.out.println(request.getParameter("freeboard_num") == null);
	
	if(session.getAttribute("memId") == null || request.getParameter("freeboard_num") == null){%>
		<script>
			alert("잘못된 접근입니다.");
			history.go(-1);
		</script>
	<% }else{

	
	

	int freeboard_num = Integer.parseInt(request.getParameter("freeboard_num"));
	String strRef = request.getParameter("ref");
	String StrRe_level = request.getParameter("re_level");
	String receiver = request.getParameter("receiver");
	
	int ref =0;
	int re_level =0;
	if(strRef != null && !strRef.equals("")){
		ref = Integer.parseInt(strRef);
	}
	if(StrRe_level != null && !StrRe_level.equals("")){
		re_level = Integer.parseInt(StrRe_level);
	}
	if(receiver != null && receiver.equals("")){
		receiver = null;
	}

	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	
	BoardCommentDTO comment = new BoardCommentDTO(0,freeboard_num,ref,re_level,null,receiver,writer,content);
	
	BoardCommentDAO dao = BoardCommentDAO.getInstance();
	dao.insertBoardComment(comment);
	
	if(ref!=0){%>
		<script>
			opener.parent.location.reload();
			self.close();		
		</script>
		
	<%}else{%>
		<script>alert("댓글이 작성되었습니다.")</script>	
	<%	String url ="boardContent.jsp?num="+freeboard_num;
		response.sendRedirect(url);
	}
} %>
<body>

</body>
</html>