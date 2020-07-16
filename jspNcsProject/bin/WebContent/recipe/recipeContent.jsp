
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
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	//String pageNum = request.getParameter("pageNum");
	int contentNum = Integer.parseInt(request.getParameter("contentNum"));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
	
	RecipeDAO recipeDAO = RecipeDAO.getInstance();
	RecipeDTO recipeBoard = new RecipeDTO();
	//recipeBoard = recipeDAO.selectRecipeBoard(num);
	recipeBoard = recipeDAO.selectRecipeBoard(num);
	
	
	// recipeContentList : 레시피 조리단계  담아준 리스트 -> for문 돌려서 뽑기
	
	//selectRecipeContent
	
	RecipeContentDTO recipeContentdto = new RecipeContentDTO();
	RecipeContentDAO recipeContentdao = RecipeContentDAO.getInstance();
	

	List recipeContentList = recipeContentdao.selectRecipeContent(num);
	
	for(int i = 0; i < recipeContentList.size(); i++){
		recipeContentdto = (RecipeContentDTO)recipeContentList.get(i);
		System.out.println(recipeContentdto.getContent());
		
	}
	
	
	// 조리단계에 대한 댓글 가져오는 메서드 일단 최신 댓글 5개만뽑아주기?
	// contentNum이 조리단계의 num(고유번호)니까 selectRecipeContent 에서 그 값들만 뽑아서 메서드 호출..?*
	RecipeContentCommentDAO dao = null;
	
	//List recipeContentCommentlist = null;
		// contentNum 이 step 번호들(1,2,3이런거 ) num 이 recipeNum 
	//recipeContentCommentlist = dao.selectRecipeContentComment(contentNum, num);
	//recipeContentCommentlist = dao.selectRecipeContentComment(2, 50);
	// 이 메서드 댓글 추가한 후에 확인해보기 
	
%>
<body>
	<br />
	<h1 align="center">   content </h1>
<<<<<<< HEAD
	
	<table border="1">
		<tr >
			<td colspan="4">
				<img src="/jspNcsProject/save/<%= recipeBoard.getThumbnail() %>" />
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
			<td>
				인분 : <%= recipeBoard.getQuantity() %>
			</td>
			<td>
				소요시간 : <%= recipeBoard.getCookingTime() %>
			</td>
			<td>
				난이도 : <%= recipeBoard.getDifficulty() %>
			</td>
			<td>
				칼로리 : <%= recipeBoard.getCal() %>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				평점 관련 
			</td>
			<td colspan="2">
				작성자 : <%= recipeBoard.getWriter() %>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				키워드 탭
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				재료 탭
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

					for(int i = 0; i < recipeContentList.size(); i++){
						recipeContentdto = (RecipeContentDTO)recipeContentList.get(i); %>
						
						<tr>
							<td><%= recipeContentdto.getContent() %>
							<br/>
							<% 
							// recipeContentCommentlist = dao.selectRecipeContentComment(2, 50);
							//List recipeContentCommentlist = null;
							// contentNum 이 step 번호들(1,2,3이런거 ) num 이 recipeNum 
						//recipeContentCommentlist = dao.selectRecipeContentComment(contentNum, num);
							// 이거 메서드 호출 자체를 for문으로 돌려서 여기서 직접 해주기 낼 해라 ...
							// contentNum이 step이니까 그만큼 for문 돌리기 
							List recipeContentCommentlist = null;
							dao = RecipeContentCommentDAO.getInstance();
							System.out.println("ContentNum은 :" + contentNum);
							for(int k = 1; k < contentNum+1; k++){
								System.out.println("k : " + k);
								recipeContentCommentlist = dao.selectRecipeContentComment(k, num);
								RecipeContentCommentDTO dto = (RecipeContentCommentDTO)recipeContentCommentlist.get(k-1);
							%>	
								<%= dto.getContent()  %>  <%= dto.getName() %>  
								<br/>
							<%}%>
							
							
	
							</td>
						</tr>	
					<%}
			
				
				%>
		
				</table>
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				댓글 탭
			</td>			
		</tr>
	</table>
=======
	<button onclick="window.location='recipeModifyForm.jsp?num=<%=num %>'">수정</button>
	<button onclick="window.location='recipeDeleteForm.jsp?num=<%=num %>'">삭제</button>
>>>>>>> branch 'develop' of https://github.com/ysk0951/codinnnnng.git
</body>
</html>