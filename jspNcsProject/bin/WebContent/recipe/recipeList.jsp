<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 게시판</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
<style>

	#search{
		width : 800px;
		margin-top : 100px;
		margin-bottom : 50px;
	}
	#recipe-wrapper{
		width : 968px;
		margin: 0 auto;
	}
	.recipe{
	
		width : 200px;
		height : 300px;
		border: 1px solid black;
		float: left;
		margin: 20px 20px; 		
	}
	
	.thumbnail {
		width: 200px;
		height: 200px;
		border: 1px solid black;
	}
	
	.info{
		height: 100px;		
	}
	
	.info .row {	
		text-align: center;
		height: 30px;
		line-height: 30px;
		color : black;		
	}
		
	.sub-wrapper{
		height: 70px;
		width : 920px;
		margin: 0 auto;
	}
	
	.write_button{
		background-color: green;
		
	}
	
	.total_recipe{
		color: black;
	}

	

	

</style>
</head>
<%
	
	int pageSize =20;
	//최신순
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) pageNum ="1";
	
	int currPage = Integer.parseInt(pageNum);
	int startRow = (currPage-1)*pageSize +1;
	int endRow = currPage*pageSize;
	int count = 0;

	
	RecipeDAO dao = RecipeDAO.getInstance();
	
	List recipeList = null;
	count = dao.getRecipeCount();
	
	if(count>0){
		//recipeList = dao.seletAllReceipeByReg(startRow, endRow);
	}
	System.out.println(recipeList);
	
	int rowNum = 5;
		
%>
<body>
	<jsp:include page="../header.jsp" flush="false"/>
	<form>
	<table id="search">
		<tr>
			<td>요리명</td>
			<td><input type="text" name="name"/></td>
		</tr>
		<tr>
			<td>재료명</td>
			<td><input type="text" name="ingredients" placeholder="재료1,재료2,.."/></td>
		</tr>
		<tr>
			<td>분류</td>
			<td>채식유형별</td>
			<td>난이도별</td>
			<td>열량</td>
			<td>이상~이하</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><input type="text" name="writer"/></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" name="검색"/></td>
		</tr>
	</table>
	</form>
	<div class="sub-wrapper">
		<% if(session.getAttribute("memId")!= null){ %>
		<div>
			<button  class="write_button" onclick="window.location='recipeInsertForm.jsp'" >레시피 작성</button>
		</div>
		<%}%>
		<div class="total_recipe">
			<h3>총 2345개의 레시피가 있습니다.</h3>
		</div>
	</div>
	
	<div id="recipe-wrapper">
	<%if(recipeList==null){ %>
		<h1 style="color:black;">등록된 레시피가 없습니다.</h1>
	<%}else{
		for(int i = 0 ; i< recipeList.size() ; i++){
			RecipeDTO recipe = (RecipeDTO)(recipeList.get(i));
		%>
			<div class="recipe" onclick="window.location='recipeContent.jsp?num=<%=recipe.getNum()%>'">
				<div class="thumbnail">
					<img src=""/>
				</div>
				<div class="info">
					<div class="row"><%=recipe.getRecipeName()%></div>
					<div class="row">posted by <%=recipe.getWriter() %></div>
					<div class="row"><%=recipe.getRating()%>(2)</div>			
				</div>			
			</div>
	<%	}
	}%>			
	</div>

</body>
</html>