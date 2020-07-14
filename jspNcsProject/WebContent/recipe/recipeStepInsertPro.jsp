<%@page import="jspNcsProject.dao.RecipeContentDAO"%>
<%@page import="jspNcsProject.dto.RecipeContentDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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

	RecipeContentDAO dao = RecipeContentDAO.getInstance();
	
	String path = request.getRealPath("imgs");
	int max = 1024*1024*10;
	String enc = "utf-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	
	int recipeStep = Integer.parseInt(mr.getParameter("recipeStep"));
	String recipeName = mr.getParameter("recipeName");
	String thumbnail = mr.getFilesystemName("thumbnail");
	String writer = mr.getParameter("writer");
	String vegiType = mr.getParameter("vegiType");
	String difficulty = mr.getParameter("difficulty");
	String cal = mr.getParameter("cal");
	String quantity = mr.getParameter("quantity");
	String ingredients = mr.getParameter("ingredients");
	String tag = mr.getParameter("tag");
	String cookingTime = mr.getParameter("cookingTime");
	
	
	
	
	
	
	
	
	//레시피 세부내용 넣기
	for ( int i = 1; i <= recipeStep; i++) {
		RecipeContentDTO dto = new RecipeContentDTO();
		String content = mr.getParameter("step" + i);
		String img = mr.getFilesystemName("img" + i);
		
		dto.setStep(i);
		dto.setContent(content);
		dto.setImg(img);
		
	}
	
	

%>
<body>

</body>
</html>