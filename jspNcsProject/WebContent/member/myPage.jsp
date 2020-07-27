<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="../header.jsp"></jsp:include>
<%
	if(session.getAttribute("memId") == null){%>
		<script>
			alert("로그인 후 이용하세요");
			window.location="loginForm.jsp";
		</script>
	<%}else{ 
%>
<body>
<br /><br /> 
<h1 align="center"> 마이 페이지 </h1> 
	<table>
		<tr>
			<td>
				<a onclick="window.location='memberModifyForm.jsp'" style="cursor:pointer;"><img src="../resource/modify_.png"><br/>정보 수정</a>
			</td>
			<td>
				<a onclick="window.location='memberDeleteForm.jsp'" style="cursor:pointer;"><img src="../resource/delete_.png"><br/>회원 탈퇴</a>
			</td>
		</tr>
		<tr>
			<td>
				<a onclick="window.location='myList.jsp'" style="cursor:pointer;"><img src="../resource/recipe_.png"><br/>내 글/댓글 목록</a>				
			</td>
			<td>
				<a onclick="window.location='myScrapRecipe.jsp'" style="cursor:pointer;"><img src="../resource/comment_.png"><br/>내가 찜한 레시피</a>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding-top: 20px">
				<button  class="grayButton" onclick="window.location='../main.jsp'" style="width: 80px; height: 30px; text-align: center">메인으로</button>
				<button class="grayButton" onclick="window.location='../logoutPro.jsp'" style="width: 80px; height: 30px; text-align: center">로그아웃</button>
			</td>
		</tr>
		<%if(session.getAttribute("memId").equals("admin")){ %>
			<tr>
				<td colspan="3" style="padding-top: 5px;"> <button class = "grayButton"  style="width: 100px; height: 30px; text-align: center" onclick="window.location='memberList.jsp'">관리자 페이지</button></td>
			</tr>
		<%}} %>
	</table>
</body>
</html>