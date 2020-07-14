<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1 align="center"> 마이 페이지 </h1> 
<form>
	<table>
		<tr> 
			<td>
				<a onclick="window.location='memberModifyForm.jsp'"><img src="../resource/modify.png"><br/>정보 수정</a>
			</td>
			<td>
				<a onclick="window.location='memberDeleteForm.jsp'"><img src="../resource/delete.png"><br/>회원 탈퇴</a>
			</td>
		</tr>
		<tr>
			<td>
				<a onclick="window.location='myRecipeList.jsp'"><img src="../resource/recipe.png"><br/>내가 본 레시피</a>
			</td>
			<td>
				<a onclick="window.location='myComment.jsp'"><img src="../resource/comment.png"><br/>내가 쓴 댓글</a>
			</td>
		</tr>
	</table>
</form>

</body>
</html>