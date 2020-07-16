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
<%if(session.getAttribute("memId")==null){%>
	<script type="text/javascript">
		alert("로그인후 이용해주세요.");
		window.location = "main.jsp";
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
		var url = "cofirmId.jsp?name=" + inputForm.name.value;
		open(
				url,
				"아이디 중복 체크",
				"toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 300,height = 200");
	}
</script>
<body>
	<h1 align="center">회원정보수정</h1>
	<form method="post" action="memberModifyPro.jsp" enctype="multipart/form-data" name ="inputForm">
	<table>
		<tr> 
			<td>기존 프로필 사진</td>
			<td><img src="/jnp/save/<%=dto.getProfile_img()%>"></td>  
		</tr>
		<tr>
			<td>변경할 프로필 사진</td>
			<td><input type="file" name="profile_img" /></td>
			<input type ="hidden" name ="profile_img_before" value="<%=dto.getProfile_img()%>"/>
		</tr>
		<tr>
			<td>아이디*</td>
			<td><%=dto.getId() %></td>
		</tr>
		<tr>
			<td>비밀번호*</td>
			<td><input type="password" name="pw" value="<%=dto.getPw() %>"/></td>
		</tr>
		<tr>
			<td>비밀번호 확인*</td>
			<td><input type="password" name="pwCh" /></td>
		</tr>
		<tr>
			<td>활동명*</td>
			<td><input type="test" value="<%=dto.getName() %>" name = "name"/></td>
		</tr>
		<tr>
			<td>활동명 중복체크</td>
			<td><input type="button" value="중복확인" onclick="confirmName(this.form)"></td>
		</tr>
		<tr>
			<td>주민번호*</td>  
			<td><%=dto.getId_number().substring(0, 6)%>
			-<%=dto.getId_number().charAt(dto.getId_number().length()-1) %>
			</td>
		</tr> 
		<tr>
			<td>채식주의 타입</td>
			<td>
				<select name="vegi_type">
						<option value="비건">비건</option>
						<option value="락토 베지터리언">락토 베지터리언</option>
						<option value="오보 베지터리언">오보 베지터리언</option>
						<option value="락토 오보 베지터리언">락토 오보 베지터리언</option>
						<option value="페스코 베지터리언">페스코 베지터리언</option>
						<option value="폴로 베지터리언">폴로 베지터리언</option>
						<option value="플렉시터리언">플렉시터리언</option>
				</select> 
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정"/>
				<input type="reset" name="reset" value="재입력" />
				<input type="button" value="취소" onclick="window.location='main.jsp'"/>
			</td> 
		</tr>
	</table> 
	</form>
</body>
<%} %>
</html>