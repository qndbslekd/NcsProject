<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<form method="post" action="test2.jsp" enctype="multipart/form-data" name ="inputForm" accept-charset="utf-8">
		<td>
			<input type="text" name="id_number1"  id= "test1" maxlength="6" size="6" />&nbsp;&nbsp;&nbsp;- 
			<input type="text" name="id_number2"  id= "test2" maxlength="1" size="1" />******
		</td>
		<button type="button" class="grayButton" onclick="check()" style="width: 50px; height: 30px; text-align: center">가입</button>
	</form>
</body>
<script>
	function check() {
		var inputs = document.inputForm;
		console.log(inputs);
		/* 	
			if (inputs.pw.value != inputs.pwCh.value) {
			alert("비밀번호확인을 동일하게 입력하세요");
			return false;
		}
		 */
		var re= /^[0-9]*$/;
		var test1 = document.getElementById("test1").value;
		var test2 = document.getElementById("test2").value;
		if(!re.test(test1)){
			console.log(test1);
			alert("주민번호는 숫자만 입력 가능합니다");
			input.id_number1.focus;
			return false; 
		}
		if(!re.test(test2)){
			console.log(test2);
			alert("주민번호는 숫자만 입력 가능합니다");
			input.id_number2.focus;
			return false;
		}
	}
</script>
</html>