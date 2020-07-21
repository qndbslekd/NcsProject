<%@page import="jspNcsProject.dao.ScrapDAO"%>
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

int num = Integer.parseInt(request.getParameter("num"));
String scraper = request.getParameter("scraper");
String did = request.getParameter("did");
String pageNum = request.getParameter("pageNum");
String prePage = request.getParameter("prePage");
System.out.println("prepage : " + prePage);

ScrapDAO dao = ScrapDAO.getInstance();

if(did == null) {
	dao.insertScrapRecipe(num, scraper);
} else {
	dao.deleteScrapRecipe(num, scraper);
}
response.sendRedirect(prePage+".jsp?num=" + num + "&pageNum=" + pageNum);
%>
<body>

</body>
</html>