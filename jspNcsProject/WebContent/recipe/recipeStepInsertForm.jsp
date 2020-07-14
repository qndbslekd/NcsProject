<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 세부내용 작성</title>
<link rel="stylesheet" href="../resource/team05_style.css">
</head>
<%
	request.setCharacterEncoding("utf-8");

	int recipeStep = Integer.parseInt(request.getParameter("recipeStep"));
	String recipeName = request.getParameter("recipeName");
	String writer = request.getParameter("writer");
	String vegiType = request.getParameter("vegiType");
	String difficulty = request.getParameter("difficulty");
	String cal = request.getParameter("cal");
	String quantity = request.getParameter("quantity");
	String ingredients = request.getParameter("ingredients");
	String tag = request.getParameter("tag");
%>
<body>
	<form method="post" action="recipeStepInsertPro.jsp">
		<input type="hidden" name="recipeStep" value="<%=recipeStep%>"/>
		<input type="hidden" name="recipeName" value="<%=recipeName%>"/>
		<input type="hidden" name="writer" value="<%=writer%>"/>
		<input type="hidden" name="vegiType" value="<%=vegiType%>"/>
		<input type="hidden" name="difficulty" value="<%=difficulty%>"/>
		<input type="hidden" name="cal" value="<%=cal%>"/>
		<input type="hidden" name="quantity" value="<%=quantity%>"/>
		<input type="hidden" name="ingredients" value="<%=ingredients%>"/>
		<input type="hidden" name="tag" value="<%=tag%>"/>

		<table>
			<tr>
				<td>대표 이미지 등록</td>
				<td colspan="3"><input type="file" name="thumbnail"/></td>
			</tr>
			<tr>
				<td colspan="4">요리 세부 내용</td>
			</tr>	
			
			<%for(int i = 1; i <= recipeStep; i++) { %>		
			<tr>
				<td><Strong><%=i %></Strong></td>
				<td><input type="text" name="step<%=i%>"/></td>
				<td><input type="file" name="img<%=i %>"/></td>
			</tr>
			<%} %>
			
			<tr>
				<td colspan="4"><input type="button" onclick="history.back()" value="돌아가기"><input type="submit" value="작성하기"/></td>
			</tr>
		</table>
		
		
		
	</form>

</body>
</html>