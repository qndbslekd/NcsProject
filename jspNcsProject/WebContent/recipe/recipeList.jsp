<%@page import="jspNcsProject.dao.RatingDAO"%>
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
		height: 250px;
		width : 800px;
		margin-top : 50px;
		margin-bottom : 50px;
		background-color : #DADBD7;
	}
	#search .title{
		width:80px;
		font-size:17px;
		text-align: right;
	
	}
	#search .content{
	}
	
	#recipe-wrapper{
		overflow: hidden;
		width : 968px;
		height: auto;
		margin: 0 auto;
	}
	.recipe{
	
		width : 200px;
		height : auto;
		position: relative;
		float: left;
		margin: 15px 15px; 
		overflow: hidden;	
		cursor: pointer;	
	}
	.recipe_lst{
		 list-style:none;
		 overflow:auto;
	}
	
	.thumbnail {
		height: 200px;
		border-radius : 5px;
		
	}
	
	.info{
		overflow: hidden;
		height: auto;
		text-align: left;
		
	}
	
	.info .row {
		padding-left:5px;	
		line-height: 30px;
		color : black;	
		overflow: hidden;
		height: auto;	
	}
	
		
	.sub-wrapper{
		height: 30px;
		width : 920px;
		margin: 0 auto;
	}
	
	.write_button{
		width:100px;
		float:left;
		border: 1px solid #DADBD7;
		padding: 7px 7px 7px 7px;
		background-color: rgb(139, 195, 74);
		color: white;
		cursor: pointer;
		border-radius : 5px;
		
	}
	
	.total_recipe{
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
		cursor:pointer;
		font-size:20px;
	}
	.page:hover{
		color:#8bc34a;
	}
	div .buttn{
		width:70px;
		float:left;
		border: 1px solid #DADBD7;
		padding: 3px 7px 3px 7px;
		cursor: pointer;
		
	}
	div #selected{
		background-color: #8bc34a;
		color: white;
		cursor: pointer;
	}
	
	.input-box{
		border: 1px solid #999;
	
	}


</style>
<script>
	function question(){
		var win = window.open("recipeListVegiTypeInfo.jsp","채식유형 정보","width=900,height=850,left=500,top=500,scrollbars=yes,")
		
	}
</script>
</head>
<%
	
	int pageSize =12;
	//최신순
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) pageNum ="1";
	
	int currPage = Integer.parseInt(pageNum);
	int startRow = (currPage-1)*pageSize +1;
	int endRow = currPage*pageSize;
	int count = 0;
	
	String mode= "num";
	//mode가 num이면 최신순, rating이면 평점순
	if(request.getParameter("mode")!=null){
		mode= request.getParameter("mode");
	}

	RecipeDAO RecipeDao = RecipeDAO.getInstance();
	
	List recipeList = null;
	count = RecipeDao.getRecipeCount();
	
	
	if(count>0){
		recipeList = RecipeDao.seletAllReceipe(startRow, endRow, mode);
	}
	int rowNum = 5;
		
%>
<body>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="recipe" name="mode"/>
	</jsp:include>
	<form action="recipeSearchList.jsp" name="searchForm" method="post">
		<input type="hidden" name="mode" value="num"/>
		<table id="search">
			<tr><td><td/></tr>
			<tr>
				<td class="title">요리명</td>
				<td colspan='7'><input type="text" name="name" class="input-box"style="width: 620px;" /></td>
			</tr>
			<tr>
				<td class="title">재료명</td>
				<td colspan='7'><input type="text" name="ingredients" class="input-box" style="width:620px;"placeholder="재료1,재료2,.."/></td>
			</tr>
			<tr>
				<td class="title">분류</td>
				<td style="width:100px; text-align:right;">채식유형별</td>
				<td style="width:150px;">
					<select name="vegiType" class="input-box">
						<option value="total" selected>전체</option>
						<option value="vegan">비건</option>
						<option value="lacto">락토</option>
						<option value="ovo">오보</option>
						<option value="lacto ovo">락토 오보</option>
						<option value="pesco">페스코</option>
						<option value="pollo">폴로</option>
						<option value="flexitarian">플렉시테리언</option>	
					</select>
					<img src="./imgs/question.png" width="20px" height="20px" onclick="question()" />
				</td>	
				<td style="width:60px;text-align:right;">난이도별</td>
				<td style="width:80px;">
					<select name="difficulty" class="input-box">
						<option value="전체" selected>전체</option>
						<option value="쉬움">쉬움</option>
						<option value="보통">보통</option>
						<option value="어려움">어려움</option>
					</select>
				</td>
				<td style="width:40px; text-align:right;">열량</td>
				<td style="width:100px;">
				<input type="text" name="calMore" style="width:35px;" class="input-box"/> ~
				<input type="text" name="calUnder" style="width:35px;" class="input-box"/>
				</td>
			</tr>
			<tr>
				<td class="title">작성자</td>
				<td colspan='7'><input type="text" name="writer" class="input-box" style="width: 620px;"/></td>
			</tr>
			<tr>
				<td class="title">태그</td>
				<td colspan='7'><input type="text" name="tag" class="input-box" style="width: 620px;" placeholder="태그명1,태그명2,.."/></td>
			</tr>
			<tr>
				<td colspan='8'><input type="submit" value="검색"/></td>
			</tr>
		</table>
	</form>
	
	<div class="sub-wrapper">
		<% if(session.getAttribute("memId")!= null){ %>
		<div style="height:50px;">
			<button  class="write_button" onclick="window.location='recipeInsertForm.jsp'" >레시피 작성</button>
		</div >
		<%}%>
		<div class="total_recipe">
			<div style="text-align:left; font-size:17px; float: left; width:743px;">총 <span style="color:rgb(139, 195, 74); font-size:23px;"><%=count %></span>개의 레시피가 있습니다.</div>
			<div class="sort_button" style="float: left;">
				<div class="buttn" <%if(mode.equals("num")){%> id="selected"<%}%> onclick="window.location='recipeList.jsp?mode=num'">최신순</div>
				<div class="buttn" <%if(mode.equals("rating")){%> id="selected"<%}%> onclick="window.location='recipeList.jsp?mode=rating'">평점순</div>
			</div>		 
		</div>
		
	</div>
	<div id="recipe-wrapper">
	<%if(recipeList==null){ %>
		<h1 style="color:black;">등록된 레시피가 없습니다.</h1>
	<%}else{
		RatingDAO dao = RatingDAO.getInstance();
		int cnt = 0;
		for(int i = 0 ; i< recipeList.size() ; i++){
			cnt += 1;
			RecipeDTO recipe = (RecipeDTO)(recipeList.get(i));		
			int rateCount = dao.getCountRating(recipe.getNum());
			
			if(cnt%4 == 1){%><li class="recipe_lst"><%}%>

			<div class="recipe" onclick="window.location='recipeContent.jsp?num=<%=recipe.getNum()%>'">
				<div class="thumbnail">
					<img width="198px" height="198px" style="border-radius:5px" src="/jnp/recipe/imgs/<%=recipe.getThumbnail()%>"/>
				</div>
				<div class="info">
					<div class="row" style="font-size:17px"><%=recipe.getRecipeName()%></div>
					<div class="row" style="color:#999; font-weight:100;">posted by <%=RecipeDao.selectNameById(recipe.getWriter()) %></div>
					<div class="row"style="font-size:14px">
						<%
						//평점 별 그림 넣기
						for(int j = 0; j < (int)recipe.getRating() ; j++) {
							%> <img src = "/jnp/recipe/imgs/star.png" width="12px" style="margin:0px auto; vertical-align:center"/> 
						<%}%>
						<%for(int j = 0; j < 5-(int)recipe.getRating() ; j++) {
							%> <img src = "/jnp/recipe/imgs/emptyStar.png" width="12px"style="margin:0px auto; vertical-align:center"/> 
						<%}%>
					<%=recipe.getRating()%> (<%=rateCount%>)</div>			
				</div>			
			</div>
			<%if(cnt%4 == 0){%></li><%}%>		
	<%	}
	 }%>			
	</div>
	
	<div class="paging">
	<%
		if(count>0){
			int pageCount = count/pageSize + (count%pageSize == 0 ? 0 :1);
			int pageBlock = 10;

			int startPage = ((currPage-1)/pageBlock)*pageBlock + 1;
			int endPage = startPage + pageBlock -1 ;
			
			if(endPage > pageCount) endPage = pageCount; 
			
			if(startPage > pageBlock){%>
				<div class="page" onclick="window.location='recipeList.jsp?pageNum=<%=startPage-pageBlock%>&mode=<%=mode%>'">&lt;</div>
			<%}
			for(int i = startPage ; i<= endPage; i++){%>
				<div class="page" onclick="window.location='recipeList.jsp?pageNum=<%=i%>&mode=<%=mode%>'">&nbsp;<%=i %></div>	
			<%
			}			
			if(endPage > pageCount){%>
				<div class="page" onclick="window.location='recipeList.jsp?pageNum=<%=startPage+pageBlock%>&mode=<%=mode%>'">&gt;</div>		
			<%}	
		}
	%>

	</div>
<br/>
		<jsp:include page="../footer.jsp" flush="false"/>
</body>
</html>