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

<br />
<form>
	<table id="nonBorder" style="width:700px;" >
		<tr>
			<td colspan="3">
				<div align="right" style="padding-right: 43px">
				<input type="button" value="마이페이지로" class="myButton" onclick="window.location='myPage.jsp'" />
				</div>
			</td>
		</tr>
		<tr style="height:30px">
			<td style="width:177px;">
				<%-- 여긴 select option 값에 따라서 계속 변할 예정  --%>
				&nbsp;&nbsp;&nbsp;총 게시글 수 : <%= count %>
			</td>
			
			<td style="width:309px">
				<select name="option" style="width:129px; margin-left: 50px;">
					<option value="myRecipeList">레시피</option>
					<option value="myFreeboardList" <%if(option.equals("myFreeboardList")){%>selected<%} %>>자유게시판</option>
				</select>	
				<input type="submit" class="myButton" value="이동" />
			</td>
			<td style="width:318px">
				<input type="button" onclick="window.location='myList.jsp'" value="내 글 보기" 
				class="myButton" style="margin-left:18px; color:white; background-color:rgb(139, 195, 74);"/>
				<input type="button" onclick="window.location='myCommentList.jsp'" value="내 댓글 보기" class="myButton" style="margin-left:-6px;" />

			</td>
		</tr>
		<tr>
			<td colspan="5" width="804">
				<% if(option.equals("myRecipeList")){%>
					<br />
					<jsp:include page="myRecipeList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
						<jsp:param value="<%= option %>" name="option"/>
		 			</jsp:include>	
				<%}else if(option.equals("myFreeboardList")){ %>
					<br />
					<jsp:include page="myFreeboardList.jsp" flush="false" >
						<jsp:param value="<%= pageNum %>" name="pageNum"/>
						<jsp:param value="<%= option %>" name="option"/>
		 			</jsp:include>	
				<%} %>
			</td>	
		</tr>

	</table>
</form>
<br/>
<jsp:include page="../footer.jsp" flush="false"/>
</body>
<%} %>
</html>