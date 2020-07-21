<%@page import="jspNcsProject.dao.RecipeCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Comment List</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
<%
	request.setCharacterEncoding("UTF-8");
	String memId = (String)session.getAttribute("memId");
	int count = 0;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	// 내 글보기 - recipe or freeboard select값 가져오기 
	String option = request.getParameter("option");
	
	// 옵션 값이 null 이면 일단 myCommentList 게시글을 기본으로 보여주기
	if(option == null){
		option = "myRecipeCommentList";
	}
	
	// 총 댓글 수 꺼내주기(일단은 myCommentList 일 때만 )
	RecipeCommentDAO dao = RecipeCommentDAO.getInstance();	
	count = dao.getMyRecipeCommentCount(memId);
%>
</head>
<body>
<jsp:include page="../header.jsp" flush="false"/>
<br /><br />
<h1 align="center"> 내 댓글 목록 </h1> 
<form>
	<table>
		<tr>
			<td>
				총 댓글 수 <%= count %>
			</td>
			
			<td>
				<select name="option">
					<option value="myRecipeCommentList">레시피</option>
					<option value="myRecipeStepComment">레시피[조리단계]</option>
					<option value="myFreeboardCommentList">자유게시판</option>
					<option value="myProductCommentList">제품</option>
					
				
				</select>	
				<input type="submit" value="이동" />
			</td>
			<td>
				<button>내 글 보기</button>
				<button>내 댓글 보기</button>
			</td>
		</tr>
		<tr>
			<td colspan="5">
				<% if(option.equals("myRecipeCommentList")){%>
					<jsp:include page="myRecipeCommentList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
		 			</jsp:include>	
				<%}else if(option.equals("myRecipeStepComment")){ %>
					<jsp:include page="myRecipeStepComment.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
		 			</jsp:include>	
				<%}else if(option.equals("myFreeboardCommentList")){ %>
					<jsp:include page="myFreeboardCommentList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
	 				</jsp:include>	
				<%}else if(option.equals("myProductCommentList")){ %>
					<jsp:include page="myProductCommentList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
	 				</jsp:include>	
				<%} %>
		 				
	
			</td>	
		</tr>
	</table>
</form>
</body>
</html>