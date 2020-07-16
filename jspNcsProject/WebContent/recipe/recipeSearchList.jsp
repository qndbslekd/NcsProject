<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
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
		height: auto;
		display: overflow;
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
	.paging{
		width: 960px;
		margin: 0 auto;
		text-align: center;
		
	}
	.page{
		display: inline-block;
		color : black;
	}
</style>
<%
	request.setCharacterEncoding("utf-8");
	//검색 값 파라미터들 받아오기 :검색값, 검색결과리스트	
	//검색조건 6가지
	

	String name = request.getParameter("name");//요리명
	String ingredients = request.getParameter("ingredients");//재료명
	String vegiType  = request.getParameter("vegiType");//채식 유형
	String difficulty = request.getParameter("difficulty");//난이도
	String calMore = request.getParameter("calMore");// 칼로리 하한선
	String calUnder = request.getParameter("calUnder");//칼로리 상한선
	String writer = request.getParameter("writer");//작성자
		
	//where절 쿼리 처리
	String whereQuery="where 1=1";	
	//요리명 검색
	
	
	if(name!=null && !name.equals("")){
		//앞뒤 공백제거
		name = name.trim();
		whereQuery += (" and recipe_name like '%"+name+"%'");
	}
	//재료로 검색
 	if( ingredients!=null && !ingredients.equals("")){
		String[] splitIngredients = ingredients.split(",");// 구분자로 재료구분
		
		for(int i = 0 ; i < splitIngredients.length ; i++){//재료명 앞뒤 공백제거
			splitIngredients[i] =  splitIngredients[i].trim();
		}
		for(int i = 0; i < splitIngredients.length ; i++){
			whereQuery += (" and ingredients like '%"+splitIngredients[i]+"%'");
		}
	
	}
	//채식 타입으로 검색
	if( vegiType != null && !vegiType.equals("") ){
		if(!vegiType.equals("total")){
			whereQuery += (" and vegi_type ='"+vegiType+"'");
		}	
	}
	
	//난이도로 검색
	if(!difficulty.equals("") && difficulty!=null){
		if(!difficulty.equals("전체")){
			whereQuery += (" and difficulty='"+difficulty+"'");
		}
	}
	//칼로리 검색
	
	// null 100
	// "" null
	
	
	if(( calMore!=null && !calMore.equals("") )|| (calUnder!= null && !calUnder.equals(""))){//둘중 하나라도 값이 있을때	
		if(( calMore!=null  && !calMore.equals("")) && (calUnder!=null && !calUnder.equals(""))){ // 둘다 있는경우
			int calMoreNum = Integer.parseInt(calMore);
			int calUnderNum = Integer.parseInt(calUnder);
			whereQuery +=(" and cal >= "+ calMoreNum + " and cal<="+calUnderNum);	
		}else if(calMore!=null && !calMore.equals("")){//이상값만 있는경우
			int calMoreNum = Integer.parseInt(calMore);
			whereQuery += (" and cal >= "+calMoreNum) ;
		}else if(calUnder!= null  && !calUnder.equals("")){ //이하값만 있는경우
			int calUnderNum = Integer.parseInt(calUnder);
			whereQuery += (" and cal <= "+calUnderNum);
		}
	}

	//작가 검색
	if(writer!=null || !writer.equals("")){
		writer = writer.trim();//앞뒤 공백제거
		whereQuery += (" and writer like '%"+writer+"%'");
	}
		
	RecipeDAO dao = RecipeDAO.getInstance();
	
	int pageSize =20;
	//최신순
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) pageNum ="1";
	
	int currPage = Integer.parseInt(pageNum);
	int startRow = (currPage-1)*pageSize +1;
	int endRow = currPage*pageSize;
	
	String mode="num";
	//mode가 num이면 최신순, rating이면 평점순
	if(request.getParameter("mode")!=null){
		mode= request.getParameter("mode");
	}
	
	
	List searchRecipeList = dao.searchRecipeList(startRow, endRow, whereQuery, mode);
	
	//검색결과리스트
	int count = 0;
	if(searchRecipeList !=null) count= searchRecipeList.size();
	
	//카운트 처리
%>
</head>
<body>
	<form action="recipeSearchList.jsp" name="searchForm" method="post">
		<input type="hidden" name="mode" value="num"/>
		<jsp:include page="../header.jsp" flush="false"/>
			<table id="search">
				<tr>
					<td>요리명</td>
					<td colspan='7'><input type="text" name="name" <%if(name!= null && !name.equals(""))%>value="<%=name%>" /></td>
				</tr>
				<tr>
					<td>재료명</td>
					<td colspan='7'><input type="text" name="ingredients" placeholder="재료1,재료2,.." <%if(ingredients!=null && !ingredients.equals(""))%>value="<%=ingredients%>" /></td>
				</tr>
				<tr>
					<td>분류</td>
					<td>채식유형별</td>
					<td>
						<select name="vegiType">							
							<option value="total" <%if(vegiType != null && vegiType.equals("total"))%>selected>전체</option>
							<option value="vegan"<%if(vegiType != null && vegiType.equals("vegan"))%>selected>비건</option>
							<option value="lacto"<%if(vegiType != null && vegiType.equals("lacto"))%>selected>락토</option>
							<option value="ovo"<%if(vegiType != null && vegiType.equals("ovo"))%>selected>오보</option>
							<option value="lacto ovo"<%if(vegiType != null && vegiType.equals("lacto ovo"))%>selected>락토 오보</option>
							<option value="pesco"<%if(vegiType != null && vegiType.equals("pesco"))%>selected>페스코</option>
							<option value="pollo"<%if(vegiType != null && vegiType.equals("pollo"))%>selected>폴로</option>
							<option value="flexitarian"<%if(vegiType != null && vegiType.equals("flexitarian"))%>selected>플렉시테리언</option>	
						</select>
						<img src="./img/question.png" width="20px" height="20px" />
					</td>	
					<td>난이도별</td>
					<td>
						<select name="difficulty">
							<option value="전체" <%if(difficulty!=null && difficulty.equals("전체"))%>selected>전체</option>
							<option value="쉬움" <%if(difficulty!=null && difficulty.equals("쉬움"))%>selected>쉬움</option>
							<option value="보통" <%if(difficulty!=null && difficulty.equals("보통"))%>selected>보통</option>
							<option value="어려움" <%if(difficulty!=null && difficulty.equals("어려움"))%>selected>어려움</option>
						</select>
					</td>
					<td>열량</td>
					<td>
					<input type="text" name="calMore" <%if(difficulty!=null && !name.equals(""))%> value="<%=calMore%>" />~
					<input type="text" name="calUnder" <%if(difficulty!=null && !name.equals(""))%> value="<%=calUnder%>"/>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td colspan='7'><input type="text" name="writer" <%if(writer!= null && !writer.equals(""))%> value="<%=writer%>"/></td>
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
				<form action="recipeSearchList.jsp">
					<input type="hidden" name="name" value="<%=name%>" />
					<input type="hidden" name="ingredients" value="<%=ingredients%>" />
					<input type="hidden" name="vegiType" value="<%=vegiType%>" />
					<input type="hidden" name="difficulty" value="<%=difficulty%>" />
					<input type="hidden" name="calMore" value="<%=calMore%>" />
					<input type="hidden" name="calUnder" value="<%=calUnder%>" />
					<input type="hidden" name="writer" value="<%=writer%>" />
					<input type="hidden" name="mode" value="num" />
					<input type="submit" value="최신순"/>	
				</form>
				<form action="recipeSearchList.jsp">
					<input type="hidden" name="name" value="<%=name%>" />
					<input type="hidden" name="ingredients" value="<%=ingredients%>" />
					<input type="hidden" name="vegiType" value="<%=vegiType%>" />
					<input type="hidden" name="difficulty" value="<%=difficulty%>" />
					<input type="hidden" name="calMore" value="<%=calMore%>" />
					<input type="hidden" name="calUnder" value="<%=calUnder%>" />
					<input type="hidden" name="writer" value="<%=writer%>" />
					<input type="hidden" name="mode" value="rating"/>
					<input type="submit" value="평점순"/>	
				</form>
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
	
	<div class="paging">
	<%
		if(count>0){
			
			int pageCount = count/pageSize + (count%pageSize == 0? 0 :1);
			int pageBlock = 10;
			
			int startPage = ((currPage-1)/pageBlock)*pageBlock +1;
			int endPage = startPage + pageBlock - 1;
			
			if(endPage > pageCount) endPage= pageCount;
		
			if(startPage > pageBlock){%>
				<div class="page" onclick="window.location='recipeSearchList.jsp?pageNum=<%=startPage-pageBlock%>&name=<%=name%>&ingredients=<%=ingredients%>&vegiType=<%=vegiType%>&difficulty=<%=difficulty%>&calMore=<%=calMore%>&calUnder=<%=calUnder%>&writer=<%=writer%>&mode=<%=mode%>'">&lt;</div>
			<%}
	
			for(int i = startPage ; i<= endPage; i++ ){%>
				<div class="page" onclick="window.location='recipeSearchList.jsp?pageNum=<%=i%>&name=<%=name%>&ingredients=<%=ingredients%>&vegiType=<%=vegiType%>&difficulty=<%=difficulty%>&calMore=<%=calMore%>&calUnder=<%=calUnder%>&writer=<%=writer%>&mode=<%=mode%>'">&nbsp;<%=i %></div>	
			<%}
			
			if(endPage > pageCount){%>
				<div class="page" onclick="window.location='recipeSearchList.jsp?pageNum=<%=startPage+pageBlock%>&name=<%=name%>&ingredients=<%=ingredients%>&vegiType=<%=vegiType%>&difficulty=<%=difficulty%>&calMore=<%=calMore%>&calUnder=<%=calUnder%>&writer=<%=writer%>&mode=<%=mode%>'">&gt;</div>		
			<%}		
			}
	
	
	%>
	</div>
</body>
</html>