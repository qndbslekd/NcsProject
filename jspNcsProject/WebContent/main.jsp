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
	<title>비긴 비건</title>
	<link href="resource/team05_style.css" rel="stylesheet" type="text/css">
</head> 
<%
String memId = (String) session.getAttribute("memId");
MemberDAO Mdao = MemberDAO.getInstance();
RecipeDAO Rdao = RecipeDAO.getInstance();
ProductDAO Pdao = ProductDAO.getInstance();
TagDAO Tdao = TagDAO.getInstance();


MemberDTO loginMember = null;
if(memId != null) {	//로그인 한 상태면 로그인 정보 가져오기
	loginMember = Mdao.modifyData(memId);
}

%>
<body>
<jsp:include page="header.jsp" flush="false" />
<br/><br/><br/>
<table>
	<tr>
		<td>키워드 순위</td>
		<%
		List tagslist = Tdao.selectTagsOrderByTaggedTimes();
		int x = 10;
		if(tagslist.size() < x) {
			x = tagslist.size();
		}
		for (int i = 0; i < x; i++) { %>
			<td><%=i+1 %>.<button onclick = "window.location = 'recipe/recipeSearchList.jsp?tag=<%=tagslist.get(i)%>'"><%=tagslist.get(i) %></button></td>
		<%} %>
	</tr>
</table>
<br/>
<br/>
<table>

	<tr>
		<td colspan="4"> 추천 레시피</td>
		
	<%if (memId == null || loginMember.getVegi_type().equals("비채식주의자")) {	//로그인 안한 상태 혹은 비채식주의%>
		
		
		<td> <a href="/jnp/recipe/recipeList.jsp?mode=num">+more</a></td>
		</tr>
		<tr>
			<td colspan="5"> 최신순 </td>
		</tr>
		<tr>
			<% 
			List list = Rdao.seletAllReceipe(1, 5, "num"); 
			for( int i = 0; i < 5; i++) {
				RecipeDTO dto = (RecipeDTO) list.get(i);
				if (dto != null) { %>
					<td> 
						<div class="recipe" onclick="window.location='recipe/recipeContent.jsp?num=<%=dto.getNum()%>'">
							<div class="thumbnail">
								<img width="198px" height="198px" src="/jnp/recipe/imgs/<%=dto.getThumbnail()%>"/>
							</div>
							<div class="info">
								<div class="row"><%=dto.getRecipeName()%></div>
								<div class="row">posted by <%=dto.getWriter() %></div>
								<div class="row"><%=dto.getRating()%>(<%=RatingDAO.getInstance().getCountRating(dto.getNum())%>개의 평가)</div>			
							</div>			
						</div>
					</td>
				<%} else { //빈칸넣기 %>
					<td></td>
				<%}
			}
			
		} else {	//채식주의자 %>
			
			

			
			<td> <a href="/jnp/recipe/recipeSearchList.jsp?vegiType=<%=loginMember.getVegi_type()%>">+more</a></td>
			</tr>
			<tr>
				<td colspan="5"> <%=loginMember.getVegi_type()%> </td>
			</tr>
			<tr>
				<% 
				String whereQuery = "where vegi_Type = '" + loginMember.getVegi_type() + "'";
				List list = Rdao.searchRecipeList(1, 5, whereQuery, "num");
				
				if(list != null) {
				for( int i = 0; i < list.size(); i++) {
					RecipeDTO dto = (RecipeDTO) list.get(i); %>
						<td> 
							<div onclick="window.location='recipe/recipeContent.jsp?num=<%=dto.getNum()%>'">
								<div>
									<img width="198px" height="198px" src="/jnp/recipe/imgs/<%=dto.getThumbnail()%>"/>
								</div>
								<div class="info">
									<div><%=dto.getRecipeName()%></div>
									<div>posted by <%=dto.getWriter() %></div>
									<div><%=dto.getRating()%>(<%=RatingDAO.getInstance().getCountRating(dto.getNum())%>개의 평가)</div>			
								</div>			
							</div>
						</td>
				<%}
				for(int i = 0; i < 5-list.size(); i++) {%>
						<td width="200"></div></td>
				<%}
				}
		}
		%>
	</tr>
</table>
<%--------------------------------------------여기까지 추천레시피 -------------------------------------%>
<br/><br/><br/>
<table>
	<tr>
		<td colspan="4">
			추천 제품
		</td>
		<td>
			<a href="product/productList.jsp">+more</a>
		</td>
	</tr>
	<tr>
		<td colspan="5">최신순</td>
	</tr>
	<tr>
		<%List productList = Pdao.seletAllProduct(1, 5, "num");
		if(productList == null) {
			%> <td>제품이 없습니다</td> <%
		} else {
			for( int i = 0; i < productList.size(); i++) {
				ProductDTO dto = (ProductDTO) productList.get(i); %>
					<td> 
						<div onclick="window.location='product/productContent.jsp?num=<%=dto.getNum()%>'">
							<div>
								<img width="198px" height="198px" src="/jnp/recipe/imgs/<%=dto.getProduct_img()%>"/>
							</div>
							<div class="info">
								<div><%=dto.getName()%></div>
								<div>추천 수 : <%=dto.getRecommend()%></div>			
							</div>			
						</div>
					</td>
			<%}
			
		}
		%>
	</tr>
</table>

<%-------------------------------------여기까지 추천 제품 ------------------------------%>

<br/>
<br/>
<table>
	<tr>
	<td> <a href="/jnp/recipe/recipeList.jsp?mode=num">+more</a></td>
		</tr>
		<tr>
			<td colspan="5"> 최신순 </td>
		</tr>
		<tr>
			<% 
			List list = Rdao.seletAllReceipe(1, 5, "num"); 
			for( int i = 0; i < 5; i++) {
				RecipeDTO dto = (RecipeDTO) list.get(i);
				if (dto != null) { %>
					<td> 
						<div class="recipe" onclick="window.location='recipe/recipeContent.jsp?num=<%=dto.getNum()%>'">
							<div class="thumbnail">
								<img width="198px" height="198px" src="/jnp/recipe/imgs/<%=dto.getThumbnail()%>"/>
							</div>
							<div class="info">
								<div class="row"><%=dto.getRecipeName()%></div>
								<div class="row">posted by <%=dto.getWriter() %></div>
								<div class="row"><%=dto.getRating()%>(<%=RatingDAO.getInstance().getCountRating(dto.getNum())%>개의 평가)</div>			
							</div>			
						</div>
					</td>
				<%} else { //빈칸넣기 %>
					<td></td>
				<%}
			} %>
			</tr>
</table>
</body>
</html>  