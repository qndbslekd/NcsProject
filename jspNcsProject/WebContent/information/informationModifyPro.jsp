<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
	String info_img = "";
	String path = request.getRealPath("/information/img");
	int max = 1024*1024*5; //5MB byte 단위 
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); //중복파일금지
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	
	String subject = mr.getParameter("subject");
	String content = mr.getParameter("content");
	String num = mr.getParameter("num");
	if(mr.getFilesystemName("info_img")==null){
		info_img= mr.getParameter("info_img_before");
	}else{
		info_img= mr.getFilesystemName("info_img");
	}
	int result=0;
	InfomationDAO dao = InfomationDAO.getInstance();
	result = dao.updateInfomation(num,subject,content,info_img);
		if(result==1){
			System.out.println(subject+"의 내용이 수정되었습니다");
		}
	response.sendRedirect("informationList.jsp");
%>
<body>

</body>
</html>