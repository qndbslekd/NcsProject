<%@page import="jspNcsProject.dto.FreeBoardDTO"%>
<%@page import="jspNcsProject.dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정폼</title>
<script>
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
</script>
</head>
<%

	if(session.getAttribute("memId") == null ){%>
	<script>
		alert("잘못된 접근입니다.");
	history.go(-1);
	</script>
	<% }else{

	int num = Integer.parseInt(request.getParameter("num"));
	
	FreeBoardDAO dao = FreeBoardDAO.getInstance();
	FreeBoardDTO article = dao.selectArticle(num,"modify");
	
	//활동명가져오기
	String name= dao.selectNameById(article.getWriter());
	

%>
<body>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="freeboard" name="mode"/>
	</jsp:include>
	<br/>
	<form action="boardModifyPro.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="writer" value="<%=article.getWriter()%>"/>
		<input type="hidden" name="num" value="<%=num%>"/>
		<table id="f-content">
			<tr>
				<td>제목</td>			
			<td><input type="text" name="title" value="<%=article.getTitle()%>"/></td>		
			</tr>
			<tr>
				<td>작성자</td>
				<td><%=name%></td>		
			</tr>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="category">
					<%	if(session.getAttribute("memId")!= null && ((String)(session.getAttribute("memId"))).equals("admin")){%>
						<option value="notice" <%if(article.getCategory().equals("notice")){%>selected<%}%>>공지사항</option>
					<%	}%>			
						<option value="question"<%if(article.getCategory().equals("question")){%>selected<%}%>>고민과 질문</option>
						<option value="information"<%if(article.getCategory().equals("information")){%>selected<%}%>>정보 공유</option>
						<option value="freetalk"<%if(article.getCategory().equals("freetalk")){%>selected<%}%>>잡담과일기</option>			
					</select>
				</td>		
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="20" cols="100" name="content"><%=article.getContent()%></textarea></td>		
			</tr>
			<tr>
				<td>이미지</td>
				<td><input type="file" name="img"/></td>		
			</tr>
			<tr>
				<td colspan='2'>
					<input type="submit" value="수정"/>
					<input type="button" value="취소" onclick="window.location='boardContent.jsp?num=<%=num%>'"/>
				</td>		
			</tr>
		</table>
	</form>
	<jsp:include page="../footer.jsp" flush="false"/>
</body>
<%} %>
</html>