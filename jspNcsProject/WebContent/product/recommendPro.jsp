<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="org.apache.catalina.ha.backend.Sender"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<%
	System.out.println("PRO페이지 호출");

	ProductDAO dao = ProductDAO.getInstance();
	String comment = request.getParameter("comment");
	String name = session.getAttribute("memName").toString();
	String num = request.getParameter("num");

	if(comment.equals("")){
		//추천일경우만
		dao.updateRecommend(request.getParameter("num"));
		response.sendRedirect(request.getParameter("history"));
	}else{
		//댓글달기이 경우
		System.out.println("num" + num);
		System.out.println("name" + name);
		System.out.println("comment" + comment);
		
		int result  = dao.insertComment(num,name,comment);
		System.out.println(result+"개의 댓글이작성되었습니다");
		response.sendRedirect(request.getParameter("history"));
	}
%>
</body>
</html>