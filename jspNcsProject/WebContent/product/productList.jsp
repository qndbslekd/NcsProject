<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>제품 리스트</title>
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
		float: left;
		margin: 20px 20px; 		
	}
	.thumbnail {
		height: 200px;
		border-top : 1px solid black;	
		border-right : 1px solid black;	
		border-left : 1px solid black;	
	}
	.info{
		height: 100px;	
		border: 1px solid black;	
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

	//paging
	int pageSize =20;
	//최신순
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) pageNum ="1";
	
	int currPage = Integer.parseInt(pageNum);
	int startRow = (currPage-1)*pageSize +1;
	int endRow = currPage*pageSize;
	int count = 0;
	
	String mode = request.getParameter("mode");
	if(mode==null){
		mode = "num";
	}
	System.out.println("mode : "+mode);
	
	ProductDAO dao = ProductDAO.getInstance();
	
	List recipeList = null;
	count = dao.getProductCount();
	
	if(count>0){
		recipeList = dao.seletAllProduct(startRow, endRow, mode);
	} 
	int rowNum = 5;
%>
<jsp:include page="../header.jsp" flush="false"/>
<body>
	<form action="productList.jsp" method="get">
		<table>
			<tr>
				<td>
					<select name="option">
						<option value="name">제품명</option>
						<option value="ingredients">성분</option>
					</select> <input type="text" name="search" placeholder="성분ex)인공감미료" />
					<input type="submit" value="검색" />
				</td>
			</tr>
		</table>
	</form>
	
	<div class="sub-wrapper">
		<% if(session.getAttribute("memId")!= null&&session.getAttribute("memId").equals("admin")){ %>
		<div>
			<button  class="write_button" onclick="window.location='productForm.jsp'" >제품 등록</button>
		</div>
		<%}%>
		
		<div class="total_recipe">
			<h3>총 <%=count %>개의 제품가 있습니다.</h3>		
		</div>
		
		<div class="sort_button">
				<button onclick="window.location='productList.jsp?mode=num'">최신순</button>
				<button onclick="window.location='productList.jsp?mode=rating'">평점순</button>
		</div>
	</div>
	
	<%-- <div id="recipe-wrapper">
	<%if(recipeList==null){ %>
		<h1 style="color:black;">등록된 레시피가 없습니다.</h1>
	<%}else{
		for(int i = 0 ; i< recipeList.size() ; i++){
			RecipeDTO recipe = (RecipeDTO)(recipeList.get(i));
		%>
			<div class="recipe" onclick="window.location='recipeContent.jsp?num=<%=recipe.getNum()%>'">
				<div class="thumbnail">
					<img width="198px" height="198px" src="/jnp/recipe/imgs/<%=recipe.getThumbnail()%>"/>
				</div>
				<div class="info">
					<div class="row"><%=recipe.getRecipeName()%></div>
					<div class="row">posted by <%=recipe.getWriter() %></div>
					<div class="row"><%=recipe.getRating()%>(2)</div>			
				</div>			
			</div>
	<%	}
	}%>			
	</div> --%>

</body>
</html>