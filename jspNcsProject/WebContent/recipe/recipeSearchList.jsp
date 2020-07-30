<%@page import="jspNcsProject.dao.RatingDAO"%>
<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@page import="jspNcsProject.dto.TagDTO"%>
<%@page import="jspNcsProject.dao.TagDAO"%>
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
<title>레시피 검색 리스트</title>
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
	.input-box{
		border: 1px solid #999;
	
	}
	
	#searchRecipe-wrapper{
		width : 968px;
		height: auto;
		display: overflow;
		margin: 0 auto;
	}
	#searchRecipe-wrapper .recipe{
	
		width : 850px;
		height : auto;
		overflow: hidden;
		/*border: 1px solid black;*/
		margin: 20px auto;
		cursor:pointer;
		border:2px solid white;
	}
	#searchRecipe-wrapper .recipe:hover {
		border:2px solid #8bc34a;
	}
	
	#searchRecipe-wrapper .thumbnail{
		width: 150px;
		height:146px;
		margin: 1px 1px;
		float: left;
	}
	
	#searchRecipe-wrapper .info{
		width: 692px;
		height: auto;
		overflow: hidden;	
		margin: 1px 1px;
		float: left;			
	}
	
	#searchRecipe-wrapper .info .row {	
		text-align: left;
		height : auto;
		overflow: hidden;
		line-height: 19.2px;
		color : black;	
		padding: 5px 10px;	
	}
	
	.info .title{
		font-size: 18px;
		font-weight: bold;
	}

		
	.sub-wrapper{
		height: 30px;
		width : 850px;
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
	.buttn{		
		float:left;
		border: 1px solid #DADBD7;
		padding: 5px 24px 5px 24px;		
	}
	#selected{

		background-color: #8bc34a;
		color: white;
	}
</style>
<script>
	function question(){
		var win = window.open("recipeListVegiTypeInfo.jsp","채식유형 정보","width=900,height=850,left=500,top=500,scrollbars=yes,")
		
	}
</script>

<%
	request.setCharacterEncoding("utf-8");
	//검색 값 파라미터들 받아오기 :검색값, 검색결과리스트	
	//검색조건 6가지
	

	String name = request.getParameter("name");//요리명
	String ingredients = request.getParameter("ingredients");//재료명
	String vegiType  = request.getParameter("vegiType");//채식 유형
	String difficulty = request.getParameter("difficulty");//난이도
	String writer = request.getParameter("writer");// 칼로리 하한선
	String calMore = request.getParameter("calMore");// 칼로리 하한선
	String calUnder = request.getParameter("calUnder");//칼로리 상한선

	System.out.println("name : "+ name +" writer:"+writer);
	String tag = request.getParameter("tag");
	//where절 쿼리 처리
	String whereQuery="where 1=1";	
	//요리명 검색
	
	RecipeDAO dao = RecipeDAO.getInstance();
	
	if( name!=null && !name.equals("")){
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
	if(vegiType!=null  && !vegiType.equals("")){
		if(!vegiType.equals("total")){
			whereQuery += (" and vegi_type ='"+vegiType+"'");
		}	
	}
	
	//난이도로 검색
	if(difficulty!=null && !difficulty.equals("") ){
		if(!difficulty.equals("전체")){
			whereQuery += (" and difficulty='"+difficulty+"'");
		}
	}

	//칼로리 검색	
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
	if(writer!=null && !writer.equals("")){
		writer = writer.trim();//앞뒤 공백제거
		String writerToId = dao.selectIdByName(writer);
		System.out.println("검색 writer:"+writer+" id변환:"+writerToId);
		whereQuery += (" and writer like '%"+writerToId+"%'");
	}
		
	//태그 검색;
	List tagList = null;
	if( tag!=null && !tag.equals("")){
		String[] tags = tag.split(",");// 구분자로 재료구분
		//태그목록 검색할 where절 쿼리
		String tagWhereQuery = "where 1=1";
			
		for(int i = 0 ; i < tags.length ; i++){//재료명 앞뒤 공백제거
			tags[i] =  tags[i].trim();
		}
		for(int i = 0; i < tags.length ; i++){
			whereQuery += (" and instr(tag,',"+tags[i]+",') != 0");	
			if(i==0){
				tagWhereQuery += (" and tag like'%"+tags[i]+"%'");	
			}else{
				tagWhereQuery += (" or tag like'%"+tags[i]+"%'");	
			}		
		}
		
		//tag테이블에서 검색한 tag와 관련된 태그20개  리스트로 가져오기	
		TagDAO tdao = TagDAO.getInstance();
		tagList = tdao.searchTagList(tagWhereQuery);
	}
		
	//페이지 글 가져오기
	
	int pageSize =20;

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
	System.out.println("검색 쿼리:"+whereQuery);

	//리스트 글수
	int count = 0;
	if(searchRecipeList !=null) count = dao.getCountSearchRecipeList(whereQuery);
	
	
	
%>
</head>
<jsp:include page="../header.jsp" flush="false">
	<jsp:param value="recipe" name="mode"/>
</jsp:include>
<body>
	<form action="recipeSearchList.jsp" name="searchForm" method="post">
		<input type="hidden" name="mode" value="num"/>
			<table id="search">
				<tr><td></td></tr>
				<tr>
					<td class="title">요리명</td>
					<td colspan='7'><input type="text" style="width:620px;" class="input-box" name="name" <%if(name!= null && !name.equals(""))%>value="<%=name%>" /></td>
				</tr>
				<tr>
					<td class="title">재료명</td>
					<td colspan='7'><input type="text" style="width:620px;"class="input-box" name="ingredients" placeholder="재료1,재료2,.." <%if(ingredients!=null && !ingredients.equals(""))%>value="<%=ingredients%>" /></td>
				</tr>
				<tr>
					<td class="title">분류</td>
					<td style="width:100px; text-align:right;">채식유형별</td>
					<td style="width:150px;">
						<select name="vegiType" class="input-box">
						
							<option value="total" <%if(vegiType!=null && vegiType.equals("total")){%>selected<%}%>>전체</option>
							<option value="vegan"<%if(vegiType!=null && vegiType.equals("vegan")){%>selected<%}%>>비건</option>
							<option value="lacto"<%if(vegiType!=null && vegiType.equals("lacto")){%>selected<%}%>>락토</option>
							<option value="ovo"<%if(vegiType!=null && vegiType.equals("ovo")){%>selected<%}%>>오보</option>
							<option value="lacto ovo"<%if(vegiType!=null && vegiType.equals("lacto ovo")){%>selected<%}%>>락토 오보</option>
							<option value="pesco"<%if(vegiType!=null && vegiType.equals("pesco")){%>selected<%}%>>페스코</option>
							<option value="pollo"<%if(vegiType!=null && vegiType.equals("pollo")){%>selected<%}%>>폴로</option>
							<option value="flexitarian"<%if(vegiType!=null && vegiType.equals("flexitarian")){%>selected<%}%>>플렉시테리언</option>	
						</select>
						<img src="./imgs/question.png" width="20px" height="20px" onclick="question()" />
					</td>	
					<td style="width:60px;text-align:right;" >난이도별</td>
					<td style="width:80px;">
						<select name="difficulty" class="input-box">
							<option value="전체" <%if(difficulty!=null && difficulty.equals("전체")){%>selected<%}%>>전체</option>
							<option value="쉬움" <%if(difficulty!=null && difficulty.equals("쉬움")){%>selected<%}%>>쉬움</option>
							<option value="보통" <%if(difficulty!=null && difficulty.equals("보통")){%>selected<%}%>>보통</option>
							<option value="어려움" <%if(difficulty!=null && difficulty.equals("어려움")){%>selected<%}%>>어려움</option>
						</select>
					</td>
					<td style="width:40px; text-align:right;">열량</td>
					<td style="width:100px;">
					<input type="text" name="calMore" style="width:35px;" <%if(calMore !=null && !calMore.equals(""))%> class="input-box"  value="<%=calMore%>" />~
					<input type="text" name="calUnder" style="width:35px;" <%if(calUnder !=null && !calUnder.equals(""))%> class="input-box"  value="<%=calUnder%>"/>
					</td>
				</tr> 
				<tr> 
					<td class="title">작성자</td>
					<td colspan='7'><input type="text" style="width:620px;" class="input-box" name="writer" <%if(writer!= null && !writer.equals(""))%> value="<%=writer%>"/></td>
				</tr>
				<tr>
					<td class="title">태그</td>
					<td colspan='7'><input type="text" name="tag" class="input-box" style="width: 620px;" placeholder="태그명1,태그명2,.." <%if(tag!=null && !tag.equals(""))%> value="<%=tag%>"/></td>
				</tr>
				<tr>
					<td colspan='8'><input type="submit" value="검색"/></td>
				</tr>
			</table>
		</form>
	<div class="tag-wrapper">
		<%if(tagList!=null){
			for(int i = 0 ; i<tagList.size(); i++){
				TagDTO dto = (TagDTO)tagList.get(i); %>	
				<div class="tag" onclick="window.location='recipeSearchList.jsp?tag=<%=dto.getTag()%>'"><%=dto.getTag()%></div>
		<%	}
		} %>
	</div>
	
	<div class="sub-wrapper">
		<% if(session.getAttribute("memId")!= null){ %>
		<div style="height:50px;">
			<button  class="write_button" onclick="window.location='recipeInsertForm.jsp'" >레시피 작성</button>
		</div>
		<%}%>
		<div class="total_recipe">
			<div style="text-align:left; font-size:17px; float: left; width:667px; height:auto; overflow:hidden;">총 <span style="color:rgb(139, 195, 74); font-size:23px;"><%=count %></span>개의 레시피가 있습니다.</div>
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
					<input type="hidden" name="tag" value="<%=tag%>" />
					<input type="hidden" name="mode" value="num" />
					<input type="submit" class="buttn" <%if(mode.equals("num")){%> id="selected"<%}%> class="buttn" value="최신순"/>	
				</form>
		</div>
		<div class="sort_button" style="float: left;">
				<form action="recipeSearchList.jsp">
					<input type="hidden" name="name" value="<%=name%>" />
					<input type="hidden" name="ingredients" value="<%=ingredients%>" />
					<input type="hidden" name="vegiType" value="<%=vegiType%>" />
					<input type="hidden" name="difficulty" value="<%=difficulty%>" />
					<input type="hidden" name="calMore" value="<%=calMore%>" />
					<input type="hidden" name="calUnder" value="<%=calUnder%>" />
					<input type="hidden" name="writer" value="<%=writer%>" />
					<input type="hidden" name="tag" value="<%=tag%>" />
					<input type="hidden" name="mode" value="rating"/>
					<input type="submit" class="buttn" <%if(mode.equals("rating")){%> id="selected"<%}%> class="buttn" value="평점순"/>	
				</form>
		</div>
	</div>
	<div id="searchRecipe-wrapper">
		<%if(searchRecipeList == null){%>
			<h2>검색된 레시피가 없습니다.</h2>
		
		<%}else{
			RatingDAO rdao = RatingDAO.getInstance();
			for(int i = 0 ; i < searchRecipeList.size() ; i++){	
					RecipeDTO recipe  = (RecipeDTO)searchRecipeList.get(i);
					String idToName = dao.selectNameById(recipe.getWriter());
					String[] ingredientes = recipe.getIngredients().split(",");
					String ingre  = "";
					for(int j=0; j< ingredientes.length; j++){
						String[] tmp = ingredientes[j].split(":");
						ingre += tmp[0]+",";
					}
					ingre = ingre.substring(1,ingre.length()-1);
		
					
				
					int rateCount = rdao.getCountRating(recipe.getNum());
		%>
		<div class="recipe" onclick="window.location='recipeContent.jsp?num=<%=recipe.getNum()%>'">
			<div class="thumbnail">
				<img width="150px" height="146px" style="border-radius:5px;" src="/jnp/recipe/imgs/<%=recipe.getThumbnail()%>"/>
			</div>
			<div class="info">
				<div class='row title' ><%=recipe.getRecipeName() %></div>
				<div class='row' style="color:#999;">posted by <%=idToName %></div>
				<div class='row'>평점 : <%=recipe.getRating() %>(<%=rateCount%>)</div>
				<div class='row'>채식유형 : <%=recipe.getVegiType()%> | 난이도 : <%=recipe.getDifficulty()%> 
				| 조리시간 : <%=recipe.getCookingTime()%>분 | 분량 : <%=recipe.getQuantity()%>인분 | 칼로리(1인분/Kcal) : <%=recipe.getCal()%>Kcal		
				</div>
				<div class='row'>재료 : <%=ingre%></div>				
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
				<div class="page" onclick="window.location='recipeSearchList.jsp?pageNum=<%=startPage-pageBlock%>&name=<%=name%>&ingredients=<%=ingredients%>&vegiType=<%=vegiType%>&difficulty=<%=difficulty%>&calMore=<%=calMore%>&calUnder=<%=calUnder%>&writer=<%=writer%>&mode=<%=mode%>&tag=<%=tag%>'">&lt;</div>
			<%}
	
			for(int i = startPage ; i<= endPage; i++ ){%>
				<div class="page" onclick="window.location='recipeSearchList.jsp?pageNum=<%=i%>&name=<%=name%>&ingredients=<%=ingredients%>&vegiType=<%=vegiType%>&difficulty=<%=difficulty%>&calMore=<%=calMore%>&calUnder=<%=calUnder%>&writer=<%=writer%>&mode=<%=mode%>&tag=<%=tag%>'">&nbsp;<%=i %></div>	
			<%}
			
			if(endPage > pageCount){%>
				<div class="page" onclick="window.location='recipeSearchList.jsp?pageNum=<%=startPage+pageBlock%>&name=<%=name%>&ingredients=<%=ingredients%>&vegiType=<%=vegiType%>&difficulty=<%=difficulty%>&calMore=<%=calMore%>&calUnder=<%=calUnder%>&writer=<%=writer%>&mode=<%=mode%>&tag=<%=tag%>'">&gt;</div>		
			<%}		
		}
	%>
	</div>
</body>
</html>