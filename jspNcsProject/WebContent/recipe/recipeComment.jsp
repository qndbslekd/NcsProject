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
		<h2>댓글이 없습니다</h2>
	<%} else { //댓글이 있으면
	int pageSize = 4;
	int count = RecipeCommentList.size();
	String pageNum = request.getParameter("pageNum");
	if(pageNum==null) pageNum="1";
	int currPage = Integer.parseInt(pageNum);
	
	int startRow = pageSize*(currPage-1) ;
	int endRow =currPage*pageSize;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	for(int i = 0; i < RecipeCommentList.size(); i++) {
		RecipeCommentDTO dto = (RecipeCommentDTO) RecipeCommentList.get(i);
		
%>
	<hr>
	<table style="width:500px; " border=0>
		<tr>
			<%if (dto.getReLevel()>0) {%><td rowspan="2" width="20px;" style="vertical-align:top;"><img src="/jnp/recipe/imgs/replyImg.png" width="10px"/></td><%} %>
			<td style="text-align:left; border-right:none;">
			<Strong> <%= rDAO.selectNameById(dto.getName()) %> </Strong>
			<%if (memId != null) { %>
					<%if (dto.getName().equals(memId)) {//내가 쓴 댓글이면 수정버튼%><button onclick="recipeCommentModifyForm.jsp">수정</button><%} %>
					<%if (dto.getName().equals(memId) || memId.equals("admin")) {//내가 쓴 댓글(혹은 관리자)이면 삭제버튼%><button onclick="recipeCommentDeleteForm.jsp">삭제</button>
					<%} else { //아니면 답글, 신고버튼%> 
						<button onclick="reply(<%=dto.getNum() %>)" >답글</button> 
						<button onclick="report(<%=dto.getNum() %>)" >신고</button> 
					<%} %>
			<%} %>
			</td>
			<td style="text-align:right; border-left:none;"><%=sdf.format(dto.getReg()) %></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:left;">
				<%if (dto.getReceiver() !=null) { //만약 대댓글이라면 원본댓글 작성자 이름 넣어주기%>
					<Strong><%= rDAO.selectNameById(dto.getReceiver()) %></Strong>
				<%}%>
				<%=dto.getContent() %>
			</td>
		</tr>
	</table>
	
<%}%>
<hr>
<%}%>
		
		<%--댓글 작성 폼--%>
		<% if(memId==null) {%>
			<h4>댓글을 작성하시려면 로그인하십시오.</h4>
		<%} else { %>
		<form method="post" action="recipeCommentInsertPro.jsp">													
		<input type="hidden" name="recipeNum" value="<%=num%>"/>
		<input type="hidden" name="reLevel" value="0"/>
		<input type="hidden" name="reStep" value="0"/>
		<input type="hidden" name="name" value="<%=session.getAttribute("memId")%>"/>
		
			<table>
				<tr>
					<td><textarea name="content" cols="70" rows="3" style="resize:none;"></textarea></td><td><input type="submit" value="댓글작성"/>
				</tr>
			</table>
		</form>
		<%}%>

</body>
<script>
	//신고 기능
	function report(commentNum) {
		if(confirm("이 댓글을 신고하시겠습니까?")==true) {
			
		}
		
	}
	//댓글에 답댓글 달기
	function reply(num) {
		var url = "recipeCommentReplyInsertForm.jsp?num=" + num;
		var name = "댓글 달기";
		var option = "width=400,height=400,left=600,toolbar=no,menubar=no,location=no,scrollbar=no,status=no,resizable=no";
		
		window.open(url,name,option);
		
	}
</script>
</html>