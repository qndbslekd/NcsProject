<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
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
	
	//url로 바로접근 막아주기. 파라미터가 null일때는 처리안했음
	
	//검색조건 6가지
	String name = request.getParameter("name");//요리명
	String ingredients = request.getParameter("ingredients");//재료명
	String vegiType  = request.getParameter("vegiType");//채식 유형
	String difficulty = request.getParameter("difficulty");//난이도
	String calMore = request.getParameter("calMore");// 칼로리 하한선
	String calUnder = request.getParameter("calUnder");//칼로리 상한선
	String writer = request.getParameter("writer");//작성자
	
	String mode = "num" ;// 최신순인지, 평점순인지
	
	//result 검색창에 검색값을 넣어주기 위해 검색 파라미터들을 넘겨주기
	request.setAttribute("name", name);
	request.setAttribute("ingredients", ingredients);
	request.setAttribute("vegiType", vegiType);
	request.setAttribute("difficulty", difficulty);
	request.setAttribute("calMore", calMore);
	request.setAttribute("calUnder", calUnder);
	request.setAttribute("writer", writer);
	
	//검색 조건이 존재하면 해당 쿼리 컬럼명 배열에 넣어주기
	//null인경우 빈문자열인경우("") 둘다 처리
	
	String whereQuery="where 1=1";
	//RecipeDAO dao = RecipeDAO.searchRecipe(name, ingredients, vegiType, difficulty, calMore, calUnder, writer);
	
	//요리명 검색
	if(!name.equals("")){
		//앞뒤 공백제거
		name = name.trim();
		whereQuery += (" and recipe_name like '%"+name+"%'");
	}
	//재료로 검색
 	if(!ingredients.equals("")){
		String[] splitIngredients = ingredients.split(",");// 구분자로 재료구분
		
		for(int i = 0 ; i < splitIngredients.length ; i++){//재료명 앞뒤 공백제거
			splitIngredients[i] =  splitIngredients[i].trim();
		}
		for(int i = 0; i < splitIngredients.length ; i++){
			whereQuery += (" and ingredients like '%"+splitIngredients[i]+"%'");
		}
	
	}
	//채식 타입으로 검색
	if(!vegiType.equals("")){
		if(!vegiType.equals("total")){
			whereQuery += (" and vegi_type ='"+vegiType+"'");
		}	
	}
	
	//난이도로 검색
	if(!difficulty.equals("")){
		if(!difficulty.equals("전체")){
			whereQuery += (" and difficulty='"+difficulty+"'");
		}
	}
	//칼로리 검색
	
	if(!calMore.equals("") || !calUnder.equals("")){
		if(!calMore.equals("") && calUnder.equals("")){//이상값만 있는경우
			int calMoreNum = Integer.parseInt(calMore);
			whereQuery += (" and cal >= "+calMoreNum);
		}else if(calMore.equals("") && !calUnder.equals("")){ //이하값만 있는경우
			int calUnderNum = Integer.parseInt(calUnder);
			whereQuery += (" and cal <= "+calUnderNum);
		}else if(!calMore.equals("") &&  !calUnder.equals("")){ // 둘다 있는경우
			int calMoreNum = Integer.parseInt(calMore);
			int calUnderNum = Integer.parseInt(calUnder);
			whereQuery +=(" and cal >= "+ calMoreNum + " and cal<="+calUnderNum);
		}
	}
	

	//작가 검색
	if(!writer.equals("")){
		writer = writer.trim();//앞뒤 공백제거
		whereQuery += (" and writer like '%"+writer+"%'");
	}
	
	System.out.println("검색 쿼리문 조건절: " + whereQuery);
	
	RecipeDAO dao = RecipeDAO.getInstance();
	List searchRecipeList = dao.searchRecipeList(whereQuery, mode);
	
	request.setAttribute("searchRecipeList",searchRecipeList);	
	
%>
<jsp:forward page="./recipeSearchList.jsp"/>
<body>

</body>
</html>