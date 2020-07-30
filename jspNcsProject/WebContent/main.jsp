<%@page import="jspNcsProject.dao.TagDAO"%>
<%@page import="jspNcsProject.dto.ProductDTO"%>
<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="jspNcsProject.dao.RatingDAO"%>
<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dto.MemberDTO"%>
<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Begin Vegan</title>
	<link href="resource/team05_style.css" rel="stylesheet" type="text/css">
</head> 
<style>
	.mainTable * {
		margin-top:5px;
		margin-bottom:5px;
	} 
	
	.row {
		overflow:hidden;
		width:198px;
		height:auto;
		
	}
	.recipe {
		cursor:pointer;
	}
</style>
<%
String memId = (String) session.getAttribute("memId");
MemberDAO Mdao = MemberDAO.getInstance();
RecipeDAO Rdao = RecipeDAO.getInstance();
ProductDAO Pdao = ProductDAO.getInstance();
TagDAO Tdao = TagDAO.getInstance();
RatingDAO Rtdao = RatingDAO.getInstance();


MemberDTO loginMember = null;
if(memId != null) {	//로그인 한 상태면 로그인 정보 가져오기
	loginMember = Mdao.modifyData(memId);
}

%>
<body>
<jsp:include page="header.jsp" flush="false" />
<br/>
<table>
	<tr>
		<td>태그 순위 : </td>
		<%
		List tagslist = Tdao.selectTagsOrderByTaggedTimes();
		int x = 5;
		if(tagslist.size() < x) {
			x = tagslist.size();
		}
		for (int i = 0; i < x; i++) { %>
			<td><button class="lineButton" style="margin-left:10px; margin-right:10px;" onclick = "window.location = 'recipe/recipeSearchList.jsp?tag=<%=tagslist.get(i)%>'"><%=i+1 %>. <%=tagslist.get(i) %> </button></td>
		<%} %>
	</tr>
</table>
<br/>
<br/>
<table class="mainTable">

	<tr>
		<td colspan="3" style="text-align:left; vertical-align:middle"><img src="resource/leaf.png" style="width:25px; margin:0; padding:0; bottom:0;"/> <span style="font-size:1.3em">추천 레시피</span></td>
		
	<%if (memId == null || loginMember.getVegi_type().equals("none")) {	//로그인 안한 상태 혹은 비채식주의%>
		
		
		<td style="text-align:right;"> <a href="/jnp/recipe/recipeList.jsp?mode=num" style="color:black;">+more</a></td>
		</tr>
		<tr>
			<td colspan="4" style="text-align:left; padding-left:50px; vertical-align:middle;" ><img src="/jnp/resource/greenstar.png" style="height:15px; padding:0; margin:0;	"/> <span style="font-size:1.2em;">  최신순 </span> </td>
		</tr>
		<tr>
			<% 
			int z = 4;
			List list = Rdao.seletAllReceipe(1, 4, "num"); 
			if(list == null) {
				z = 0;
			} else if (list.size() < z) z = list.size();
			
			for( int i = 0; i < z; i++) {
				RecipeDTO dto = (RecipeDTO) list.get(i);
				int rateCount = Rtdao.getCountRating(dto.getNum());

				 %>
					<td style="padding:15px;vertical-align:top;"> 
						<div class="recipe" onclick="window.location='/jnp/recipe/recipeContent.jsp?num=<%=dto.getNum()%>'">
							<div class="thumbnail">
								<img width="198px" height="198px" style="border-radius:5px" src="/jnp/recipe/imgs/<%=dto.getThumbnail()%>"/>
							</div>
							<div class="info">
								<div class="row" style="font-size:17px"><%=dto.getRecipeName()%></div>
								<div class="row" style="color:#999; font-weight:100;">posted by <%=Rdao.selectNameById(dto.getWriter()) %></div>
								<div class="row"style="font-size:14px">
									<%
									//평점 별 그림 넣기
									for(int j = 0; j < (int)dto.getRating() ; j++) {
										%> <img src = "/jnp/recipe/imgs/star.png" width="12px" style="margin:0px auto; vertical-align:center"/> 
									<%}%>
									<%for(int j = 0; j < 5-(int)dto.getRating() ; j++) {
										%> <img src = "/jnp/recipe/imgs/emptyStar.png" width="12px"style="margin:0px auto; vertical-align:center"/> 
									<%}%>
								<%=dto.getRating()%> (<%=rateCount%>)</div>			
							</div>			
						</div>
					</td>
				<%} 
				for(int i = 0; i < 4-z; i++) {%>
				<td width="200" height="250" style="padding:13px;"></td>
			<%} %>
			</tr>
		<%} else {	//채식주의자 %>
			
			<td style="text-align:right;"> <a href="/jnp/recipe/recipeSearchList.jsp?vegiType=<%=loginMember.getVegi_type()%>"style="color:black;">+more</a></td>
			</tr>
			<tr>
				<td colspan="4" style="text-align:left; padding-left:50px; vertical-align:middle;" ><img src="/jnp/resource/greenstar.png" style="height:15px; padding:0; margin:0;	"/> <span style="font-size:1.2em;"> 나의 채식타입 : <%=loginMember.getVegi_type()%> </span> </td>
			</tr>
			<tr>
				<% 
				String whereQuery = "where vegi_Type = '" + loginMember.getVegi_type() + "'";
				List list = Rdao.searchRecipeList(1, 4, whereQuery, "num");
				int y = 4;
				if(list == null) {
					y = 0;
				} else if (list.size() < y) {
					y = list.size();
				}
				for( int i = 0; i < y; i++) {
					RecipeDTO dto = (RecipeDTO) list.get(i); 
					int rateCount = Rtdao.getCountRating(dto.getNum());
					
					%>
						<td style="padding:15px;vertical-align:top;"> 
							<div class="recipe" onclick="window.location='/jnp/recipe/recipeContent.jsp?num=<%=dto.getNum()%>'">
								<div class="thumbnail">
									<img width="198px" height="198px" style="border-radius:5px" src="/jnp/recipe/imgs/<%=dto.getThumbnail()%>"/>
								</div>
								<div class="info">
									<div class="row" style="font-size:17px"><%=dto.getRecipeName()%></div>
									<div class="row" style="color:#999; font-weight:100;">posted by <%=Rdao.selectNameById(dto.getWriter()) %></div>
									<div class="row"style="font-size:14px">
										<%
										//평점 별 그림 넣기
										for(int j = 0; j < (int)dto.getRating() ; j++) {
											%> <img src = "/jnp/recipe/imgs/star.png" width="12px" style="margin:0px auto; vertical-align:center"/> 
										<%}%>
										<%for(int j = 0; j < 5-(int)dto.getRating() ; j++) {
											%> <img src = "/jnp/recipe/imgs/emptyStar.png" width="12px"style="margin:0px auto; vertical-align:center"/> 
										<%}%>
									<%=dto.getRating()%> (<%=rateCount%>)</div>			
								</div>			
							</div>
						</td>
				<%}
				for(int i = 0; i < 4-y; i++) {%>
				<td width="200" height="250" style="padding:13px;"></td>
				<%} 
		}
		%>
	</tr>
</table>
<%--------------------------------------------여기까지 추천레시피 -------------------------------------%>
<br/><br/><br/>
<table class="mainTable">
	<tr>
		<td colspan="3" style="text-align:left; vertical-align:middle"><img src="resource/leaf.png" style="width:25px; margin:0; padding:0; bottom:0;"/> <span style="font-size:1.3em">추천 제품</span></td>
		<td style="text-align:right;">
			<a href="/jnp/product/productList.jsp" style="color:black;">+more</a>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="text-align:left; padding-left:50px; vertical-align:middle;" ><img src="/jnp/resource/greenstar.png" style="height:15px; padding:0; margin:0;	"/> <span style="font-size:1.2em;">  최신순 </span> </td>
	</tr>
	<tr>
		<%List productList = Pdao.seletAllProduct(1, 4, "num");
		if(productList == null) {
			%> <td>제품이 없습니다</td> <%
		} else {
			int y = 4;
			if(productList.size() <y) {
				y = productList.size();
			}
			for( int i = 0; i < y; i++) {
				ProductDTO dto = (ProductDTO) productList.get(i); %>
					<td style="padding:15px;vertical-align:top;"> 
						<div class="recipe" onclick="window.location='/jnp/product/productContent.jsp?num=<%=dto.getNum()%>'">
							<div class="thumbnail">
								<img width="198px" height="198px" style="border-radius:5px" src="/jnp/product/imgs/<%=dto.getProduct_img()%>"/>
							</div>
							<div class="info">
								<div class="row" style="font-size:17px"><%=dto.getName()%></div>
								<div class="row"style="font-size:14px">추천 수 : <%=dto.getRecommend()%></div>			
							</div>			
						</div>
					</td>
				<%}
				for(int i = 0; i < 4-y; i++) {%>
				<td width="200" height="250" style="padding:13px;"></td>
				<%} 
	} %>
			
	</tr>
</table>

<%-------------------------------------여기까지 추천 제품 ------------------------------%>

<br/>
<br/>

<%
//찜한 레시피가 있을 때 : 가장 많이 찜한 태그로 평점순으로 출력
//찜한 레시피가 없을 때 : 전체 레시피 중 평점순으로 출력

String mostTag = Mdao.selectMostTag(memId);

if(mostTag == null) { //찜한 레시피가 없을 때 : 전체 레시피 중 평점순으로 출력
%>
<table class="mainTable">
	<tr>
	<td colspan="3" style="text-align:left; vertical-align:middle"><img src="resource/leaf.png" style="width:25px; margin:0; padding:0; bottom:0;"/> <span style="font-size:1.3em">평점 높은 레시피</span></td>
	<td style="text-align:right;"> <a href="/jnp/recipe/recipeList.jsp?mode=rating" style="color:black;">+more</a></td>
		
		</tr>
		<tr>
			<td colspan="4" style="text-align:left; padding-left:50px; vertical-align:middle;" ><img src="/jnp/resource/greenstar.png" style="height:15px; padding:0; margin:0;	"/> <span style="font-size:1.2em;">  평점순 </span> </td>
		</tr>
		<tr>
			<% 
			List list = Rdao.seletAllReceipe(1, 4, "rating"); 
			int yy = 4;
			if(list != null) {
				if(list.size() < yy) yy = list.size();
				for( int i = 0; i < yy; i++) {
					RecipeDTO dto = (RecipeDTO) list.get(i);
					int rateCount = Rtdao.getCountRating(dto.getNum()); %>
					
						<td style="padding:15px;vertical-align:top;"> 
							<div class="recipe" onclick="window.location='/jnp/recipe/recipeContent.jsp?num=<%=dto.getNum()%>'">
								<div class="thumbnail">
									<img width="198px" height="198px" style="border-radius:5px" src="/jnp/recipe/imgs/<%=dto.getThumbnail()%>"/>
								</div>
								<div class="info">
									<div class="row" style="font-size:17px;"><%=dto.getRecipeName()%></div>
									<div class="row" style="color:#999; font-weight:100;">posted by <%=Rdao.selectNameById(dto.getWriter()) %></div>
									<div class="row"style="font-size:14px">
									
										<%
										//평점 별 그림 넣기
										for(int j = 0; j < (int)dto.getRating() ; j++) {
											%> <img src = "/jnp/recipe/imgs/star.png" width="12px" style="margin:0px auto; vertical-align:center"/> 
										<%}%>
										<%for(int j = 0; j < 5-(int)dto.getRating() ; j++) {
											%> <img src = "/jnp/recipe/imgs/emptyStar.png" width="12px"style="margin:0px auto; vertical-align:center"/> 
										<%}%>
									<%=dto.getRating()%> (<%=rateCount%>)</div>			
								</div>			
							</div>
						</td>
				<%}
				for(int i = 0; i < 4-yy; i++) {%>
				<td width="200" height="250" style="padding:13px;"></td>
				<%} } %>
			</tr>
</table>

<%} else { //찜한 레시피가 있을 때 : 가장 많이 찜한 태그로 평점순으로 출력 %>
<table class="mainTable">
	<tr>
		<td colspan="3" style="text-align:left; vertical-align:middle"><img src="resource/leaf.png" style="width:25px; margin:0; padding:0; bottom:0;"/> <span style="font-size:1.3em">가장 많이 찜한 태그 : <%=mostTag %> </span></td>
		<td style="text-align:right;"> <a href="/jnp/recipe/recipeSearchList.jsp?tag=<%=mostTag %>&mode=rating" style="color:black;">+more</a></td>
	</tr>
	<tr>
		<td colspan="4" style="text-align:left; padding-left:50px; vertical-align:middle;" ><img src="/jnp/resource/greenstar.png" style="height:15px; padding:0; margin:0;	"/> <span style="font-size:1.2em;">  평점순 </span> </td>
	</tr>
	<tr>
			<% 
			String whereQuery = "where tag like'%" + mostTag + "%'";
			List list = Rdao.searchRecipeList(1, 4, whereQuery, "rating");
			int y = 4;
			if(list == null) {
				y = 0;
			} else if (list.size() < y) {
				y = list.size();
			}
				for( int i = 0; i < y; i++) {
					RecipeDTO dto = (RecipeDTO) list.get(i); 
					int rateCount = Rtdao.getCountRating(dto.getNum()); %>
					
						<td style="padding:15px;vertical-align:top;"> 
							<div class="recipe" onclick="window.location='/jnp/recipe/recipeContent.jsp?num=<%=dto.getNum()%>'">
								<div class="thumbnail">
									<img width="198px" height="198px" style="border-radius:5px" src="/jnp/recipe/imgs/<%=dto.getThumbnail()%>"/>
								</div>
								<div class="info">
									<div class="row" style="font-size:17px"><%=dto.getRecipeName()%></div>
									<div class="row" style="color:#999; font-weight:100;">posted by <%=Rdao.selectNameById(dto.getWriter()) %></div>
									<div class="row"style="font-size:14px">
										<%
										//평점 별 그림 넣기
										for(int j = 0; j < (int)dto.getRating() ; j++) {
											%> <img src = "/jnp/recipe/imgs/star.png" width="12px" style="margin:0px auto; vertical-align:center"/> 
										<%}%>
										<%for(int j = 0; j < 5-(int)dto.getRating() ; j++) {
											%> <img src = "/jnp/recipe/imgs/emptyStar.png" width="12px"style="margin:0px auto; vertical-align:center"/> 
										<%}%>
									<%=dto.getRating()%> (<%=rateCount%>)</div>			
								</div>			
							</div>
						</td>
				<%}
				for(int i = 0; i < 4-y; i++) {%>
				<td width="200" height="250" style="padding:13px;"></td>
				<%} %>
			</tr>

</table>
<%} %>
</body>
</html>  