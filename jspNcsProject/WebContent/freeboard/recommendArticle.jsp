
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

	int freeboard_num = Integer.parseInt(request.getParameter("freeboard_num"));
	String member_id = request.getParameter("mem_id");
	
	RecommendDAO dao = RecommendDAO.getInstance();
	//추천여부확인
	boolean ch = dao.checkRecommend(freeboard_num, member_id);
	
	if(ch == false){
		dao.insertRecommend(freeboard_num, member_id);
		System.out.println("추천");

	}else if(ch==true){
		dao.deleteRecommend(freeboard_num, member_id);
		System.out.println("추천 해지");
	}
	
	String url = "boardContent.jsp?num="+freeboard_num;
	response.sendRedirect(url);	
%>

<body>
</body>
</html>