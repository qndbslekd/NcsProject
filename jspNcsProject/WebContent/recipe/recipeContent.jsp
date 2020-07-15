
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dto.RecipeContentDTO"%>
<%@page import="jspNcsProject.dao.RecipeContentDAO"%>
<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe Content</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String writer = request.getParameter("writer");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
	
	RecipeDAO recipeDAO = RecipeDAO.getInstance();
	RecipeDTO recipeBoard = new RecipeDTO();
	recipeBoard = recipeDAO.selectRecipeBoard(num);
	

	
	// recipeContentList : 레시피 조리단계  담아준 리스트 -> for문 돌려서 뽑기
	
	//selectRecipeContent
	
	RecipeContentDTO recipeContentdto = new RecipeContentDTO();
	RecipeContentDAO recipeContentdao = RecipeContentDAO.getInstance();
	/*
	List recipeContentList = null;
	recipeContentList = recipeContentdao.selectRecipeContent(16);
	for(int i = 0; i < recipeContentList.size(); i++){
		recipeContentdto = (RecipeContentDTO)recipeContentList.get(i);
		System.out.println(recipeContentdto.getContent());
		
	}
	*/
%>
<body>
	<br />
	<h1 align="center">   content </h1>
	<button onclick="window.location='recipeModifyForm.jsp?num=<%=num %>'">수정</button>
</body>
</html>