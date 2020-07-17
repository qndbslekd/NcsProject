<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>recipeContentCommentInsertForm </title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
</head>
<%
	// 고유번호 num; recipeNum, contentNum, ref, reLvel, reStep, Content, name, reg
	request.setCharacterEncoding("UTF-8");
	
	
	int contentNum = Integer.parseInt(request.getParameter("contentNum"));
	int recipeNum = Integer.parseInt(request.getParameter("recipeNum"));
	int reLevel = Integer.parseInt(request.getParameter("reLevel"));
	int reStep = Integer.parseInt(request.getParameter("reStep"));
	int ref = Integer.parseInt(request.getParameter("ref"));

%>
<body>	
		<h2> 댓글 작성 </h2>
	<form action="recipeContentCommentPro.jsp">
		<input type="hidden" name="contentNum" value="<%= contentNum %>"/>
		<input type="hidden" name="recipeNum" value="<%= recipeNum %>"/>
		<input type="hidden" name="reLevel" value="<%= reLevel %>"/>
		<input type="hidden" name="reStep" value="<%= reStep %>"/>
		<input type="hidden" name="ref" value="<%= ref %>"/>
		
		<table>
			<tr>
				<td colspan="2">
					<input type="text" name="commentContent"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="등록"/>
					<input type="button" value="창닫기" onclick="window.close();"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>