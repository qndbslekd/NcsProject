<%@page import="jspNcsProject.dao.TagDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dto.RecipeDTO"%>
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
	
	String path = request.getRealPath("recipe/imgs");
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
	
	
	System.out.println("받아온 재료 : " + ingredients );
	//재료 다듬어서 저장하기
	String ingre = ",";
	//줄바꿈을 콤마로 바꾸기
	ingredients = ingredients.replaceAll("\n", ",");
	System.out.println("중간 재료 : " + ingredients );
	//콤마 기준으로 나누기
	String[] ingreSplit = ingredients.split(",");
	
	for(int i = 0; i<ingreSplit.length; i++) {
		ingreSplit[i] = ingreSplit[i].trim(); //양쪽 공백 없애고 
		String[] tmp = ingreSplit[i].split(":");
		tmp[0] = tmp[0].trim();
		tmp[1] = tmp[1].trim();
		ingre += tmp[0] + ":" + tmp[1] + ","; //문자열에 더하기
	}
	
	ingredients = ingre;
	System.out.println("넣는 재료 : " + ingre);
	
	
	//태그 다듬어서 저장하기
	if(tag != null && !tag.equals("")) {
		String tags = ",";
		//콤마 기준으로 나누기
		String[] tagSplit = tag.split(",");
		
		for(int i = 0; i<tagSplit.length; i++) {
			tagSplit[i] = tagSplit[i].trim(); //양쪽 공백 없애고 
			//tag table에 태그 insert
			TagDAO daoo = TagDAO.getInstance();
			daoo.updateTag(tagSplit[i]);
			
			tags += tagSplit[i] + ",";	//문자열에 더하기
		}
		tag = tags;
	}
	
	
	
	
	
	
	String cookingTime = mr.getParameter("cookingTime");
	
	RecipeDTO recipe = new RecipeDTO();
	recipe.setRecipeStep(recipeStep);
	recipe.setRecipeName(recipeName);
	recipe.setThumbnail(thumbnail);
	recipe.setWriter(writer);
	recipe.setVegiType(vegiType);
	recipe.setDifficulty(difficulty);
	recipe.setCal(Integer.parseInt(cal));
	recipe.setQuantity(Integer.parseInt(quantity));
	recipe.setIngredients(ingredients);
	recipe.setTag(tag);
	recipe.setCookingTime(Integer.parseInt(cookingTime));
	
	int recipeNum = dao.insertRecipeBoard(recipe);
	
	
	//받아온 내용으로 리스트 만들기
	List list = new ArrayList();
	for ( int i = 1; i <= recipeStep; i++) {
		RecipeContentDTO dto = new RecipeContentDTO();
		
		String content = mr.getParameter("step" + i);
		String img = mr.getFilesystemName("img" + i);
		if(img==null) { img="default.png";}
		
		
		dto.setRecipeNum(recipeNum);
		dto.setStep(i);
		dto.setContent(content);
		dto.setImg(img);
		
		list.add(dto);
	}
	
	dao.insertRecipeContent(list);
	
	response.sendRedirect("recipeContent.jsp?num=" + recipeNum);

%>
<body>

</body>
</html>