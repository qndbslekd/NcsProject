<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@page import="jspNcsProject.dto.RecipeCommentDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dao.RecipeCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 보기</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>

</head>


<body>
<%
	request.setCharacterEncoding("utf-8");

	String memId = (String) session.getAttribute("memId");
	
	RecipeDAO rDAO = RecipeDAO.getInstance();
	
	int num = Integer.parseInt(request.getParameter("num"));
	
	//댓글 리스트 가져오기
	RecipeCommentDAO rCDAO = RecipeCommentDAO.getInstance();
	List RecipeCommentList = rCDAO.selectRecipeCommentAll(num);
	
	if(RecipeCommentList==null) { //댓글이 하나도 없으면%>
		<span style="margin:50px"><h2>댓글이 없습니다</h2></span>
		<hr>
	<%} else { //댓글이 있으면
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int x = 4;
//	if(RecipeCommentList.size() < x) {
		x = RecipeCommentList.size();
				
//	}
	for(int i = 0; i < x; i++) {
		//RecipeCommentDTO dto = (RecipeCommentDTO) RecipeCommentList.get(i);
		RecipeCommentDTO dto = (RecipeCommentDTO) RecipeCommentList.get(i);
		//test
%>
	<hr size="1px" width="700px" color="#ccc" style="margin-top:3px; margin-bottom:0px;">
	<table class="nonBorder" style="width:700px;"  >
		<tr>
			<%if (dto.getReLevel()>0) {%><td rowspan="2" width="20px;" style="vertical-align:top;border:0px;"><img src="/jnp/recipe/imgs/replyImg.png" width="10px"/></td><%} %>
			<td rowspan="2" style="width:80px; height:0px; vertical-align:top;border:0px; padding:0">
				<div style="position: absolute;margin:auto;width:80px; height:80px; text-align:center; vertical-align:middle;">
					<div style="width:60px; height:60px; position: relative; margin:auto; display:inline-block; top:10px;">
						<img src="/jnp/save/<%=rDAO.selectImgById(dto.getName())%>" style="width:60px; height:60px; border-radius:30px;"/>
					</div>
				</div>
				<%if(dto.getName().equals(rDAO.selectRecipeBoard(num).getWriter())) {
					%>
				<div style="position: absolute; display:block;">
					<div style="position: relative; width:80px; height:80px; text-align:left;">
						<img src="/jnp/recipe/imgs/chef.png" style="width:25px; height:25px;left:0px; top:0px; transform:rotate(350deg)"/>
					</div>
				</div>
				<%} %>
			</td>
			<td style="text-align:left; border:0px;padding-bottom:2px;">
			<Strong> <%= rDAO.selectNameById(dto.getName()) %> </Strong>
			<%if (memId != null) { %>
					<%if (dto.getName().equals(memId) || memId.equals("admin")) {//내가 쓴 댓글(혹은 관리자)이면 수정삭제답글버튼%>
						<button class="grayButton" style="background-color:rgb(139, 195, 74); color:white" onclick="reply(<%=dto.getNum()%>)" >&#x1F4AC;답글</button> 
						<button class="grayButton" onclick="modifyComment(<%=dto.getNum()%>)">수정</button>
						<button class="grayButton" onclick="deleteComment(<%=dto.getNum()%>)">삭제</button>
					<%} else { //아니면 답글, 신고버튼%> &nbsp;&nbsp;
						<button class="grayButton" style="background-color:rgb(139, 195, 74); color:white" onclick="reply(<%=dto.getNum()%>)" >&#x1F4AC;답글</button> 
						<button class="grayButton" onclick="report('RC','<%=dto.getNum()%>','<%=dto.getName()%>')" >&#128680;신고</button> 
					<%} %>
			<%} %>
			</td>
			<td style="text-align:right; border:0px;"><%=sdf.format(dto.getReg()) %></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:left;border:0px;padding-top:5px;">
				<%if (dto.getReceiver() !=null) { //만약 대댓글이라면 원본댓글 작성자 이름 넣어주기%>
					<strong><%= rDAO.selectNameById(dto.getReceiver()) %>&nbsp;&nbsp;</strong>
				<%}%>
				<%=dto.getContent() %>
			</td>
		</tr>
	</table>
<%}%>
	<hr size="1px" width="700px" color="#ccc" style="margin-top:3px">
<hr>
<%--
<div align=right >
	<button onclick="commentList()">댓글 더보기</button>
</div>
 --%>
<%}%>
		
		<%--댓글 작성 폼--%>
		<% if(memId==null) {%>
			<h4>댓글을 작성하시려면 로그인하십시오.</h4>
		<%} else { %>
		<form method="post" action="recipeCommentInsertPro.jsp">													
		<input type="hidden" name="recipeNum" value="<%=num%>"/>
		<input type="hidden" name="reLevel" value="0"/>
		<input type="hidden" name="name" value="<%=session.getAttribute("memId")%>"/>
		
			<table class="nonBorder">
				<tr>
					<td rowspan="2" style="width:60px; height:60px; vertical-align:top;border:0px;"><img src="/jnp/save/<%=rDAO.selectImgById(memId)%>" style="width:60px; height:60px; border-radius:30px;"/></td>
					<td style="text-align:left; border:0px;padding-bottom:2px;"><Strong> <%= rDAO.selectNameById(memId) %> </Strong>
				</tr>
				<tr>
					<td><textarea name="content" cols="70" rows="5" style="resize:none; border:2px solid #ccc; border-radius:5px;" required></textarea></td><td><input type="submit" class="greenButton" value="댓글작성" style="height:100%"> </td>
				</tr>
			</table>
		</form>
		<%}%>

</body>
<script>

	//댓글에 답댓글 달기
	function reply(num) {
		var url = "recipeCommentReplyInsertForm.jsp?num=" + num;
		var name = "댓글 달기";
		var option = "width=800,height=200,left=510,top=440,toolbar=no,menubar=no,location=no,scrollbar=no,status=no,resizable=no";
		
		window.open(url,name,option);
		
	}
	//댓글 모두 보기
	function commentList() {
		var url = "recipeCommentList.jsp?num=<%=num%>";
		var name = "댓글 모두 보기";
		var option = "width=550,height=400,left=600,toolbar=no,menubar=no,location=no,status=no,resizable=no";
		
		window.open(url,name,option);
	}
	
	//수정 창 띄우기
	function modifyComment(num) {
		var url = "recipeCommentModifyForm.jsp?num=" +num;
		var name = "댓글 수정하기";
		var option = "width=800,height=300,left=510,top=390,toolbar=no,menubar=no,location=no,scrollbar=no,status=no,resizable=no";
		
		window.open(url,name,option);
	}
	//댓글 삭제
	function deleteComment(num) {
		if(confirm("정말 삭제하시겠습니까?")){
			window.location="recipeCommentDeletePro.jsp?num=" + num;
		}
			
	}
</script>
</html>