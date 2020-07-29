<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글 작성하기</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
<style>
	#f-content{
		margin-top: 70px;
		width: 700px;
		height: auto;
		overflow: hidden;
	}

	#f-content tr{
		height: 30px;
	
	}
	#f-content td{
		border-top: 1px solid #999;
		border-buttom: 1px solid #999;
		
	}
	
	.contents {
		width:300px;
		height:500px;
		resize : none;
		border : 0px;
		padding: 10px;
	}


</style>
</head>
<%
	if(session.getAttribute("memId") == null ){%>
	<script>
		alert("잘못된 접근입니다.");
		history.go(-1);
	</script>
	<% }else{

	int num = 0, ref=1,re_step=0, re_level=0; 
	boolean reCh = false;
	if(request.getParameter("num") != null && !request.getParameter("num").equals("")) reCh= true;
	if(reCh==true){
		num = Integer.parseInt(request.getParameter("num"));
	}


%>
<body>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="freeboard" name="mode"/>
	</jsp:include>
	<br/>
<h1 align="center">글 작성하기</h1>
<form action="boardInsertPro.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="num" value="<%=num %>"/>
		<input type="hidden" name="writer" value="<%=session.getAttribute("memId")%>"/>
	<table id="f-content">
		<tr>
			<td style="width:100px;">제목</td>		
			<td><input type="text" name="title" style="width:300px" <%if(reCh==true){%>value="[re]"<%}%>/></td>		
		</tr>
		<tr>
			<td style="width:100px;">작성자</td>
			<td><%=session.getAttribute("memName")%></td>		
		</tr>
		<tr>
			<td style="width:100px;">카테고리</td>
			<td>
				<select name="category">
				<%	if(session.getAttribute("memId")!= null && ((String)(session.getAttribute("memId"))).equals("admin")){%>
					<option value="notice">공지사항</option>
				<%	}%>			
					<option value="question">고민과 질문</option>
					<option value="information">정보 공유</option>
					<option value="freetalk">잡담과일기</option>			
				</select>
			</td>		
		</tr>
		<tr>
			<td style="width:100px;">내용</td>
			<td><textarea rows="20" cols="100" name="content" class="contents"></textarea></td>		
		</tr>
		<tr>
			<td style="width:100px;">이미지</td>
			<td><input type="file" name="img"/></td>		
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td colspan='2'>
				<input type="submit" value="작성"/>
				<input type="button" value="취소" onclick="histoy.go(-1)"/>
			</td>		
		</tr>
	</table>
</form>
</body>
<%}%>
</html>