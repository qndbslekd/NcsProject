<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String offenceUrl = request.getParameter("offenceUrl");
	String member = request.getParameter("member");
	
	MemberDAO dao = MemberDAO.getInstance();
	//신고대상이 존재하는 회원인지 확인
	boolean idCh= dao.confirmId(member);
	if(idCh==false){
		%>
		<script>
			alert("존재하지 않는 회원입니다.");
			history.go(-1);
		</script>
		<% 
	}else{		
		dao.updateOffenceColumn(offenceUrl, member);
		%>
		<script>
			alert("신고 되었습니다.");
			history.go(-1);
		</script>
		<% 	
	}
%>
	

</body>
</html>