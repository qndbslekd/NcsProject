<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dao.ScrapDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 찜한 레시피</title>
<link rel="stylesheet" href="../resource/team05_style.css">
</head>
<style>
	#search{
			width : 800px;
			margin-top : 50px;
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
		height: 28px;
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
		width : 800px;
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
	
	.tag-wrapper{
		overflow: hidden;
		height: auto;
		width : 800px;
		margin: 0 auto;	
	}
	.tag{		
		padding: 5px;
		display: inline-block;
		background-color: gray;
		border-radius: 10px;
		margin: 5px 0;
	}
</style>
<%
request.setCharacterEncoding("utf-8");

String memId = (String) session.getAttribute("memId");

if(memId == null) {
	%> <script> alert("회원만 볼 수 있는 페이지입니다."); window.location="loginForm.jsp"; </script> <%
} else {
	ScrapDAO dao = ScrapDAO.getInstance();
	List list = dao.selectScrapRecipe(memId);

	int pageSize =20;

	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) pageNum ="1";
	
	int currPage = Integer.parseInt(pageNum);
	int startRow = (currPage-1)*pageSize +1;
	int endRow = currPage*pageSize;
	
	//리스트 글수
	int count = 0;
	if(list!=null) count = list.size();
%>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br/>
	<br/>
	<div style="text-align:center; color:rgb(139, 195, 74); display:block; ">
		<h1>내가 찜한 레시피</h1>
	</div>
	<br/>
	
	<div id="searchRecipe-wrapper" style="text-align:center">
		<%if(count == 0){%>
			<h2>찜한 레시피가 없습니다.</h2>
		
		<%}else{
			for(int i = 0 ; i < list.size() ; i++){	
					RecipeDTO recipe  = (RecipeDTO)list.get(i);
		%>
		<div class="recipe" onclick="window.location='../recipe/recipeContent.jsp?num=<%=recipe.getNum()%>'" style="margin-bottom:0px;">
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
				<%--<div class='row'>재료: <%= recipe.getIngredients().substring(1,recipe.getIngredients().length()-1)%></div>--%>				
			</div>		
		</div>
		<div align="right"><button class="greenButton" onclick="UnScrap(<%=recipe.getNum()%>)" style="margin-right:60px; margin-top:3px; padding:3px 10px">찜 해제</button></div>		
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
				<div class="page" onclick="window.location='../recipe/myScrapRecipe.jsp?pageNum=<%=startPage-pageBlock%>'">&lt;</div>
			<%}
	
			for(int i = startPage ; i<= endPage; i++ ){%>
				<div class="page" onclick="window.location='../recipe/myScrapRecipe.jsp?pageNum=<%=i%>'">&nbsp;<%=i %></div>	
			<%}
			
			if(endPage > pageCount){%>
				<div class="page" onclick="window.location='../recipe/myScrapRecipe.jsp?pageNum=<%=startPage+pageBlock%>'">&gt;</div>		
			<%}		
			}
	%>
	</div>
	<br/>
	<button class="greenButton" onclick="window.location='myPage.jsp'">마이페이지로</button>
</body>
<script>
	function UnScrap(num) {
		if(confirm("찜 해제하시겠습니까?")==true) {
			location.href = "../recipe/recipeScrap.jsp?num="+num+"&scraper=<%=memId%>"+"&did=true&pageNum=<%=pageNum%>&prePage=../member/myScrapRecipe";
		}
		
	}
</script>
<%} %>
</html>