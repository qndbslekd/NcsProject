<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>

</head>
<%

	String memId = (String) session.getAttribute("memId");

	int num = Integer.parseInt(request.getParameter("num"));
	RecipeDAO dao = RecipeDAO.getInstance();
	RecipeDTO recipe = dao.selectRecipeBoard(num);
	
	if(!memId.equals(recipe.getWriter()) && !memId.equals("admin")) {
		%> <script> alert("작성자만 삭제할 수 있습니다."); history.go(-1); </script><%
	} else if(memId.equals("admin")){%>
<body>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="recipe" name="mode"/>
	</jsp:include>

		<table>
			<tr>
				<td>(관리자 권한) 글을 정말 삭제하시겠습니까? </td>
				<input type="hidden" name="num" value="<%=num %>" />
			</tr>
			<tr>
				<td><input type="button" value="돌아가기" onclick="history.back()"/> <input type="button" value="삭제하기" onclick="window.location='recipeDeletePro.jsp?num=<%=num%>'"/></td>
			</tr>
		</table>	
		<br/>
		<jsp:include page="../footer.jsp" flush="false"/>
</body>

	<%} else {%>
<body>
	<jsp:include page="../header.jsp" flush="false"/>
	<form method="post" action="recipeDeletePro.jsp">
		<table>
			<tr>
				<td>글을 삭제하시려면 비밀번호를 입력해주세요.</td>
			</tr>
			<tr>
				<td><input type="password" required name="password"/></td>
					<input type="hidden" name="num" value="<%=num %>" />
			</tr>
			<tr>
				<td><input type="button" value="돌아가기" onclick="history.back()"/> <input type="submit" value="삭제하기"/></td>
			</tr>
		</table>	
	</form>
<br/>
		<jsp:include page="../footer.jsp" flush="false"/>
</body>
<%} %>
</html>