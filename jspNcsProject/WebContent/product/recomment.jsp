<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<%


request.setCharacterEncoding("utf-8");
String beforeName = request.getParameter("beforeName");
String num = request.getParameter("num");

System.out.println("beforeName"+beforeName);
System.out.println("num"+num);



/* if(!recomment.equals("")){
int result  = dao.insertComment(num,name,recomment,beforeName);
System.out.println(result+"개의 답글이 입력되었습니다");
} */

//response.sendRedirect("productContent.jsp?num="+num);
%>

<body>
	<form action="recommentPro.jsp" method="post">
		답글내용 : <input type="text" name="recomment" />
		<input type="submit" value="저장">
		<input type="hidden" value="<%=beforeName%>" name="beforeName"/>
		<input type="hidden" value="<%=num%>" name="num"/>
	</form>
</body>
</html>