<%@page import="java.text.SimpleDateFormat"%>
<%@page import="jspNcsProject.dto.FreeBoardDTO"%>
<%@page import="jspNcsProject.dao.FreeBoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dto.BoardCommentDTO"%>
<%@page import="jspNcsProject.dao.BoardCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myFreeboardCommentList</title>
<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
<style>

	#nonBorder {
		border:0px;
	}
	#nonBorder tr {
		border:0px;
	}
	#nonBorder td {
		border:0px;
	}

</style>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	BoardCommentDAO dao = BoardCommentDAO.getInstance();
	BoardCommentDTO dto = new BoardCommentDTO();
	String memId = (String)session.getAttribute("memId");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	
	
	int pageSize = 5; // 한 페이지에서 보여줄 게시글의 수
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){ // 처음 페이지를 킨 경우 null 값이 들어가니까 이 경우엔 pageNum에 1을 넣어줌 
		pageNum ="1";
	}
	
	int currPage = Integer.parseInt(pageNum);
	int startRow = (currPage - 1) * pageSize + 1;
	int endRow = currPage * pageSize;
	
	int count = 0;
	
	// 게시판에서 글 가져오기 
	count = dao.getMyFreeBoardCommentCount(memId);
	// 내가 쓴 글 전체 개수부터 가져오기
	List myFreeBoardCommentList = null;
	if(count > 0){// 글이 하나라도 있으면 가져오기 
		myFreeBoardCommentList  = dao.selectMyFreeBoardComment(startRow, endRow, memId);
	}
	
	if(memId == null){ %>
		<script>
			alert("로그인 후 이용하세요");
			window.location="loginForm.jsp";
		</script>
	<% }else{	

	
%>
<%-- 게시판 형태 만들기 --%>
<body>
<h3> [자유 게시판] </h3>
	<%-- 게시글이 없을 때 --%>
	<% if(count == 0){%>
		<table id="nonBorder">
			<tr>
				<td class="line">
					작성한 댓글이 없습니다.
				</td>
			</tr>
		</table>	
	<%
	}else{ %>
	<% for(int i = 0 ; i < myFreeBoardCommentList.size(); i++){
		dto = (BoardCommentDTO)myFreeBoardCommentList.get(i);
		int num = dto.getFreeboard_num();
		// 댓글의 freeboard_num == 원본글의 num
		
		FreeBoardDAO freeboardDAO = FreeBoardDAO.getInstance();
		FreeBoardDTO freeboardDTO = new FreeBoardDTO();
		freeboardDTO = freeboardDAO.selectParentArticle(num);
	%>
	<div onclick="location.href='../freeboard/boardContent.jsp?num=<%=num%>'">
	<table border="0" id="nonBorder">
		<tr>
			<td >
				원글제목 : <%= freeboardDTO.getTitle() %>
			</td>
		</tr>
		<tr>
			<td>
				댓글 내용 : <%= dto.getContent() %>
			</td>		
		</tr>
		<tr>
			<td>
				시간 : <%= sdf.format(dto.getReg()) %>
			</td>
		</tr>
	</table>
		<hr width="700px">
	</div>
	<%}
	%>
	<%} %>
	<br />
	<div align="center">
	<%-- 게시판 목록 페이지 번호 뷰어 설정 --%>
	<%
		if(count > 0){ // if1. 게시글이 있을 때만 보여줄 것임 
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 10;
			int startPage = (int)((currPage-1)/pageBlock)*pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount){endPage = pageCount;}
			if(startPage > pageBlock){ %>
				<a href="myCommentList.jsp?pageNum=<%= startPage-pageBlock%>&option=myFreeboardCommentList"> &lt; </a>
			<%}
			// 페이지 번호 뿌려주기
			for(int i = startPage; i <= endPage; i++){ %>
				<a href="myCommentList.jsp?pageNum=<%=i%>&option=myFreeboardCommentList" class="pageNums"> &nbsp; <%=i %> &nbsp; </a>
			<%}
			if(endPage < pageCount){ %>
				<a href="myCommentList.jsp?pageNum=<%=startPage+pageBlock%>&option=myFreeboardCommentList"> &gt; </a>
			<%}
		
		} // if1 끝
	
	%>
	</div>
</body>
	<%} %>
</html>