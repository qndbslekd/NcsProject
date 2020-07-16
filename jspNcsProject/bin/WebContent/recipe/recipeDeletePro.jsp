<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 삭제 처리</title>
</head>
<%
	String memName = (String) session.getAttribute("memName");

	int num = Integer.parseInt(request.getParameter("num"));
	RecipeDAO recipedao = RecipeDAO.getInstance();
	MemberDAO memberdao = MemberDAO.getInstance();
	
	//글 정보 가져오기
	RecipeDTO recipe = recipedao.selectRecipeBoard(num);
	
	if(!memName.equals(recipe.getWriter()) && !memName.equals("관리자")) {
		%> <script> alert("작성자만 삭제할 수 있습니다."); history.go(-1); </script><%
	} else if (memName.equals("관리자")){	//관리자일 경우 비밀번호 확인 없이 삭제
		recipedao.deleteRecipeBoard(num);
		%> <script> alert("삭제되었습니다."); window.location='recipeList.jsp'; </script><%
	} else {
		//입력한 비밀번호 = 세션의 비밀번호 일치여부 확인
		String inputPW = request.getParameter("password");
		String pw = (String) session.getAttribute("memPw");
		//일치하면 삭제
		if(inputPW.equals(pw)) {
			recipedao.deleteRecipeBoard(num);
			
			%> <script> alert("삭제되었습니다."); window.location='recipeList.jsp'; </script><%
			
		} else {	//불일치하면 알림창 후 뒤로가기
			%> <script> alert("비밀번호가 틀렸습니다."); history.go(-1); </script><%
		}
		
%>
<body>
	
</body>
<%} %>
</html>