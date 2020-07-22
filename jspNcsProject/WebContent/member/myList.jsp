<%@page import="jspNcsProject.dao.FreeBoardDAO"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My List</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
<style>
	#nonBorder {
		border:0px;
	}
</style>
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
	
	int count = 0;
	
	// select 옵션에 따라 총 게시글 체크해주기
	if(option.equals("myRecipeList")){
		RecipeDAO dao = RecipeDAO.getInstance();
		count = dao.getMyRecipeCount(memId);
	}else if(option.equals("myFreeboardList")){
		FreeBoardDAO dao = FreeBoardDAO.getInstance();
		count = dao.getMyFreeBoardCount(memId);	
	}
	
	if(memId==null){ %>
		<script> alert("로그인 후 이용하세요."); window.location="loginForm.jsp";</script>
	<%}else{

%>
<body>
<jsp:include page="../header.jsp" flush="false"/>
<br /><br />
<h1 align="center"> 내 글 목록 </h1> 
<form>
	<table id="nonBorder">
		<tr>
			<td>
				<%-- 여긴 select option 값에 따라서 계속 변할 예정  --%>
				총 게시글 수 : <%= count %>
			</td>
			
			<td>
				<select name="option">
					<option value="myRecipeList">레시피</option>
					<option value="myFreeboardList" <%if(option.equals("myFreeboardList")){%>selected<%} %>>자유게시판</option>
				</select>	
				<input type="submit" value="이동" />
			</td>
			<td>
				<input type="button" onclick="window.location='myList.jsp'" value="내 글 보기" />
				<input type="button" onclick="window.location='myCommentList.jsp'" value="내 댓글 보기" />

			</td>
		</tr>
		<tr>
			<td colspan="5">
				<% if(option.equals("myRecipeList")){%>
					<jsp:include page="myRecipeList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
						<jsp:param value="<%= option %>" name="option"/>
		 			</jsp:include>	
				<%}else if(option.equals("myFreeboardList")){ %>
					<jsp:include page="myFreeboardList.jsp" flush="false" >
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