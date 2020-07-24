<%@page import="jspNcsProject.dao.InfomationDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
if(session.getAttribute("memId")==null || !session.getAttribute("memId").equals("admin")){%>
	<script type="text/javascript">
		alert("관리자만 이용가능합니다.");
		window.location = "../main.jsp";
	</script>
<%}else{
	request.setCharacterEncoding("UTF-8");
	String path = request.getRealPath("/information/img");
	System.out.println(path);
	int max = 1024*1024*5; //5MB byte 단위 
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); //중복파일금지
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	
	String subject = mr.getParameter("subject");
	String content = mr.getParameter("content");
	String info_img = mr.getFilesystemName("info_img");
	System.out.println("info_img"+info_img);
	
	InfomationDAO dao = InfomationDAO.getInstance();
	dao.insertInfo(subject,content,info_img);
	response.sendRedirect("informationList.jsp");
}%>
<body>

</body>
</html>