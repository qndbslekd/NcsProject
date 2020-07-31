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
	System.out.println(recipe.getIngredients());
	
	String memId = (String) session.getAttribute("memId");
	if(!memId.equals(recipe.getWriter()) && !memId.equals("admin")) {
		%> <script> alert("작성자만 수정할 수 있습니다."); history.go(-1); </script> <%
	} else {
	
	
	
%>
<body>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="recipe" name="mode"/>
	</jsp:include>


	<form action="recipeStepModifyForm.jsp" method="post">
		<input type="hidden" name="num" value="<%=num %>" />
		<table style="padding:10px;" class="insertTable">
			<tr>
				<td class="t">제목</td>
				<td class="h" width="500"><input type="text" name="recipeName" class="inputInfo" placeholder="제목을 입력해주세요" required style="width:90%" value="<%=recipe.getRecipeName()%>"/></td>
			</tr>
			<tr>
				<td class="t">작성자</td>
				<td class="h" style="padding-left:40px;"><%=session.getAttribute("memName") %><input type="hidden" name="writer"  style="border:0px;" value="<%=memId%>" /></td>
			</tr>
			<tr>
				<td class="t">채식유형 <img src="./imgs/question.png" width="20px" height="20px" onclick="question()" /></td>
				<td class="h" style="text-align:left">
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
				<td class="t">요리 분량</td>
				<td class="h"><input type="number"  min="1" max="99"  name="quantity" required style="width:50px;" value="<%=recipe.getQuantity()%>"/>인분</td>
			</tr>
			<tr>
				<td class="t">요리 시간</td>
				<td class="h"><input type="number"  min="1" max="9999"  name="cookingTime" required style="width:50px"value="<%=recipe.getCookingTime()%>"/>분</td>
			</tr>
			<tr>
				<td class="t">난이도</td>
				<td class="h">
					<select name="difficulty" required style="font-size:25px;" >
						<option value="" disabled selected style="font-size:25px;">난이도를 선택하세요</option>
						<option value="쉬움" <%if(recipe.getDifficulty().equals("쉬움")){ %>selected<%} %>>쉬움</option>
						<option value="보통" <%if(recipe.getDifficulty().equals("보통")){ %>selected<%} %>>보통</option>
						<option value="어려움" <%if(recipe.getDifficulty().equals("어려움")){ %>selected<%} %>>어려움</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="t">칼로리</td>
				<td class="h"><input type="number" min="0" max="99999" name="cal" <%if(recipe.getCal() > 0) {  %>value="<%=recipe.getCal()%>"<%} %> required style="width:80px"/>kcal</td>
			</tr>
			<tr>
				<td class="t" style="vertical-align:top;">재료</td>
				<td class="h"><textarea cols="40" rows="10" placeholder="예) 
감자 : 1개
양파 : 2개
고추장 : 두스푼
..." name="ingredients" style="resize:none;overflow:visible;font-size:25px;"><%=recipe.getIngredients().substring(1,recipe.getIngredients().length()-1)%></textarea><br/> 
				<span class="h" style="font-size:15px; color:#858585">재료명과 분량 사이에 콜론(:)을 꼭 넣어주세요</span>
			</td>
			</tr>
			<tr>
				<td class="t">요리 단계</td>
				<td class="h"><input type="number" name="recipeStep" required style="width:50px" value="<%=recipe.getRecipeStep()%>"/>단계</td>
			</tr>
			<tr>
				<td class="t">태그</td>
				<td class="h"><input type="text" placeholder="예) 태그, 태그, 태그 ..." name="tag" style="width:90%" <%if(recipe.getTag() != null) {  %>value="<%=recipe.getTag().substring(1, recipe.getTag().length()-1)%>"<%}%>/></td>
			</tr>
			<tr>
			
				<td colspan="2" style="text-align:center;"><br/><input type="submit" class="greenButton" value="레시피 작성단계로" />
			</tr>
		</table>
	</form>
	<br/><br/>
<br/>
		<jsp:include page="../footer.jsp" flush="false"/>
</body>
<%} %>
</html>