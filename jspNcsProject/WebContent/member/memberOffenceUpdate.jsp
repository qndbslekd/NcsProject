<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<% 
	request.setCharacterEncoding("utf-8");
	String url = request.getParameter("url");
	String id =  request.getParameter("id");
%>
<script type="text/javascript">
	function commit(url,id){
		window.location = 'memberOffenceUpdatePro.jsp?url='+url+'&option=commit&id='+id;
	}
	function rollback(url,id){
		window.location = 'memberOffenceUpdatePro.jsp?url='+url+'&option=rollback&id='+id;
	} 
</script> 
<body>
	<div style="text-align: center;">
	<button type="button" onclick="commit('<%=url%>','<%=id%>')">신고확정</button>
	<button type="button" onclick="rollback('<%=url%>','<%=id%>')">신고취소</button>
	</div>
</body>
</html>