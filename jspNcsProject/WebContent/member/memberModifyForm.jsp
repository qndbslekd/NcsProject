<%@page import="jspNcsProject.dto.MemberDTO"%>
<%@page import="jspNcsProject.dao.MemberDAO"%>
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
	padding-right: 60px;
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
<%if(session.getAttribute("memId")==null){%>
	<script type="text/javascript">
		alert("로그인후 이용해주세요.");
		window.location = "../main.jsp";
	</script>
<%}else{%>
<jsp:include page="../header.jsp"></jsp:include>
<%
String id = session.getAttribute("memId").toString();
MemberDAO dao = MemberDAO.getInstance();
MemberDTO dto = dao.modifyData(id); 
System.out.println(dto);
%>
<script type="text/javascript">
	function confirmName(inputForm) {
		if (!inputForm.name.value) {
			return;
		}
		var url = "confirmId.jsp?name=" + inputForm.name.value;
		open(
				url,
				"아이디 중복 체크",
				"toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 300,height = 200");
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
	}
</script> 

<body>
	<h1 align="center">회원정보수정</h1>
	<form method="post" action="memberModifyPro.jsp" enctype="multipart/form-data" name ="inputForm" onsubmit="return check()">
	<table>
		<tr> 
			<td class="t">기존 프로필 사진</td>
			<td> 
				<%if(dto.getProfile_img()==null||dto.getProfile_img().equals("null")){%>
					<img src="/jnp/save/unnamed.gif" width="300px" height="300px">
				<%}else{%>
					<img src="/jnp/save/<%=dto.getProfile_img()%>" width="300px" height="300px">
				<%} %>
			</td>  
		</tr>
		<tr>
			<td class="t">변경할 프로필 사진</td>
			<td><input type="file" name="profile_img" /></td>
			<%if(dto.getProfile_img()!=null){%>
				<input type ="hidden" name ="profile_img_before" value="<%=dto.getProfile_img()%>" />
			<%}else{%>
				<input type ="hidden" name ="profile_img_before" />
			<%} %>
		</tr>
		<tr>
			<td class="t">아이디*</td>
			<td><%=dto.getId() %></td>
		</tr>
		<tr>
			<td class="t">비밀번호*</td>
			<td><input type="password" name="pw" value="<%=dto.getPw() %>" required="required"/></td>
		</tr>
		<tr>
			<td class="t">비밀번호 확인*</td>
			<td><input type="password" name="pwCh" required="required"/></td>
		</tr>
		<tr>
			<td class="t">활동명*</td>
			<td><input type="test" value="<%=dto.getName() %>" name = "name" required="required"/></td>
		</tr>
		<tr>
			<td class="t">활동명 중복체크</td>
			<td><button class="grayButton" type="button" onclick="confirmName(this.form)"
			style="width: 80px; height: 30px; text-align: center">중복확인</button></td>
		</tr>
		<tr>
			<td class="t">주민번호*</td>  
			<td><%=dto.getId_number().substring(0, 6)%>
			-<%=dto.getId_number().charAt(dto.getId_number().length()-1) %>******
			</td>
		</tr> 
		<tr>
			<td class="t">채식주의 타입 수정</td>
			<td>
				<select name="vegi_type">
						<option value="none" <%if(dto.getVegi_type().equals("none")){%> selected="selected" <%}%>>Non-vegetarian</option>
						<option value="vegan" <%if(dto.getVegi_type().equals("vegan")){%> selected="selected" <%}%>>Vegan</option>
						<option value="lacto" <%if(dto.getVegi_type().equals("lacto")){%> selected="selected" <%}%>>Lacto vegetarian</option>
						<option value="ovo" <%if(dto.getVegi_type().equals("ovo")){%> selected="selected" <%}%>>Ovo vegetarian</option>
						<option value="lacto ovo" <%if(dto.getVegi_type().equals("lacto ovo")){%> selected="selected" <%}%>>Lacto-ovo vegetarian</option>
						<option value="pesco" <%if(dto.getVegi_type().equals("pesco")){%> selected="selected" <%}%>>Pesco-vegetarian</option>
						<option value="pollo" <%if(dto.getVegi_type().equals("pollo")){%> selected="selected" <%}%>>Pollo-vegetarian</option>
						<option value="flexitarian" <%if(dto.getVegi_type().equals("flexitarian")){%> selected="selected" <%}%>>Flexitarian</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center" style="padding-top: 20px">
				<button class="grayButton" type="submit" style="width: 50px; height: 30px; text-align: center">수정</button>
				<button class="grayButton" type="reset" name="reset" style="width: 50px; height: 30px; text-align: center" >재입력</button>
				<button class="grayButton" type="button" value="취소" style="width: 50px; height: 30px; text-align: center" onclick="window.location='../main.jsp'">취소</button>
			</td> 
		</tr>
	</table> 
	</form>
</body>
<%} %>
</html>