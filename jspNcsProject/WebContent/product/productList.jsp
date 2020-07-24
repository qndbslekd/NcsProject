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
		height: 60px; 
		width : 800px;  
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
		height : 300px;
		float: left;
		margin: 20px 20px; 		
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
		overflow: hidden;
		text-align: center;
		height: 50px;
		line-height: 50px;
		color : black;		
	}
	.sub-wrapper{
		height: 70px;
		width : 920px;
		margin: 0 auto;
	}
	.write_button{
		width:100px;
		float:left;
		border: 1px solid #DADBD7;
		padding: 7px 10px 7px 10px;
		background-color: rgb(139, 195, 74);
		color: white;
		cursor: pointer;
		border-radius : 5px;
<<<<<<< HEAD
		
=======
>>>>>>> branch 'develop' of https://github.com/ysk0951/codinnnnng.git
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
</style>
</head>
<%
	//paging
int pageSize = 20;
//최신순

String pageNum = request.getParameter("pageNum");
if (pageNum == null)
	pageNum = "1";

int currPage = Integer.parseInt(pageNum);
int startRow = (currPage - 1) * pageSize + 1;
int endRow = currPage * pageSize;
int count = 0;
int rowNum = 5;

String mode = request.getParameter("mode");
if (mode == null) {
	mode = "num";
}
System.out.println("mode : " + mode);

ProductDAO dao = ProductDAO.getInstance();
List productList = null;

//search Param
String option = "";
String search = "";
option = request.getParameter("option");
search = request.getParameter("search");
System.out.println("option : " + option);
System.out.println("search : " + search);

if (search == null || search.equals("")) {
	//비 검색시
	count = dao.getProductCount();
	if (count > 0) {
		productList = dao.seletAllProduct(startRow, endRow, mode);
	}
} else {
	//검색시
	count = dao.getProductCount(option, search);
	if (count > 0) {
		System.out.println("count" + count);
		productList = dao.seletAllProduct(startRow, endRow, mode, option, search);
	}
}
%>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="product" name="mode"/>
	</jsp:include>
<body>
	<form action="productList.jsp" method="get">
		<table id="search">
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
		<div style="height:50px;">
			<button  class="write_button" onclick="window.location='productInsertForm.jsp'" >제품 등록</button>
		</div>
		<%}%>
		
		<div class="total_recipe">
			<div style="text-align:left; font-size:17px; float: left; width:743px;">총<span style="color:rgb(139, 195, 74); font-size:23px;"><%=count %></span>개의 제품이 있습니다.</div>		
			<div class="sort_button" style="float: left;">
				<%if(search==null||search.equals("")){%>
				<div class="buttn"  <%if(mode.equals("num")){%> id="selected"<%}%> onclick="window.location='productList.jsp?mode=num'">최신순</div>
				<div class="buttn"  <%if(mode.equals("rating")){%> id="selected"<%}%>onclick="window.location='productList.jsp?mode=rating'">추천순</div>
				<%}else{ %>
				<div class="buttn" <%if(mode.equals("num")){%> id="selected"<%}%> onclick="window.location='productList.jsp?mode=num&option=<%=option%>&search=<%=search%>'">최신순</div>
				<div class="buttn"  <%if(mode.equals("rating")){%> id="selected"<%}%> onclick="window.location='productList.jsp?mode=rating&option=<%=option%>&search=<%=search%>'">추천순</div>
				<%} %>
			</div>
		</div>
	</div>
	<div id="recipe-wrapper" style="padding-top: 50px;">
	<%if(productList==null){ %>
		<h1 style="color:black;">등록된 제품이 없습니다.</h1>
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
					<%-- <div class="row">대표성분 :<%
						if(product.getIngredients().contains(",")){
							String[] ingredients = product.getIngredients().split(",");
							int length = ingredients.length;
							System.out.println(length);
							if(length>3){ 
								length = 3;
							}
							for(int j=0;j<length;j++){
								out.print(ingredients[j]+" ");
							}			
						}else{
							out.print(product.getIngredients());
						}
					%></div> --%>
					<div class="row">추천 :<%=product.getRecommend()%></div>
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