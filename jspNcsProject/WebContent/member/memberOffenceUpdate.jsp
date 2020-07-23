<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<% 
	if(request.getParameter("url")==null||request.getParameter("id")==null){%>
		<script>
			alert("잘못된 접근입니다");
			history.go(-1);
		</script>
	<%}else{
	request.setCharacterEncoding("utf-8");
	String url = request.getParameter("url");
	String id =  request.getParameter("id");%>
<body>
	<div style="text-align: center;">
	<button type="button" onclick="commit('<%=url%>','<%=id%>')">신고확정</button>
	<button type="button" onclick="rollback('<%=url%>','<%=id%>')">신고취소</button>
	</div>
</body>
	<%} %>
	<script type="text/javascript">
	function commit(url,id){
		window.location = 'memberOffenceUpdatePro.jsp?url='+url+'&option=commit&id='+id;
	}
	function rollback(url,id){
		window.location = 'memberOffenceUpdatePro.jsp?url='+url+'&option=rollback&id='+id;
	} 
</script>
</html>