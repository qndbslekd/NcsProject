<%@page import="jspNcsProject.dao.ScrapDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="jspNcsProject.dto.RecipeContentCommentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jspNcsProject.dao.RecipeContentCommentDAO"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dto.RecipeContentDTO"%>
<%@page import="jspNcsProject.dao.RecipeContentDAO"%>
<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe Content</title>
<link rel="stylesheet" href="../resource/team05_style.css">
 
<style>
#nonBorder {
	border:0px;
	background-color:white; 
	color:black;
	padding:10px;
}
#nonBorder tr {
	border:0px;
	background-color:white; 
	color:black;
	padding:10px;
}
#nonBorder td {
	border:0px;
	background-color:white; 
	color:black;
	padding:10px;
}

#greenButton {
	border:0px;
    color:white;
    padding: 8px 15px;
    cursor: pointer;
    width: auto;
    height: auto;
    background: rgb(139, 195, 74);
    border-radius: 10px;
    outline: none;
    margin: 5px auto;
}

</style>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	if(pageNum==null) pageNum="1";
	String memId = (String)session.getAttribute("memId");
	int num = Integer.parseInt(request.getParameter("num"));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
	
	RecipeDAO recipeDAO = RecipeDAO.getInstance();
	RecipeDTO recipeBoard = new RecipeDTO();
	
	ScrapDAO scrapDAO = ScrapDAO.getInstance();
	
	recipeBoard = recipeDAO.selectRecipeBoard(num);
	int contentNum = recipeBoard.getRecipeStep();
	
	RecipeContentDTO recipeContentdto = new RecipeContentDTO();
	RecipeContentDAO recipeContentdao = RecipeContentDAO.getInstance();
	
	// recipeContentList : 레시피 조리단계  담아준 리스트 -> for문 돌려서 뽑기
	List recipeContentList = recipeContentdao.selectRecipeContent(num);
	
	for(int i = 0; i < recipeContentList.size(); i++){
		recipeContentdto = (RecipeContentDTO)recipeContentList.get(i);
		System.out.println(recipeContentdto.getContent());		
	}
	
	// 조리단계 댓글 dao
	RecipeContentCommentDAO dao = null;

%>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br />
	<h1 align="center">   content </h1>
	
	<table id="nonBorder">
		<tr >
			<td colspan="6" >
				<div style="min-width:40px; display:inline-block">&nbsp;</div>
				<img src="imgs/<%= recipeBoard.getThumbnail() %>" style="max-width:600px" />
				<span style="vertical-align:top; top:0px; width:40px;">
				<%if (memId != null) {  if(!memId.equals(recipeBoard.getWriter())) {%>
					<%String empty = ""; if(!scrapDAO.confirmScrap(num, memId)) { empty = "empty"; }%>
					<img src="/jnp/recipe/imgs/<%=empty %>heart.png" width="40px" onclick="scrap(<%=num%>,'<%=memId%>',<%=scrapDAO.confirmScrap(num, memId)%>)" />
				<%} }%>
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				 <h1><%= recipeBoard.getRecipeName() %></h1>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<img src = "/jnp/recipe/imgs/<%=recipeBoard.getVegiType()%>.jpg" style="margin:30px"/>
			</td>
		</tr>
		<tr>
			<td style="width:20%;"></td>
			<td style="width:15%; margin:0px; padding:0px;" >
				<img src="/jnp/recipe/imgs/quantity.png" width="40"/>
			</td>
			<td style="width:15%; margin:0px; padding:0px;">
				<img src="/jnp/recipe/imgs/cookingTime.png" width="40"/>
			</td>
			<td style="width:15%; margin:0px; padding:0px;">
				<img src="/jnp/recipe/imgs/difficulty.png" width="40"/>
			</td>
			<td style="width:15%; margin:0px; padding:0px;">
				<img src="/jnp/recipe/imgs/cal.png" width="40"/>
			</td>
			<td style="width:20%;"></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<%= recipeBoard.getQuantity() %>인분
			</td>
			<td>
				<%= recipeBoard.getCookingTime() %>분
			</td>
			<td>
				<%= recipeBoard.getDifficulty() %>
			</td>
			<td>
				<%= recipeBoard.getCal() %>kcal
			</td>
			<td></td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td colspan="3" style="border-top:2px solid #ccc;border-right:2px solid #ccc;border-bottom:2px solid #ccc;">
				<span> 평점 : </span> 
				<%for(int i = 0; i < (int)recipeBoard.getRating() ; i++) {
					%> <img src = "/jnp/recipe/imgs/star.png" width="15px" style="margin:0px auto; vertical-align:center"/> 
				<%}%>
				<%for(int i = 0; i < 5-(int)recipeBoard.getRating() ; i++) {
					%> <img src = "/jnp/recipe/imgs/emptyStar.png" width="15px"style="margin:0px auto; vertical-align:center"/> 
				<%}%>
									
				
				<%=recipeBoard.getRating() %>
				<% if(memId != null) { %>
				<button id="greenButton" onclick="rating(<%=num%>)">평점 남기기</button>
				<%} %>
			</td>
			<td colspan="3" style="border-top:2px solid #ccc;">
				<table id="nonBorder">
					<tr>
						<td> <img src="/jnp/save/<%=recipeDAO.selectImgById(recipeBoard.getWriter())%>" style="width:60px; height:60px; border-radius:30px; "/> </td>
						<td><h2><%= recipeDAO.selectNameById(recipeBoard.getWriter())%></h2></td>
						<td><button id = "greenButton" onclick="window.location='recipeSearchList.jsp?writer=<%=recipeBoard.getWriter()%>'">레시피 더 보기</button></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="6" style="padding:30px; border-bottom:2px solid #ccc" >

				태그 : 
				<% if(recipeBoard.getTag()!=null) { %>
				<% 
					String[] tags = recipeDAO.selectTagSplit(num);
					for (int i = 0; i< tags.length; i++) { 
						if(!tags[i].equals("")){	
					%>
						<button onclick="window.location='recipeSearchList.jsp?tag=<%=tags[i]%>'"><%= tags[i]%></button>
					<%}
					} 
				} else {%>
				태그 없음
				<%} %>

			</td>			
		</tr>
		<tr>
			<td colspan="6" style="border-bottom:2px solid #ccc">
				<h4>재료</h4> 			
			<table>			
				<% 
				HashMap<String,String> ingre = recipeDAO.selectIngredients(num); 
				
				Set keySet = ingre.keySet();
				Iterator ir = keySet.iterator();
				while(ir.hasNext()) {	
					String key = (String) ir.next(); 
					String value = ingre.get(key);%>
				<tr style="border-bottom:1px #77878F solid">
					<td style="width:200px;border-right:1px #77878F solid"> <%= key%> </td>
					<td style="width:100px"> <%= value%></td>
				</tr>				
				<%}%>
			</table>
			<br/><br/>
			</td>			
		</tr>
		<tr>
			<td colspan="6" style="align:left;">
				<%--추천 제품 --%>
				<jsp:include page="recipeShowProduct.jsp">
					<jsp:param value="<%=num %>" name="num"/>
				</jsp:include>
			</td>			
		</tr>
		<tr>
			<td colspan="6">
				<jsp:include page="recipeStepComment.jsp" flush="false"/>
		<tr>
			<td colspan="6">
			<span style="text-align:left; margin:0px;" ><h1>댓글</h1></span>
				<jsp:include page="recipeComment.jsp">
					<jsp:param value="<%=num %>" name="num"/>
				</jsp:include>
			</td>			
		</tr>
	</table>
	<br /><br />
	<div align="center">
	<%
		if(session.getAttribute("memId")!= null){
			if(recipeBoard.getWriter().equals(session.getAttribute("memId")) || session.getAttribute("memId").equals("admin")){
				// 관리자거나 레시피 글쓴이면 레시피 자체에 대한 수정 삭제 뜨게 
		%>
				<button onclick="window.location='recipeModifyForm.jsp?num=<%=num %>&pageNum=<%=pageNum%>'">수정</button>
				<button onclick="window.location='recipeDeleteForm.jsp?num=<%=num %>&pageNum=<%=pageNum%>'">삭제</button>
		<%	
			} else {
				%> <button onclick="scrap(<%=num%>,'<%=memId%>',<%=scrapDAO.confirmScrap(num, memId)%>)">레시피 찜</button> 
					<button onclick="report('R','<%=num%>','<%=recipeBoard.getWriter()%>')">신고</button>
				<%
			}
		}
	%>	
		<button onclick="window.location='recipeList.jsp?pageNum=<%=pageNum%>'">목록</button>
	</div>
</body>
<script>
	//댓글에 답댓글 달기
	function rating(num) {
		var url = "recipeRatingForm.jsp?num=" + num;
		var name = "평점 남기기";
		var option = "width=400,height=400,left=600,toolbar=no,menubar=no,location=no,scrollbar=no,status=no,resizable=no";
		
		window.open(url,name,option);
	}
	//레시피 찜하기
	function scrap(num, scraper,x) {
		if(x==false) {
			if(confirm("레시피를 찜하시겠습니까?")==true) {
				location.href="recipeScrap.jsp?num="+num+"&scraper="+scraper + "&pageNum=<%=pageNum%>&prePage=recipeContent";
			}
		} else {
			if(confirm("이미 찜한 레시피입니다. \n취소하시겠습니까?")==true) {
				location.href="recipeScrap.jsp?num="+num+"&scraper="+scraper+"&did=true&pageNum=<%=pageNum%>&prePage=recipeContent";
			}
		}
	}
	//신고 기능
	function report(code,commentNum,member) {
		if(confirm("이 글을 신고하시겠습니까?")==true) {
			var offenceCode = code+commentNum;
			location.href= "../member/offenceMember.jsp?offenceUrl="+offenceCode+"&member="+member;
		}		
	}


</script>
</html>