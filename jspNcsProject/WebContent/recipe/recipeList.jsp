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
		recipeList = dao.seletAllReceipeByReg(startRow, endRow);
	}
	
	
	int rowNum = 5;
		
%>
<body>
	<jsp:include page="../header.jsp" flush="false"/>
	<form action="recipeSearchPro.jsp" name="searchForm" method="post">
		<table id="search">
			<tr>
				<td>요리명</td>
				<td colspan='7'><input type="text" name="name"/></td>
			</tr>
			<tr>
				<td>재료명</td>
				<td colspan='7'><input type="text" name="ingredients" placeholder="재료1,재료2,.."/></td>
			</tr>
			<tr>
				<td>분류</td>
				<td>채식유형별</td>
				<td>
					<select name="vegiType">
						<option value="total" selected>전체</option>
						<option value="vegan">비건</option>
						<option value="lacto">락토</option>
						<option value="ovo">오보</option>
						<option value="lacto ovo">락토 오보</option>
						<option value="pesco">페스코</option>
						<option value="pollo">폴로</option>
						<option value="flexitarian">플렉시테리언</option>	
					</select>
					<img src="./imgs/question.png" width="20px" height="20px" />
				</td>	
				<td>난이도별</td>
				<td>
					<select name="difficulty">
						<option value="전체" selected>전체</option>
						<option value="쉬움">쉬움</option>
						<option value="보통">보통</option>
						<option value="어려움">어려움</option>
					</select>
				</td>
				<td>열량</td>
				<td>
				<input type="text" name="calMore"/>~
				<input type="text" name="calUnder"/>
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td colspan='7'><input type="text" name="writer"/></td>
			</tr>
			<tr>
				<td colspan='8'><input type="submit" value="검색"/></td>
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
			<h3>총 <%=count %>개의 레시피가 있습니다.</h3>		
		</div>
		<div class="sort_button">
				<button onclick="window.location='recipeList.jsp'">최신순</button>
				<button onclick="window.location='recipeList.jsp'">평점순</button>
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