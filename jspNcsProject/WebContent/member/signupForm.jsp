<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<style>
table td {
	font-size:1.4em;
	vertical-align:middle;
}
td * {
	margin:0;
	padding:0;
	vertical-align:middle;
	text-align:left;
}
.t {
	text-align:right;
	padding:20px;
	border-right:2px solid #ccc;
	font-size:1.4em;
}
input {
	border:2px solid #ccc;
	border-radius:5px;
	font-size:1.4em;
	self-align:left;
	margin-left:20px;
	vertical-align:middle;
	
}
</style>
<jsp:include page="../header.jsp"></jsp:include>
<%
System.out.println(session.getAttribute("memId"));
if(session.getAttribute("memId")==null){
%>
<body> 
	<h1 align="center">회원가입</h1>
	<form method="post" action="signupPro.jsp" enctype="multipart/form-data" name ="inputForm" onsubmit="return check()" accept-charset="utf-8">
	<table>
		<tr>
			<td class="t">아이디*</td>
			<td><input type="text" name="id" required="required"/></td>
		</tr>
		<!--중복 id 체크버튼-->
		<tr>
			<td class="t">아이디 중복체크</td>
			<td><button class="grayButton" style="width: 80px; height: 30px; text-align: center" type="button" onclick="confirmId(this.form)">중복확인</button></td>
		</tr>
		<tr>
			<td class="t">비밀번호*</td>
			<td><input type="password" name="pw" required="required"/></td>
		</tr>
		<tr>
			<td class="t">비밀번호 확인*</td>
			<td><input type="password" name="pwCh" required="required"/></td>
		</tr>
		<tr>
			<td class="t">활동명*</td>
			<td><input type="text" name="name"  required="required"/></td>
		</tr>
		<tr>
			<td class="t">활동명 중복체크</td>
			<td><button class="grayButton" style="width: 80px; height: 30px; text-align: center" type="button" onclick="confirmName(this.form)">중복확인</button></td>
		</tr>
		<tr>
			<td class="t">주민번호*</td> 
			<td>
				<input type="text" name="id_number1" id="idTest1" maxlength="6" size="6" required="required"/>&nbsp;&nbsp;&nbsp;- 
				<input type="text" name="id_number2" id="idTest2"  maxlength="1" size="1" required="required"/>******
			</td>
		</tr>
		<tr>
			<td class="t">채식주의 타입</td>
			<td> 
				<img src="../recipe/imgs/question.png" width="20px" height="20px" onclick="question()" />
				<select name="vegi_type" required="required">
						<option value="none">Non-vegetarian</option>
						<option value="vegan">vegan</option>
						<option value="lacto">Lacto vegetarian</option>
						<option value="ovo">Ovo vegetarian</option>
						<option value="lacto ovo">Lacto-ovo vegetarian</option>
						<option value="pesco">Pesco-vegetarian</option>
						<option value="pollo">Pollo-vegetarian</option>
						<option value="flexitarian">Flexitarian</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="t">프로필 사진</td>
			<td><input type="file" name="profile_img" /></td>
		</tr>		
		<tr>
			<td colspan="2" align="center" style="padding-top: 30px">
				<button class="grayButton" type="submit" style="width: 50px; height: 30px; text-align: center">가입</button>
				<button class="grayButton" type="reset" style="width: 50px; height: 30px; text-align: center" name="reset">재입력</button>
				<button class="grayButton" type="button" style="width: 50px; height: 30px; text-align: center" onclick="window.location='../main.jsp'">취소</button>
			</td> 
		</tr>
	</table> 
	</form> 
</body>
<%}else{
	response.sendRedirect("../main.jsp");
}
%>
<script type="text/javascript">
	function question(){
		var win = window.open("../recipe/recipeListVegiTypeInfo.jsp","채식유형 정보","width=900,height=850,left=500,top=500,scrollbars=yes,")
	}
	
	function confirmId(inputForm) {
		if (!inputForm.id.value) {
			alert("아이디를 입력하세요");
			return;
		}
		var url = "confirmId.jsp?id=" + inputForm.id.value;
		open(
				url,
				"아이디 중복 체크",
				"toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 300,height = 200");
	}
	function confirmName(inputForm) {
		if (!inputForm.name.value) {
			alert("활동명을 입력하세요");	
			return;
		}
		var url = "confirmId.jsp?name=" + inputForm.name.value;
		open(
				url,
				"아이디 중복 체크",
				"toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 300,height = 200");
	}
	
	//회원가입, 회원정보 수정 유효성 검사
	function check() {
		var inputs = document.inputForm;
		console.log(inputs);

		if (inputs.pw.value != inputs.pwCh.value) {
			alert("비밀번호확인을 동일하게 입력하세요");
			return false;
		}
		var re1= /([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))/;
		var re2= /^[0-9]*$/;
		var test1 = document.getElementById("idTest1").value;
		var test2 = document.getElementById("idTest2").value;
			
		if(!re1.test(test1)){
			alert("주민번호 앞자리는 6자리 숫자만 입력 가능합니다");
			return false;
		} 
		if(!re2.test(test2)){
			alert("주민번호 뒷자리는 숫자만 입력 가능합니다");
			return false;
		}
	}
	
</script>
</html>