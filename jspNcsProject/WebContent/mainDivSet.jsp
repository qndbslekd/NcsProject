<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배치</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
</head>
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
		margin: 20px 20px; 
		overflow: hidden;		
	}
	.recipe_lst{
		 list-style:none;
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
		background-color: green;
		
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
	}
	div .buttn{
		width:70px;
		float:left;
		border: 1px solid #DADBD7;
		padding: 3px 7px 3px 7px;
		
	}
	div #selected{
		background-color: #44b6b5;
		color: white;
	}
	
	.input-box{
		border: 1px solid #999;
	
	}


</style>
<jsp:useBean id="recipe" class="jspNcsProject.dto.RecipeDTO"/>
<jsp:setProperty property="*" name="recipe" />

<%
int rateCount = Integer.parseInt(request.getParameter("rateCount")); 
RecipeDAO Rdao = RecipeDAO.getInstance();


%>
<body>
	<div class="recipe" onclick="window.location='recipeContent.jsp?num=<%=recipe.getNum()%>'">
		<div class="thumbnail">
			<img width="198px" height="198px" style="border-radius:5px" src="/jnp/recipe/imgs/<%=recipe.getThumbnail()%>"/>
		</div>
		<div class="info">
			<div class="row" style="font-size:17px"><%=recipe.getRecipeName()%></div>
			<div class="row" style="color:#999; font-weight:100;">posted by <%=recipe.getWriter() %></div>
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
</body>
</html>