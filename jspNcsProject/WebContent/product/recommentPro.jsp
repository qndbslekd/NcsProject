<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	if(session.getAttribute("memName")==null
	||request.getParameter("beforeName")==null
	||request.getParameter("num")==null
	||request.getParameter("recomment")==null){%>
	<script type="text/javascript">
			alert("올바른 접근이 아닙니다");
			window.location = "http://localhost:8080/jnp/product/productList.jsp";
	</script>
	<%}else{
		request.setCharacterEncoding("utf-8");
		String beforeName = request.getParameter("beforeName");
		String num = request.getParameter("num");
		ProductDAO dao = ProductDAO.getInstance();
		String name = session.getAttribute("memName").toString();
		String recomment = request.getParameter("recomment");
		if(!recomment.equals("")){
			int result  = dao.insertComment(num,name,recomment,beforeName);
			System.out.println(result+"개의 답글이 입력되었습니다");
		}
	}
%>
<script type="text/javascript">
	opener.location.reload();
	self.close();
</script>
<body>
</body>
</html>