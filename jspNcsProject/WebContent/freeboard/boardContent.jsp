<%@page import="jspNcsProject.dao.RecommendDAO"%>
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
<style>
	#f-content{
		margin-top: 70px;
		width: 500px;
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
		border: 1px solid black;
		width:500px;
		height:500px;
		resize : none;
		border : 0px;
		padding: 10px;
	}
	


</style>
</head>
<%
if(request.getParameter("num") == null){%>
	<script>
		alert("잘못된 접근입니다.");
		history.go(-1);
	</script><%
}else{
	int num = Integer.parseInt(request.getParameter("num"));

	String pageNum = request.getParameter("pageNum");
	String mode= request.getParameter("mode");
	String category = request.getParameter("category");
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	
	String route = request.getParameter("route");
	if(route==null || route.equals("")){
		route = "board";
	}
	
	FreeBoardDAO dao = FreeBoardDAO.getInstance();
	
	FreeBoardDTO article = dao.selectArticle(num,route);
	//활동명 받아오기
	String name = dao.selectNameById(article.getWriter());
	
	
	//추천기능
	RecommendDAO Rdao = RecommendDAO.getInstance();
	
		
%>
<body>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="freeboard" name="mode"/>
	</jsp:include>
		<table id="f-content">
			<tr>
				<td>TITLE</td>			
				<td><%=article.getTitle()%></td>		
			</tr>
			<tr>
				<td>LIKE</td>
				<td><%=article.getRecommend()%>
				<%if(session.getAttribute("memId")!=null){%>
				<button onclick="window.location='recommendArticle.jsp?freeboard_num=<%=article.getNum()%>&mem_id=<%=session.getAttribute("memId")%>&pageNum=<%=pageNum%>'">추천하기</button>
				<%}%>
			</tr>
			<tr>
				<td>HIT</td>
				<td><%=article.getRead_count()%></td>
			</tr>
			<tr>
				<td>WRITER</td>
				<td><%=name%></td>		
			</tr>
			<tr>
				<td>CATEGORY</td>
				<td>
					<%if(article.getCategory().equals("notice")){%>공지사항<%}%>
					<%if(article.getCategory().equals("question")){%>고민과질문<%}%>
					<%if(article.getCategory().equals("freetalk")){%>잡담과일기<%}%>
					<%if(article.getCategory().equals("information")){%>정보 공유<%}%>
				</td>				
			</tr>
			<tr>
				<td>CONTENT</td>
				<td>
					<textarea class="contents" readonly><%=article.getContent()%></textarea>
				</td>		
			</tr>
			<%if(article.getImg() !=null && !article.getImg().equals("")){%>
			<tr>
				<td>이미지</td>
				<td><img src="/jnp/freeboard/save/<%=article.getImg()%>" width="200px"/></td>		
			</tr>
			<%}%>
			<tr>
				<td colspan='2'>
				<%if(article.getWriter().equals((String)session.getAttribute("memId"))){%>
					<input type="button" value="수정" onclick="window.location='boardModifyForm.jsp?num=<%=article.getNum()%>'"/>
				<%}%>
				<%if(article.getWriter().equals((String)session.getAttribute("memId")) || ((String)session.getAttribute("memId")).equals("admin")){ %>
					<input type="button" value="삭제" onclick="deleteArticle('<%=num%>')"/>
				<%} %>
				<%if(session.getAttribute("memId")!=null && !(article.getWriter().equals((String)session.getAttribute("memId")))){%>
					<input type="button" value="신고" onclick="report('F','<%=article.getNum()%>','<%=article.getWriter()%>')" />
 				<%}%>
					<input type="button" value="뒤로" onclick="window.location='board.jsp?mode=<%=mode%>&category=<%=category%>&sel=<%=sel%>&search=<%=search%>&pageNum=<%=pageNum%>'"/>
				</td>		
			</tr>
		</table>
	</form>	
	<br/>	
	<jsp:include page="boardComment.jsp">
		<jsp:param value="<%=num%>" name="num"/>
	</jsp:include>
</body>
<%} %>
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