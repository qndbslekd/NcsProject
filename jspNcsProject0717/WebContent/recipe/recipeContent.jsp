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
	/* 이거 적용 안됨 */
	#comment{
		border-left:none;      
		border- right:none;		
		border- top:none;		
		border- bottom:none;
	}

</style>
	<script>
		function openReplyForm(nowContentNum, recipeNum, reLevel, reStep, ref){
			
			if(reLevel == 1){ // 답글을 이미 한번 단 경우
				window.alert("답글 작성은 한번만 가능합니다");
				return
			}else{
				var url = 'recipeContentCommentInsertForm.jsp?contentNum='+nowContentNum+'&recipeNum='+recipeNum+'&reLevel='+reLevel+'&reStep='+reStep+'&ref='+ref;
				window.name="recipeContent";
				// 부모창 이름			
				window.open(url, "commentInsertForm", "width=400, height=250, resizeable=no, scrollbars=no");
				// window.open("open할 window", "자식창 이름", "팝업창옵션")
			}
		}
	</script>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	String memName = (String)session.getAttribute("memName");
	int num = Integer.parseInt(request.getParameter("num"));

	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
	
	RecipeDAO recipeDAO = RecipeDAO.getInstance();
	RecipeDTO recipeBoard = new RecipeDTO();

	recipeBoard = recipeDAO.selectRecipeBoard(num);
	int contentNum = recipeBoard.getRecipeStep();
	
	RecipeContentDTO recipeContentdto = new RecipeContentDTO();
	RecipeContentDAO recipeContentdao = RecipeContentDAO.getInstance();
	
	// recipeContentList : 레시피 조리단계  담아준 리스트 -> for문 돌려서 뽑기
	List recipeContentList = recipeContentdao.selectRecipeContent(num);
	
	for(int i = 0; i < recipeContentList.size(); i++){
		recipeContentdto = (RecipeContentDTO)recipeContentList.get(i);
	}
	
	// 조리단계 댓글 dao
	RecipeContentCommentDAO dao = null;

%>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br />
	<h1 align="center">   content </h1>
	
	<table border="1" width=700>
		<tr >
			<td colspan="4">
				<img src="imgs/<%= recipeBoard.getThumbnail() %>" />
			</td>
		</tr>
		<tr>
			<td colspan="4">
				 레시피 제목 : <%= recipeBoard.getRecipeName() %>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				채식주의 타입 : <%= recipeBoard.getVegiType() %>
			</td>
		</tr>
		<tr>
			<td style="background-color:#ffffff; width:25%;">
				<img src="/jnp/recipe/imgs/quantity.png" style="width:40px;"/>
			</td>
			<td style="background-color:#ffffff; width:25%;">
				<img src="/jnp/recipe/imgs/cookingTime.png" style="width:40px;"/>
			</td>
			<td style="background-color:#ffffff; width:25%;">
				<img src="/jnp/recipe/imgs/difficulty.png" style="width:40px;"/>
			</td>
			<td style="background-color:#ffffff; width:25%;">
				<img src="/jnp/recipe/imgs/cal.png" style="width:40px;"/>
			</td>
		</tr>
		<tr>
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
		</tr>
		<tr>
			<td colspan="2">
				평점 : <%= recipeBoard.getRating() %> <button onclick="rating(<%=num%>)">평점 남기기</button>
			</td>
			<td colspan="2">
				<table>
					<tr>
						<td rowspan="2"> <img src="/jnp/save/<%=recipeDAO.selectImgById(recipeBoard.getWriter())%>" style="width:60px; height:60px; border-radius:30px"/> </td>
						<td colspan="2">작성자</td>
					</tr>
					<tr>
						<td><%= recipeBoard.getWriter() %></td>
						<td><button onclick="window.location='recipeSearchList.jsp?writer=<%=recipeBoard.getWriter()%>'">레시피 더 보기</button></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				키워드 : 
				<% if(recipeBoard.getTag()!=null) { %>
				<% 
					String[] tags = recipeDAO.selectTagSplit(num);
					for (int i = 0; i< tags.length; i++) { 
						if(!tags[i].equals("")){	
					%>
						<button><%= tags[i]%></button>
					<%}
					} 
				} else {%>
				키워드 없음
				<%} %>
			
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				재료 탭
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				<%= recipeBoard.getIngredients() %>
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				추천 제품 탭
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				<table>
				<h3> 조리과정</h3>
				<%
				int reLevel = 0;
				int reStep = 0;
				for(int i = 0; i < recipeContentList.size(); i++){
					recipeContentdto = (RecipeContentDTO)recipeContentList.get(i); 
			
					// 조리과정 단계담아줄 변수
					int nowContentNum = recipeContentdto.getStep();
					
					int recipeNum = recipeContentdto.getRecipeNum();
					
					%>				
					<tr>
						<td>단계<%= nowContentNum%>.</td>
						<td><%= recipeContentdto.getContent() %> </td> 
						<td>
							<%-- 댓글쓰기 --%>
							
							<input type="button" value="댓글쓰기" onclick="openReplyForm(<%= nowContentNum %>, <%= recipeNum %>, <%= reLevel %>, <%= reStep %>, <%= 0 %>);" />
								<%-- function 호출할 때 해당 조리단계 관한 변수 보내줌  --%>
						</td>
						<td rowspan="2">사진자리 </td>
					</tr>
					<tr>
					<td colspan="3">
						<jsp:include page="recipeStepComment.jsp">
							<jsp:param value="<%= num%>" name="num"/>
						</jsp:include>				
					</td>
					</tr>
				<%
				} // 조리과정 제일 큰 for문
				%>
				</table>
		<tr>
			<td colspan="4">
			<h2 style="text-align:left">댓글</h2>
				<jsp:include page="recipeComment.jsp">
					<jsp:param value="<%=num %>" name="num"/>				
				</jsp:include>
			</td>			
		</tr>
	</table>
	<br /><br />
	<div align="center">
	<button onclick="window.location='recipeModifyForm.jsp?num=<%=num %>'">수정</button>
	<button onclick="window.location='recipeDeleteForm.jsp?num=<%=num %>'">삭제</button>
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

</script>
</html>