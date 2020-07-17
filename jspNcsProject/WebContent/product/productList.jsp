<%@page import="jspNcsProject.dto.ProductDTO"%>
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
	int rowNum = 5;
	
	String mode = request.getParameter("mode");
	if(mode==null){
		mode = "num";
	}
	System.out.println("mode : "+mode);

	ProductDAO dao = ProductDAO.getInstance();
	List productList = null;

	//search Param
	String option = "";
	String search = "";
	option = request.getParameter("option");
	search = request.getParameter("search");
	System.out.println("option : "+option);
	System.out.println("search : "+search);
	
	if(search==null||search.equals("")){
		//비 검색시
		count = dao.getProductCount();
		if(count>0){
			productList = dao.seletAllProduct(startRow, endRow, mode);
		} 
	}else{
		//검색시
		count = dao.getProductCount(option,search);
		if(count>0){
			System.out.println("count"+count);
			productList = dao.seletAllProduct(startRow, endRow, mode,option,search);
		} 
	}
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
			<button  class="write_button" onclick="window.location='productInsertForm.jsp'" >제품 등록</button>
		</div>
		<%}%>
		
		<div class="total_recipe">
			<h3>총 <%=count %>개의 제품가 있습니다.</h3>		
		</div>
		
		<div class="sort_button">
				<%if(search==null||search.equals("")){%>
				<button onclick="window.location='productList.jsp?mode=num'">최신순</button>
				<button onclick="window.location='productList.jsp?mode=rating'">평점순</button>
				<%}else{ %>
				<button onclick="window.location='productList.jsp?mode=num&option=<%=option%>&search=<%=search%>'">최신순</button>
				<button onclick="window.location='productList.jsp?mode=rating&option=<%=option%>&search=<%=search%>'">평점순</button>
				<%} %>
		</div>
	</div>
	<div id="recipe-wrapper">
	<%if(productList==null){ %>
		<h1 style="color:black;">등록된 레시피가 없습니다.</h1>
	<%}else{
		for(int i = 0 ; i< productList.size() ; i++){
			ProductDTO product = (ProductDTO)(productList.get(i));
		%>
			<div class="recipe" onclick="window.location='productContent.jsp?num=<%=product.getNum()%>'">
				<div class="thumbnail">
					<%if(product.getProduct_img()!=null){%>
					<img width="198px" height="198px" src="/jnp/product/imgs/<%=product.getProduct_img()%>"/>
					<%}else{%>
					<img width="198px" height="198px" src="/jnp/product/imgs/unnamed.gif"/>
					<%}%>
				</div>
				<div class="info">
					<div class="row"><%=product.getName()%></div>
					<div class="row">대표성분 :<%=product.getIngredients()%></div>
					<div class="row">평점 :<%=product.getRecommend()%></div>
				</div>			
			</div>
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
				<div class="page" onclick="window.location='productList.jsp?pageNum=<%=startPage-pageBlock%>'">&lt;</div>
			<%}
			for(int i = startPage ; i<= endPage; i++){%>
				<div class="page" onclick="window.location='productList.jsp?pageNum=<%=i%>'">&nbsp;<%=i %></div>	
			<%
			}			
			if(endPage > pageCount){%>
				<div class="page" onclick="window.location='productList.jsp?pageNum=<%=startPage+pageBlock%>'">&gt;</div>		
			<%}	
		}
	%>

	</div>
</body>
</html>