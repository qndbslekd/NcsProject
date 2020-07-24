<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 수정</title>
<link rel="stylesheet" href="../resource/team05_style.css">

</head>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	
	RecipeDAO dao = RecipeDAO.getInstance();
	
	RecipeDTO recipe = dao.selectRecipeBoard(num);
	
	//재료 콤마를 줄바꿈으로 바꿔서 보여주기
	recipe.setIngredients(recipe.getIngredients().replace(",", "\n"));
	
	
	String memId = (String) session.getAttribute("memId");
	if(!memId.equals(recipe.getWriter()) && !memId.equals("admin")) {
		%> <script> alert("작성자만 수정할 수 있습니다."); history.go(-1); </script> <%
	} else {
	
	
	
%>
<body>
<jsp:include page="../header.jsp"/>
	<form action="recipeStepModifyForm.jsp" method="post">
	<input type="hidden" name="num" value="<%=num %>" />
		<table>
			<tr>
				<td>제목</td>
				<td width="300"><input type="text" name="recipeName" required value="<%=recipe.getRecipeName()%>"/></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%=session.getAttribute("memName") %><input type="hidden" name="writer" value="<%=memId%>" /></td>
			</tr>
			<tr>
				<td>채식유형</td>
				<td style="text-align:left">
					<input type="radio" name="vegiType" value="vegan" required <%if(recipe.getVegiType().equals("vegan")){ %>checked<%} %>/>비건<br/>
					<input type="radio" name="vegiType" value="lacto" required <%if(recipe.getVegiType().equals("lacto")){ %>checked<%} %>/>락토<br/>
					<input type="radio" name="vegiType" value="ovo" required <%if(recipe.getVegiType().equals("ovo")){ %>checked<%} %>/>오보<br/>
					<input type="radio" name="vegiType" value="lacto ovo" required <%if(recipe.getVegiType().equals("lacto ovo")){ %>checked<%} %>/>락토오보<br/>
					<input type="radio" name="vegiType" value="pesco" required <%if(recipe.getVegiType().equals("pesco")){ %>checked<%} %>/>페스코<br/>
					<input type="radio" name="vegiType" value="pollo" required <%if(recipe.getVegiType().equals("pollo")){ %>checked<%} %>>폴로<br/>
					<input type="radio" name="vegiType" value="flexitarian" required <%if(recipe.getVegiType().equals("flexitarian")){ %>checked<%} %>/>플렉시테리언<br/>
				</td>
			</tr>
			<tr>
				<td>요리 분량</td>
				<td><input type="number" name="quantity" required value="<%=recipe.getQuantity()%>"/>인분</td>
			</tr>
			<tr>
				<td>요리 시간</td>
				<td><input type="number" name="cookingTime" required value="<%=recipe.getCookingTime()%>"/>분</td>
			</tr>
			<tr>
				<td>난이도</td>
				<td>
					<select name="difficulty" required >
						<option value="" disabled selected>난이도를 선택하세요</option>
						<option value="쉬움" <%if(recipe.getDifficulty().equals("쉬움")){ %>selected<%} %>>쉬움</option>
						<option value="보통" <%if(recipe.getDifficulty().equals("보통")){ %>selected<%} %>>보통</option>
						<option value="어려움" <%if(recipe.getDifficulty().equals("어려움")){ %>selected<%} %>>어려움</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>칼로리</td>
				<td><input type="number" name="cal" <%if(recipe.getCal() > 0) {  %>value="<%=recipe.getCal()%>"<%} %>/></td>
			</tr>
			<tr>
				<td>재료</td>
				<td><input type="text" placeholder="예) 감자 1개, 양파 2개, 고추장 두스푼, ..." name="ingredients" value="<%=recipe.getIngredients().substring(1,recipe.getIngredients().length()-1)%>"/></td>
			</tr>
			<tr>
				<td>요리 단계</td>
				<td><input type="number" name="recipeStep" required value="<%=recipe.getRecipeStep()%>"/>단계</td>
			</tr>
			<tr>
				<td>키워드</td>
				<td><input type="text" placeholder="예) 태그,태그,태그 ..." style="resize:none" name="tag" 
					<%if(recipe.getTag() != null) {  %>value="<%=recipe.getTag().substring(1, recipe.getTag().length()-1)%>"<%}%>>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="레시피 작성단계로" />
			</tr>
		</table>
	</form>


</body>
<%} %>
</html>