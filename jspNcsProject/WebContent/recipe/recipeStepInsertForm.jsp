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
	String cookingTime = request.getParameter("cookingTime");
	

	
	try {
	//재료 다듬어서 저장하기
		String ingre = ",";
		//모든 콤마를 슬래시로 바꾸기
		ingredients = ingredients.replaceAll(",", "/");
		//줄바꿈을 콤마로 바꾸기
		ingredients = ingredients.replaceAll("\n", ",");
		//콤마 기준으로 나누기
		String[] ingreSplit = ingredients.split(",");
		
		for(int i = 0; i<ingreSplit.length; i++) {
			ingreSplit[i] = ingreSplit[i].trim(); //양쪽 공백 없애고 
			String[] tmp = ingreSplit[i].split(":");
			tmp[0] = tmp[0].trim();
			tmp[1] = tmp[1].trim();
			ingre += tmp[0] + ":" + tmp[1] + ","; //문자열에 더하기
		}
		
		ingredients = ingre;
	} catch(Exception e) { %> 
		<script>
			alert("재료 입력 형식을 확인해주세요. \n\ ------------------ \n\재료명 : 분량\n\재료명 : 분량\n\ ... \n\------------------");
			history.go(-1);
		</script>
	<%}
		
		
	
	
%>
<body>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="recipe" name="mode"/>
	</jsp:include>

	<br/>
	<form method="post" action="recipeInsertPro.jsp" enctype="multipart/form-data">
		<input type="hidden" name="recipeStep" value="<%=recipeStep%>"/>
		<input type="hidden" name="recipeName" value="<%=recipeName%>"/>
		<input type="hidden" name="writer" value="<%=writer%>"/>
		<input type="hidden" name="vegiType" value="<%=vegiType%>"/>
		<input type="hidden" name="difficulty" value="<%=difficulty%>"/>
		<input type="hidden" name="cal" value="<%=cal%>"/>
		<input type="hidden" name="quantity" value="<%=quantity%>"/>
		<input type="hidden" name="ingredients" value="<%=ingredients%>"/>
		<input type="hidden" name="tag" value="<%=tag%>"/>
		<input type="hidden" name="cookingTime" value="<%=cookingTime%>"/>

		<table class="insertTable">
			<tr>
				<td  class="t">대표 이미지 등록</td>
				<td  class="h" colspan="3"><input type="file" name="thumbnail" required/></td>
			</tr>
			<tr>
				<td colspan="4">요리 세부 내용</td>
			</tr>	
			
			<%for(int i = 1; i <= recipeStep; i++) { %>		
			<tr>
				<td class="t" rowspan="2" style="vertical-align:top;"><h1 style="margin:0"><%=i %></h1></td>
				<td class="h" style="padding-bottom:3px;"><textarea name="step<%=i%>" placeholder="<%=i%>번째 조리과정을 입력하세요" style="width:600px; height:100px; resize:none;" required></textarea></td>
			</tr>
			<tr>
				<td class="h" style="padding-top:0px;"><input type="file" name="img<%=i %>" style="width:400px; margin-left:20px;"/></td>
			</tr>
			<%} %>
			
			<tr>
				<td colspan="4"><input type="button" onclick="history.back()" class="greenButton" value="돌아가기">
				<input type="submit" class="greenButton"  value="작성하기"/></td>
			</tr>
		</table>
		
		
		
	</form>
<br/>
		<jsp:include page="../footer.jsp" flush="false"/>
</body>
</html>