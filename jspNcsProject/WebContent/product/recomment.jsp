<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<%	if(session.getAttribute("memName")==null
	||request.getParameter("beforeName")==null
	||request.getParameter("num")==null){%>
	<%if(session.getAttribute("memName")==null){%>
	<script type="text/javascript">
	if(!window.opener){ 
		alert("올바른 접근이 아닙니다");
		window.location = '../main.jsp';
	}else{
			alert("로그인 후 가능합니다");
			opener.location = "http://localhost:8080/jnp/member/loginForm.jsp";
			window.close();
	}
	</script>
	<%}else{%>
	<script type="text/javascript">
	if(!window.opener){ 
		alert("올바른 접근이 아닙니다");
		window.location = '../main.jsp';
	}else{
			alert("올바른 접근이 아닙니다");
			opener.location = "http://localhost:8080/jnp/product/productList.jsp";
			window.close();
	}
	</script>
	<%} %>
<%}else{
	request.setCharacterEncoding("utf-8");
	String beforeName = request.getParameter("beforeName");
	String num = request.getParameter("num");
	
	System.out.println("beforeName"+beforeName);
	System.out.println("num"+num);
%>
<body>
	<form action="recommentPro.jsp" method="post">
		답글내용 : <input type="text" name="recomment" />
		<input type="submit" value="저장">
		<input type="hidden" value="<%=beforeName%>" name="beforeName"/>
		<input type="hidden" value="<%=num%>" name="num"/>
	</form>
</body>
<%} %>

</html>