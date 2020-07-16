<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#search{
			width : 800px;
			margin-top : 100px;
			margin-bottom : 50px;
		}
	#searchRecipe-wrapper{
		width : 968px;
		margin: 0 auto;
	}
	#searchRecipe-wrapper .recipe{
	
		width : 850px;
		height : 150px;
		/*border: 1px solid black;*/
		margin: 20px auto;
		 		
	}
	
	#searchRecipe-wrapper .thumbnail{
		width: 150px;
		height:146px;
		margin: 1px 1px;
		border: 1px solid black;
		float: left;
	}
	
	#searchRecipe-wrapper .info{
		width: 692px;
		height: 146px;	
		margin: 1px 1px;
		border: 1px solid black;
		float: left;			
	}
	
	#searchRecipe-wrapper .info .row {	
		text-align: left;
		height: 19.2px;
		line-height: 19.2px;
		color : black;	
		padding: 5px 10px;	
	}
	
	.info .title{
		font-size: 18px;
		font-weight: bold;
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
	
	h2{
		color: black;
		
		
		
	}
</style>
<%
	request.setCharacterEncoding("utf-8");
	//recuoeSerachPro.jsp에서 파라미터들 받아오기 :검색값, 검색결과리스트
	//검색값
	String name = (String)request.getAttribute("name");//요리명
	String ingredients = (String)request.getAttribute("ingredients");//재료명
	String vegiType  = (String)request.getAttribute("vegiType");//채식 유형
	String difficulty = (String)request.getAttribute("difficulty");//난이도
	String calMore = (String)request.getAttribute("calMore");// 칼로리 하한선
	String calUnder = (String)request.getAttribute("calUnder");//칼로리 상한선
	String writer = (String)request.getAttribute("writer");//작성자

	//검색결과리스트
	ArrayList searchRecipeList = (ArrayList)request.getAttribute("searchRecipeList");
	int count = 0;
	if(searchRecipeList != null){
		count = searchRecipeList.size();
	}
	
	

%>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false"/>
		<table id="search">
			<tr>
				<td>요리명</td>
				<td colspan='7'><input type="text" name="name" <%if(!name.equals(""))%>value="<%=name%>" /></td>
			</tr>
			<tr>
				<td>재료명</td>
				<td colspan='7'><input type="text" name="ingredients" placeholder="재료1,재료2,.." <%if(!ingredients.equals(""))%>value="<%=ingredients%>" /></td>
			</tr>
			<tr>
				<td>분류</td>
				<td>채식유형별</td>
				<td>
					<select name="vegiType">
					
						<option value="total" <%if(vegiType.equals("total"))%>selected>전체</option>
						<option value="vegan"<%if(vegiType.equals("vegan"))%>selected>비건</option>
						<option value="lacto"<%if(vegiType.equals("lacto"))%>selected>락토</option>
						<option value="ovo"<%if(vegiType.equals("ovo"))%>selected>오보</option>
						<option value="lacto ovo"<%if(vegiType.equals("lacto ovo"))%>selected>락토 오보</option>
						<option value="pesco"<%if(vegiType.equals("pesco"))%>selected>페스코</option>
						<option value="pollo"<%if(vegiType.equals("pollo"))%>selected>폴로</option>
						<option value="flexitarian"<%if(vegiType.equals("flexitarian"))%>selected>플렉시테리언</option>	
					</select>
					<img src="./img/question.png" width="20px" height="20px" />
				</td>	
				<td>난이도별</td>
				<td>
					<select name="difficulty">
						<option value="전체" <%if(difficulty.equals("전체"))%>selected>전체</option>
						<option value="쉬움" <%if(difficulty.equals("쉬움"))%>selected>쉬움</option>
						<option value="보통" <%if(difficulty.equals("보통"))%>selected>보통</option>
						<option value="어려움" <%if(difficulty.equals("어려움"))%>selected>어려움</option>
					</select>
				</td>
				<td>열량</td>
				<td>
				<input type="text" name="calMore" <%if(!name.equals(""))%> value="<%=calMore%>" />~
				<input type="text" name="calUnder" <%if(!name.equals(""))%> value="<%=calUnder%>"/>
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td colspan='7'><input type="text" name="writer" <%if(!writer.equals(""))%> value="<%=writer%>"/></td>
			</tr>
			<tr>
				<td colspan='8'><input type="submit" value="검색"/></td>
			</tr>
		</table>
	
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
	<div id="searchRecipe-wrapper">
		<%if(searchRecipeList == null){%>
			<h2>검색된 레시피가 없습니다.</h2>
		
		<%}else{
			for(int i = 0 ; i < searchRecipeList.size() ; i++){	
					RecipeDTO recipe  = (RecipeDTO)searchRecipeList.get(i);
		%>
		<div class="recipe">
			<div class="thumbnail">
				<img width="150px" height="146px" src="/jnp/recipe/imgs/<%=recipe.getThumbnail()%>"/>
			</div>
			<div class="info">
				<div class='row title' ><%=recipe.getRecipeName() %></div>
				<div class='row'>posted by <%=recipe.getWriter() %></div>
				<div class='row'>평점: <%=recipe.getRating() %>(리뷰수)</div>
				<div class='row'>채식유형 : <%=recipe.getVegiType()%> | 난이도 : <%=recipe.getDifficulty()%> 
				| 조리시간: <%=recipe.getCookingTime()%>분 | 분량: <%=recipe.getQuantity()%>인분 | 칼로리(1인분/Kcal): <%=recipe.getCal()%>Kcal		
				</div>
				<div class='row'>재료: <%= recipe.getIngredients()%></div>				
			</div>		
		</div>		
		<%	}
		} %>
		
	</div>
</body>
</html>