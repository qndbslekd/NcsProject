<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="../header.jsp"></jsp:include>
<%
	if(!session.getAttribute("memId").equals("admin")){%>
		<script>
			alert("관리자 페이지 입니다.");
			window.location="main.jsp";
		</script>
	<%}else{
		
		int pageSize=10;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null){
			pageNum = "1";
		}
		
		int currPage = Integer.parseInt(pageNum);
		int startRow = (currPage -1) * pageSize + 1;
		int endRow = currPage * pageSize;
		int count = 0;
		int number = 0;
		
		MemberDAO dao = MemberDAO.getInstance();
		List memberList = null;
		
		String sel = request.getParameter("sel");
		String search = request.getParameter("search");
		if(sel != null && search != null){
			//count = dao.getSearchMemberCount(sel, search);
		}
		
		
		
		
		
%>
<body>

</body>
<%}%>
</html>