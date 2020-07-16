<%@page import="java.util.ArrayList"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@page import="jspNcsProject.dto.RecipeContentDTO"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="jspNcsProject.dao.RecipeContentDAO"%>
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
	RecipeDAO dao2 = RecipeDAO.getInstance();
	
	String path = request.getRealPath("recipe/imgs");
	int max = 1024*1024*10;
	String enc = "utf-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	
	int num = Integer.parseInt(mr.getParameter("num"));
	RecipeDTO original = dao2.selectRecipeBoard(num);
	
	int recipeStep = Integer.parseInt(mr.getParameter("recipeStep"));
	String recipeName = mr.getParameter("recipeName");
	String thumbnail = mr.getFilesystemName("thumbnail");
	//만약 사진 수정을 안했으면 기존 사진 유지
		if(thumbnail==null){
			thumbnail = original.getThumbnail();
		}
	
	String writer = mr.getParameter("writer");
	String vegiType = mr.getParameter("vegiType");
	String difficulty = mr.getParameter("difficulty");
	String cal = mr.getParameter("cal");
	String quantity = mr.getParameter("quantity");
	String ingredients = mr.getParameter("ingredients");
	String tag = mr.getParameter("tag");
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
	recipe.setNum(num);
	
	dao.updateRecipeBoard(recipe);
	
	//레시피 세부내용 넣기
	//기존 세부내용 불러오기
	List originalContents = dao.selectRecipeContent(num);
		//기존 조리단계의 num 보존
		List numList = new ArrayList();
		for(int i = 0; i < originalContents.size(); i++) {
			RecipeContentDTO dto = (RecipeContentDTO) originalContents.get(i);
			numList.add(dto.getNum());
		}
	
	//받아온 내용으로 리스트 만들기
	List list = new ArrayList();
	
	for ( int i = 1; i <= recipeStep; i++) {
		RecipeContentDTO dto = new RecipeContentDTO();
		RecipeContentDTO oriStep = null;
		if(i <= originalContents.size()){ oriStep = (RecipeContentDTO) originalContents.get(i-1);}
		
		if(i <= numList.size()) {
			int oriNum = (int) numList.get(i-1);
			dto.setNum(oriNum);
		} 
		
		String content = mr.getParameter("step" + i);
		String img = mr.getFilesystemName("img" + i);
		//만약 사진 수정을 안했으면 기존 사진 유지
			if(img==null){
				if(oriStep!=null){
					img = oriStep.getImg();
				} else {
					img="default.png";
				}
			}
		
		dto.setRecipeNum(num);
		dto.setStep(i);
		dto.setContent(content);
		dto.setImg(img);
		
		
		list.add(dto);
	}

	//기존 조리단계 삭제
	dao.deleteRecipeContent(num);
	//새로 만든 리스트로 다시 작성
	dao.updateRecipeContent(list, numList.size());
	
	response.sendRedirect("recipeContent.jsp?num=" + num);

%>
<body>

</body>
</html>