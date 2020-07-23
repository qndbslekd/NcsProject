<%@page import="jspNcsProject.dto.FreeBoardDTO"%>
<%@page import="jspNcsProject.dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
<title>글 상세보기</title>
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));

	String pageNum = request.getParameter("pageNum");
	String mode= request.getParameter("mode");
	String category = request.getParameter("category");
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	
	
	FreeBoardDAO dao = FreeBoardDAO.getInstance();
	FreeBoardDTO article = dao.selectArticle(num);
	//활동명 받아dhdl
	String name = dao.selectNameById(article.getWriter());
		
%>
<body>
<jsp:include page="../header.jsp"/>
		<table>
		

			<tr>
				<td>제목</td>			
				<td><%=article.getTitle()%></td>		
			</tr>
			<tr>
				<td>추천수</td>
				<td><%=article.getRecommend()%>
				<%if(session.getAttribute("memId")!=null){%>
				<td><button onclick="window.location='recommendArticle.jsp?num=<%=article.getNum()%>'">추천하기</button></td>
				<%}%>
			</tr>
			<tr>
				<td>조회수</td>
				<td><%= article.getRead_count()%></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%=name%></td>		
			</tr>
			<tr>
				<td>카테고리</td>
				<td><%=article.getCategory()%></td>		
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="20" cols="100" name="content" readonly><%=article.getContent()%></textarea></td>		
			</tr>
			<tr>
				<td>이미지</td>
				<td><img src="/jnp/freeboard/save/<%=article.getImg()%>" width="200px"/></td>		
			</tr>
			<tr>
				<td colspan='2'>
				<%if(article.getWriter().equals((String)session.getAttribute("memId"))){%>
					<input type="button" value="수정" onclick="window.location='boardModifyForm.jsp?num=<%=article.getNum()%>'"/>
					<input type="button" value="삭제" onclick="deleteArticle('<%=num%>')"/>
				<%}%>
				<%if(session.getAttribute("memId")!=null && !(article.getWriter().equals((String)session.getAttribute("memId")))){%>
					<input type="button" value="신고" onclick="report('F','<%=article.getNum()%>','<%=article.getWriter()%>')" />
 				<%}%>
					<input type="button" value="뒤로" onclick="window.location='board.jsp?mode=<%=mode%>&category=<%=category%>&sel=<%=sel%>&search=<%=search%>&pageNum=<%=pageNum%>'"/>
				</td>		
			</tr>
		</table>
	</form>
	
	<jsp:include page="boardComment.jsp">
		<jsp:param value="<%=num%>" name="num"/>
	</jsp:include>
</body>
<script>
	//글 삭제확인
	function deleteArticle(num) {
		if(confirm("정말 삭제하시겠습니까?")){
			window.location="boardDeletePro.jsp?num="+num;
		}		
	}
	//신고 기능
	function report(code,commentNum,member) {
		if(confirm("이 글을 신고하시겠습니까?")==true) {
			var offenceCode = code+commentNum;
			location.href= "../member/offenceMember.jsp?offenceUrl="+offenceCode+"&member="+member;
		}		
	}

</script>

</html>