
<%@page import="jspNcsProject.dao.RecommendDAO"%>
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
	
	if(session.getAttribute("memId") == null ){%>
		<script>
			alert("잘못된 접근입니다.");
			history.go(-1);
		</script>
	<% }else{

	int freeboard_num = Integer.parseInt(request.getParameter("freeboard_num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String member_id = request.getParameter("mem_id");
	
	RecommendDAO dao = RecommendDAO.getInstance();
	//추천여부확인
	boolean ch = dao.checkRecommend(freeboard_num, member_id);
	
	if(ch == false){
		dao.insertRecommend(freeboard_num, member_id);
	}else if(ch==true){
		dao.deleteRecommend(freeboard_num, member_id);
	}
	
	String url = "boardContent.jsp?num="+freeboard_num+"&route=recommend&pageNum="+pageNum;
	response.sendRedirect(url);	
}
%>

<body>
</body>
</html>