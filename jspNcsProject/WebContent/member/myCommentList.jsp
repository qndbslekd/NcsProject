<%@page import="jspNcsProject.dao.BoardCommentDAO"%>
<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="jspNcsProject.dao.RecipeContentCommentDAO"%>
<%@page import="jspNcsProject.dao.RecipeCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Comment List</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
<style>
	#nonBorder {
		border:0px;
	}
</style>
<%
	request.setCharacterEncoding("UTF-8");
	String memId = (String)session.getAttribute("memId");
	String memName = (String)session.getAttribute("memName");
	int count = 0;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	// 옵션 값 가져오기
	String option = request.getParameter("option");
	
	// 옵션 값이 null 이면 일단 myCommentList 게시글을 기본으로 보여주기
	if(option == null){
		option = "myRecipeCommentList";
	}
	
	// select 옵션에 따라 총 댓글 개수 체크(레시피, 레시피조리단계, 자유게시판, 제품게시판)
		if(option.equals("myRecipeCommentList")){
			RecipeCommentDAO dao = RecipeCommentDAO.getInstance();	
			count = dao.getMyRecipeCommentCount(memId);
		}else if(option.equals("myRecipeStepCommentList")){
			RecipeContentCommentDAO dao = RecipeContentCommentDAO.getInstance();
			count = dao.getMyRecipeStepCommentCount(memId);	
		}else if(option.equals("myFreeboardCommentList")){
			// 자유게시판 댓글
			BoardCommentDAO dao = BoardCommentDAO.getInstance();
			count = dao.getMyFreeBoardCommentCount(memId);
		}else if(option.equals("myProductCommentList")){
			// 제품게시판 댓글 
			ProductDAO dao = ProductDAO.getInstance();
			count = dao.getMyProductCommnetCount(memName);
		}
	if(memId == null){ %>
		<script>
			alert("로그인 후 이용하세요");
			window.location="loginForm.jsp";
		</script>
	<% }else{	
%>
</head>
<body>
<jsp:include page="../header.jsp" flush="false"/>
<br /><br />
<h1 align="center"> 내 댓글 목록 </h1> 
<br />
<form>
	<table id="nonBorder"  style="width:700px;">
		<tr>
			<td colspan="3">
				<div align="right" style="padding-right: 47px">
				<input type="button" value="취소" class="myButton" onclick="window.location='myPage.jsp'" />
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:177px">
				총 댓글 수 : <%= count %>
			</td>
			
			<td>
				<select name="option" style="width:129px">
					<option value="myRecipeCommentList">레시피</option>
					<option value="myRecipeStepCommentList" <%if(option.equals("myRecipeStepCommentList")){%>selected<%} %>>레시피[조리단계]</option>
					<option value="myFreeboardCommentList" <%if(option.equals("myFreeboardCommentList")){%>selected<%} %>>자유게시판</option>
					<option value="myProductCommentList" <%if(option.equals("myProductCommentList")){%>selected<%} %>>제품</option>			
				</select>	
				<input type="submit" value="이동" class="myButton"/>
			</td>
			<td>
				<input type="button" onclick="window.location='myList.jsp'" class="myButton" value="내 글 보기" />
				<input type="button" onclick="window.location='myCommentList.jsp'" class="myButton" value="내 댓글 보기"  style="color:white; background-color:rgb(139, 195, 74);margin-left:-6px;"/>
			</td>
		</tr>
		<tr>
			<td colspan="5" width="804">
				<% if(option.equals("myRecipeCommentList")){%>
					<br />
					<jsp:include page="myRecipeCommentList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
						<jsp:param value="<%= option %>" name="option"/>
		 			</jsp:include>	
				<%}else if(option.equals("myRecipeStepCommentList")){ %>
					<br />
					<jsp:include page="myRecipeStepCommentList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
						<jsp:param value="<%= option %>" name="option"/>
		 			</jsp:include>	
				<%}else if(option.equals("myFreeboardCommentList")){ %>
					<br />
					<jsp:include page="myFreeboardCommentList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
						<jsp:param value="<%= option %>" name="option"/>
	 				</jsp:include>	
				<%}else if(option.equals("myProductCommentList")){ %>
					<br />
					<jsp:include page="myProductCommentList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
						<jsp:param value="<%= option %>" name="option"/>
	 				</jsp:include>	
				<%} %>		 	
			</td>	
		</tr>
	</table>
</form>
</body>
	<%} %>
</html>