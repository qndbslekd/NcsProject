<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
<jsp:include page="../header.jsp"></jsp:include>
<script type="text/javascript">
	function confirmId(inputForm) {
		if (!inputForm.id.value) {
			return;
		}
		var url = "cofirmId.jsp?id=" + inputForm.id.value;
		open(
				url,
				"아이디 중복 체크",
				"toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 300,height = 200");
	}
	function confirmName(inputForm) {
		if (!inputForm.name.value) {
			return;
		}
		var url = "cofirmId.jsp?name=" + inputForm.name.value;
		open(
				url,
				"아이디 중복 체크",
				"toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 300,height = 200");
	}
	// 유효성 검사 수정전
	/* function check() {
		var inputs = document.inputForm;
		console.log(inputs);
		if (!inputs.id.value) {
			alert("아이디를 입력하세요");
			return false;
		}
		if (!inputs.pw.value) {
			alert("비밀번호를 입력하세요");
			return false;
		}
		if (!inputs.name.value) {
			alert("이름을 입력하세요");
			return false;
		}
		if (!inputs.birth.value) {
			alert("생년월일을 입력하세요");
			return false;
		}
		if (!inputs.email.value) {
			alert("이메일을 입력하세요");
			return false;
		}
		if (!inputs.pwCh.value) {
			alert("비밀번호 확인란를 입력하세요");
			return false;
		}
		if (inputs.pw.value != inputs.pwCh.value) {
			alert("비밀번호를 동일하게 입력하세요");
			return false;
		}
	} */
</script>
<%
if(session.getAttribute("memId")==null){
%>
<body> 
	<h1 align="center">회원가입</h1>
	<form method="post" action="signupPro.jsp" enctype="multipart/form-data" name ="inputForm" onsubmit="return check()" accept-charset="utf-8">
	<table>
		<tr>
			<td>아이디*</td>
			<td><input type="text" name="id" /></td>
		</tr>
		<!--중복 id 체크버튼-->
		<tr>
			<td>아이디 중복체크</td>
			<td><input type="button" value="중복확인" onclick="confirmId(this.form)"></td>
		</tr>
		<tr>
			<td>비밀번호*</td>
			<td><input type="password" name="pw" /></td>
		</tr>
		<tr>
			<td>비밀번호 확인*</td>
			<td><input type="password" name="pwCh" /></td>
		</tr>
		<tr>
			<td>활동명*</td>
			<td><input type="text" name="name"  /></td>
		</tr>
		<tr>
			<td>활동명 중복체크</td>
			<td><input type="button" value="중복확인" onclick="confirmName(this.form)"></td>
		</tr>
		<tr>
			<td>주민번호*</td> 
			<td>
				<input type="text" name="id_number1"  maxlength="6" size="6"/>- 
				<input type="text" name="id_number2"  maxlength="1" size="1"/>
			</td>
		</tr>
		<tr>
			<td>채식주의 타입</td>
			<td> 
				<select name="vegi_type">
						<option value="Non-vegetarian">Non-vegetarian</option>
						<option value="Vegan">Vegan</option>
						<option value="Lacto vegetarian">Lacto vegetarian</option>
						<option value="Ovo vegetarian">Ovo vegetarian</option>
						<option value="Lacto-ovo vegetarian">Lacto-ovo vegetarian</option>
						<option value="Pesco-vegetarian">Pesco-vegetarian</option>
						<option value="Pollo-vegetarian">Pollo-vegetarian</option>
						<option value="Flexitarian">Flexitarian</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>프로필 사진</td>
			<td><input type="file" name="profile_img" /></td>
		</tr>		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="가입"/>
				<input type="reset" name="reset" value="재입력" />
				<input type="button" value="취소" onclick="window.location='main.jsp'"/>
			</td> 
		</tr>
	</table> 
	</form>
</body>
<%}else{
	System.out.println("Session=!null redirect > main");
	response.sendRedirect("main.jsp");
}
%>
</html>