<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My List</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String memId = (String)session.getAttribute("memId");
		
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	// 내 글보기 - recipe or freeboard select값 가져오기 
	String option = request.getParameter("option");
	
	// 옵션 값이 null 이면 일단 recipe 게시글을 기본으로 보여주기
	if(option == null){
		option = "myRecipeList";
	}
	
	// 총 레시피 수 꺼내주기
	RecipeDAO dao = RecipeDAO.getInstance();
	int count = dao.getMyRecipeCount(memId);

%>
<body>
<jsp:include page="../header.jsp" flush="false"/>
<br /><br />
<h1 align="center"> 내 글 목록 </h1> 
<form>
	<table>
		<tr>
			<td>
				총 레시피 수 <%= count %>
			</td>
			
			<td>
				<select name="option">
					<option value="myRecipeList">레시피</option>
					<option value="myFreeboardList">자유게시판</option>
				</select>	
				<input type="submit" value="이동" />
			</td>
			<td>
				<button>내 글 보기</button>
				<button onclick="location.href='myRecipeCommentList.jsp'">내 댓글 보기</button>
			</td>
		</tr>
		<tr>
			<td colspan="5">
				<% if(option.equals("myRecipeList")){%>
					<jsp:include page="myRecipeList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
		 			</jsp:include>	
				<%}else if(option.equals("myFreeboardList")){ %>
					<jsp:include page="myRecipeList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
		 			</jsp:include>	
				<%} %>
		 				
	
			</td>	
		</tr>
	</table>
</form>

</body>

</html>