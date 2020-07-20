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
 

</head>
<%
	request.setCharacterEncoding("UTF-8");
	String memId = (String)session.getAttribute("memId");
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
		System.out.println(recipeContentdto.getContent());		
	}
	
	// 조리단계 댓글 dao
	RecipeContentCommentDAO dao = null;

%>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br />
	<h1 align="center">   content </h1>
	
	<table border="1">
		<tr >
			<td colspan="4">
<<<<<<< HEAD
				<img src="imgs/<%= recipeBoard.getThumbnail() %>" style="max-width:800px" />
=======

				<img width="800" src="imgs/<%= recipeBoard.getThumbnail() %>" />

>>>>>>> branch 'develop' of https://github.com/ysk0951/codinnnnng.git
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
			<%-- 작성자는 닉네임으로 --%>
			<td colspan="2">
<<<<<<< HEAD
				<table>
					<tr>
						<td rowspan="2"> <img src="/jnp/save/<%=recipeDAO.selectImgById(recipeBoard.getWriter())%>" style="width:60px; height:60px; border-radius:30px; border:1px solid #000000"/> </td>
						<td colspan="2">작성자</td>
					</tr>
					<tr>
						<td><%= recipeBoard.getWriter() %></td>
						<td><button onclick="window.location='recipeSearchList.jsp?writer=<%=recipeBoard.getWriter()%>'">레시피 더 보기</button></td>
					</tr>
				</table>
=======
				작성자 : <%= recipeDAO.selectNameById(recipeBoard.getWriter()) %>
>>>>>>> branch 'develop' of https://github.com/ysk0951/codinnnnng.git
			</td>
		</tr>
		<tr>
			<td colspan="4">

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
			<td colspan="4">
				<h4>재료</h4> 
			
			<table>
			
				<% 
				HashMap<String,String> ingre = recipeDAO.selectIngredients(num); 
				
				Set keySet = ingre.keySet();
				Iterator ir = keySet.iterator();
				while(ir.hasNext()) {	
					String key = (String) ir.next(); 
					String value = ingre.get(key);%>
				<tr>
					<td> <%= key%> </td>
					<td> <%= value%></td>
				</tr>
					
					
				<%}%>
			</table>
			</td>			
		</tr>
		<tr>
			<td colspan="4" style="align:left;">
				<%--추천 제품 --%>
				<jsp:include page="recipeShowProduct.jsp">
					<jsp:param value="<%=num %>" name="num"/>
				</jsp:include>
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				<jsp:include page="recipeStepComment.jsp" flush="false"/>
		<tr>
			<td colspan="4">
				댓글 탭
			</td>			
		</tr>
	</table>
	<br /><br />
	<div align="center">
	<%
		if(recipeBoard.getWriter().equals(session.getAttribute("memId")) || session.getAttribute("memId").equals("admin")){
			// 관리자거나 레시피 글쓴이면 레시피 자체에 대한 수정 삭제 뜨게 
	%>
			<button onclick="window.location='recipeModifyForm.jsp?num=<%=num %>'">수정</button>
			<button onclick="window.location='recipeDeleteForm.jsp?num=<%=num %>'">삭제</button>
	<%	
		}	
	%>	
		<button onclick="window.location='recipeList.jsp'">목록</button>
	</div>
</body>
</html>