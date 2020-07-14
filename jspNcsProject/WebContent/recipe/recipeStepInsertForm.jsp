<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 세부내용 작성</title>
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
	<form>
		<input type="hidden" name="recipe_name" />

		<table>
			<tr>
				<td>대표 이미지 등록</td>
				<td><input type="file" name="thumbnail"/></td>
			</tr>
			<tr>
			
		</table>
		
		
		
	</form>

</body>
</html>