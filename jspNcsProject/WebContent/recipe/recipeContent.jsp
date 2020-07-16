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
																				
	String memId = (String) session.getAttribute("memId");
																				
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");																			
																				
	RecipeDAO recipeDAO = RecipeDAO.getInstance();																			
	RecipeDTO recipeBoard = new RecipeDTO();																			
																				
	recipeBoard = recipeDAO.selectRecipeBoard(num);																			
	int contentNum = recipeBoard.getRecipeStep();																			
																				
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
<jsp:include page="../header.jsp"/>
																		
	<br />																			
	<h1 align="center">   content </h1>																			
																				
	<table border="1">																			
		<tr >																		
			<td colspan="4">																	
				<img src="/jspNcsProject/recipe/imgs/<%= recipeBoard.getThumbnail() %>" />																
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
				평점 : <%= recipeBoard.getRating() %> 
				<%if (session.getAttribute("memId")!=null) { %>
					<button onclick="rating()">평점 남기기</button>																
				<%} %>
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
																				
							List recipeContentCommentlist = null;													
							dao = RecipeContentCommentDAO.getInstance();													
																				
							System.out.println("ContentNum은 :" + contentNum);													
							recipeContentCommentlist = dao.selectRecipeContentComment(i+1, num);													
								if(recipeContentCommentlist != null){												
																				
																				
																				
								for(int k = 1; k < recipeContentCommentlist.size(); k++){												
																				
									RecipeContentCommentDTO dto = (RecipeContentCommentDTO)recipeContentCommentlist.get(k-1);											
								%>												
									<%= dto.getContent()  %>  <%= dto.getName() %>											
									<br/>											
								<%}												
								} %>												
																				
																				
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
																			
	<%if (memId.equals(recipeBoard.getWriter()) || memId.equals("admin")) { %>																				
		<button onclick="window.location='recipeModifyForm.jsp?num=<%=num %>'">수정</button>																			
		<button onclick="window.location='recipeDeleteForm.jsp?num=<%=num %>'">삭제</button>																			
	<%} %>																			
</body>		

<script>
	function rating() {
		var url = "recipeRatingForm.jsp?num=<%=num%>";
		var name = "평점 남기기";
		var option = "width=400,height=400,left=600,toolbar=no,menubar=no,location=no,scrollbar=no,status=no,resizable=no";
		
		window.open(url,name,option);
	}
	
</script>																		
</html>																				
