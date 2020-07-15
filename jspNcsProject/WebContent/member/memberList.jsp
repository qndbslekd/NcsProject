<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../team05_style.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="../header.jsp"></jsp:include>
<%
	if(!session.getAttribute("memId").equals("admin")){%>
		<script>
			alert("관리자 페이지 입니다.");
			window.location="main.jsp";
		</script>
	<%}else{
		
		int pageSize=10;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null){
			pageNum = "1";
		}
		
		int currPage = Integer.parseInt(pageNum);
		int startRow = (currPage -1) * pageSize + 1;
		int endRow = currPage * pageSize;
		int count = 0;
		int number = 0;
		
		MemberDAO dao = MemberDAO.getInstance();
		count = dao.selectAllMember();
		
		if(count > 0){
			//dao.getSearchMemberList(startRow, endRow);
		}
	%>

<body>
	<br/>
	<h1 align="center"> 회원목록 </h1>
	<%if(count == 0){ %>
		<table>
			<tr>
				<td> 가입한 회원이 없습니다.</td>
			</tr>
			<tr>
				<td><button onclick="window.location='main.jsp'">메인으로</button></td>
			</tr>				
		</table>
	<%}else{ %>
		<table>
			<tr>
				<td> 회원 ID </td>
				<td> PW </td>
				<td> 생년월일 </td>
				<td> 성별 </td>
				<td> 이름 </td>
				<td> 가입일 </td>
				<td> 신고누적횟수</td>
				<td> 신고당한 게시글</td>
				<td> 활동정지 </td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td><button onclick="window.location='main.jsp'">메인으로</button></td>
			</tr>				
		</table>	
	<%} %>
</body>
<%}%>
</html>