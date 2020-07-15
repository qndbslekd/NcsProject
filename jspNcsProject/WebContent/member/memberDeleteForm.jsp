<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
function confirmSignOut(){
	var result = confirm("탈퇴하시겠습니까?");
	if(result){
	    alert("탈퇴완료");
	    location.href='memberDeletePro.jsp';
	}else{
	    location.href='memberDeleteForm.jsp';
	}	
}
</script>
<body>
<br/>
<h1 align="center"> 회원 탈퇴 </h1>
<form action="memberDeletePro.jsp" method="post">
	<table>
		<tr>
			<td colspan="2"> 아이디 </td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="id"/></td>
		</tr>
		<tr>
			<td colspan="2"> 비밀번호 </td>
		</tr>
		<tr>
			<td colspan="2"><input type="password" name="pw" placeholder="비밀번호를 입력하세요"/> </td>
		</tr>
		<tr>
			<td><input type="button" value="탈퇴" onclick="confirmSignOut()"/> </td>
			<td><input type="button" value="취소" onclick="window.location='myPage.jsp'"/>  </td>
		</tr>
	</table>
</form>

</body>
</html>