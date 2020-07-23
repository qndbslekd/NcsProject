<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답 댓글 달기</title>
</head>
<script>
	function check(){
		var inputs= document.commentForm;
		if(!inputs.content.value){
			alert("내용을 입력하세요");
			return false;
		}
	}
</script>
<%
	if(session.getAttribute("memId") == null ||request.getParameter("freeboard_num") == null || request.getParameter("ref") == null || request.getParameter("re_level") ==null){%>
	<script>
		alert("잘못된 접근입니다.");
		history.go(-1);
	</script>
	<% }else{
	
	 int freeboard_num = Integer.parseInt(request.getParameter("freeboard_num"));
	 int ref = Integer.parseInt(request.getParameter("ref"));
	 int re_level = Integer.parseInt(request.getParameter("re_level"));
	 String receiver = request.getParameter("receiver");

%>
<body>
	<form action="boardCommentPro.jsp" method="post" name="commentForm" onsubmit="return check()">
		<input type="hidden" name="freeboard_num" value="<%=freeboard_num%>"/>
		<input type="hidden" name="ref" value="<%=ref%>"/>
		<input type="hidden" name="re_level" value="<%=re_level%>"/>
		<input type="hidden" name="receiver" value="<%=receiver%>"/>
		<input type="hidden" name="writer" value="<%=session.getAttribute("memId")%>"/>
		<table>
			<tr>
				<td><textarea name="content" cols="70" rows="3" style="resize:none;"></textarea></td>
				<td><input type="submit" value="댓글작성"/></td>
			</tr>		
		</table>
	</form>
</body>
<%} %>
</html>