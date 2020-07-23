<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	if(request.getParameter("url")==null||request.getParameter("id")==null||request.getParameter("option")==null){%>
	<script>
		alert("잘못된 접근입니다");
		history.go(-1);
	</script>
	<%}else{
		request.setCharacterEncoding("UTF-8");
		String option = request.getParameter("option");
		String url = request.getParameter("url");
		String id = request.getParameter("id");
		
		MemberDAO dao = MemberDAO.getInstance();
		boolean isCommit = dao.updateOffence(option,url,id);
		if(isCommit){
			%><script type="text/javascript">
					alert("신고 확정 처리되었습니다.");			
			  </script><%
			
		}else{
			%><script type="text/javascript">
					alert("신고 취소 처리되었습니다.");			
			  </script><%
			
		} 
	}
%>
<body>
<script type="text/javascript">
	opener.location.reload();
	window.close();
</script>
</body>
</html>