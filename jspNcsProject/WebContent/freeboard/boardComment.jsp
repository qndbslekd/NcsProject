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
	String num = request.getParameter("num");//글번호
	
	//댓글리스트 가져오기
	
	
	

%>
<form action="boardCommentPro.jsp" method="post">
	<input type="hidden" name="num" />

	
	<table class="comment_input">
		<tr>
			<td><textarea name="comment" cols="70" rows="3" style="resize:none;"></textarea></td> 
			<td><input type="submit" value="댓글작성"/></td>
		</tr>
	</table>
</form>
	
	<table class="comment_list">
		
	</table>

</body>
</html>