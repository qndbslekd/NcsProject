<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글 작성하기</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
</head>
<%
	int num = 0, ref=1,re_step=0, re_level=0; 
	boolean reCh = false;
	if(request.getParameter("num") != null && !request.getParameter("num").equals("")) reCh= true;
	if(reCh==true){
		num = Integer.parseInt(request.getParameter("num"));
		ref = Integer.parseInt(request.getParameter("ref"));
		re_level = Integer.parseInt(request.getParameter("re_level"));
		re_step = Integer.parseInt(request.getParameter("re_step"));
	}


%>
<body>
<h1 align="center">글 작성하기</h1>
<form action="boardInsertPro.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="num" value="<%=num %>"/>
		<input type="hidden" name="ref" value="<%=ref%>"/>
		<input type="hidden" name="re_step" value="<%=re_step %>"/>
		<input type="hidden" name="re_level" value="<%=re_level%>"/>
		<input type="hidden" name="writer" value="<%=session.getAttribute("memId")%>"/>
	<table>
		<tr>
			<td>제목</td>
			
			<td><input type="text" name="title" <%if(reCh==true){%>value="[re]"<%}%>/></td>		
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=session.getAttribute("memName")%></td>		
		</tr>
		<tr>
			<td>카테고리</td>
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
			<td>내용</td>
			<td><textarea rows="20" cols="100" name="content"></textarea></td>		
		</tr>
		<tr>
			<td>이미지</td>
			<td><input type="file" name="img"/></td>		
		</tr>
		<tr>
			<td colspan='2'>
				<input type="submit" value="작성"/>
				<input type="button" value="취소" onclick="histoy.go(-1)"/>
			</td>		
		</tr>
	</table>
</form>
</body>
</html>