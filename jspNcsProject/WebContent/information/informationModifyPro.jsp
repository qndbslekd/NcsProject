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
		window.location="information.jsp";
	</script>
	<%}%>

	request.setCharacterEncoding("UTF-8");
	String[] subject = request.getParameterValues("subject");
	String[] content = request.getParameterValues("content");
	String[] num = request.getParameterValues("num");
	System.out.println("subject.length"+subject.length);
	System.out.println("content.length"+content.length);
	System.out.println("num.length"+num.length);
	int result=0;
	
	InfomationDAO dao = InfomationDAO.getInstance();
	for(int i=0;i<subject.length;i++){
	result = dao.updateInfomation(num[i],subject[i],content[i]);
		if(result==1){
			System.out.println(subject[i]+"의 내용이 수정되었습니다");
		}
	}
	response.sendRedirect("information.jsp");
%>
<body>

</body>
</html>