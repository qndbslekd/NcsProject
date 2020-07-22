<%@page import="jspNcsProject.dao.InfomationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	if(session.getAttribute("memId") == null||!session.getAttribute("memId").equals("admin")){%>
	<script>
		alert("관리자만 이용할수 있습니다");
		window.location="informationList.jsp";
	</script>
	<%}

	request.setCharacterEncoding("UTF-8");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String num = request.getParameter("num");
	int result=0;
	
	InfomationDAO dao = InfomationDAO.getInstance();
	result = dao.updateInfomation(num,subject,content);
		if(result==1){
			System.out.println(subject+"의 내용이 수정되었습니다");
		}
	response.sendRedirect("informationList.jsp");
%>
<body>

</body>
</html>