<%@page import="java.sql.Timestamp"%>
<%@page import="jspNcsProject.dto.FreeBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="jspNcsProject.dao.FreeBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="resource/team05_style.css" rel="stylesheet" type="text/css">
<title>자유게시판</title>
<style>
	.paging{
		width: 960px;
		margin: 0 auto;
		text-align: center;
		
	}
	.page{
		display: inline-block;
		color : black;
	}

</style>
</head>
<%
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum  = "1";
	}
	int pageSize= 10;
	int currPage = Integer.parseInt(pageNum);
	int startRow = (currPage-1)*pageSize+1;
	int endRow = currPage*pageSize;
	
	//글개수
	int count = 0;
	int newCount =0;//오늘 글개수
	int number = 0;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	//오늘날짜뽑기
	SimpleDateFormat todayFormat = new SimpleDateFormat("yyyy-MM-dd");
	String today = todayFormat.format(new Date());
	Date today_todate = todayFormat.parse(today);
	
	FreeBoardDAO dao = FreeBoardDAO.getInstance();
	
	String sel = request.getParameter("sel");//검색조건
	String search = request.getParameter("search"); //검색결과
	
	List articleList = null;
	count = dao.getArticlesCount();

	if(sel != null && search != null){
		//검색 요청 찾기
		//count = dao.getSearchArticleCount(sel,search);
		//if(count > 0 ){
			//검색 요청한 글 리스트 가져오기
			//articles = dao.getSearchArticles(startRow, endRow, sel, search);
		//}		
	}else{
		if( count > 0 ){
			newCount = dao.getArticlesCount(new Timestamp(today_todate.getTime()));
			articleList = dao.selectArticles(startRow, endRow);
		}
	}
	number = count -(currPage-1)*pageSize;
	

%>
<body>
	<jsp:include page="../header.jsp" flush="false"/>
	<h1 align="center"></h1>
	
	<%if(count == 0){ %>
		<table>
		<%if(session.getAttribute("memId")!= null){ %>
			<tr>
				<td>
					<button onclick="window.location='boardInsertForm.jsp'">글쓰기</button>			
				</td>
				<td colspan='5'>
				</td>
			</tr>
		<%}%>
			<tr>
				<td>게시글이 없습니다.</td>
			</tr>		
		</table>	
	<%}else{ %>
		<table>
		<%if(session.getAttribute("memId")!= null){ %>
			<tr>
				<td>
					<button onclick="window.location='boardInsertForm.jsp'">글쓰기</button>			
				</td>
				<td colspan='5'>
				</td>
			</tr>
		<%}%>
			<tr>
				<td colspan='2'>
					<p>새글 <%=newCount%>/<%=count%><p>
				</td>
				<td colspan='4'>
					<select name="category">
						<option value="total">카테고리</option>
						<option value="notice">공지사항</option>
						<option value="question">고민과 질문</option>
						<option value="information">정보 공유</option>
						<option value="freetalk">잡담과일기</option>
					</select>
					<select name="sel">
						<option value="total">검색조건</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="writer">작성자</option>
					</select>
					<input type="text" name="search"/>
				</td>				
			</tr>
			<tr>
				<td>글번호</td>
				<td>[말머리]</td>
				<td>제목</td>
				<td>글쓴이</td>
				<td>조회수</td>
				<td>추천수</td>
			</tr>
			<%
				for(int i = 0; i< articleList.size();i++){
					FreeBoardDTO dto = (FreeBoardDTO)(articleList.get(i));
					//활동명 받아오기
					String name = dao.selectNameById(dto.getWriter());
			%>
			<tr>
				<td><%=number--%></td>
				<td><%=dto.getCategory()%></td>
				<td onclick="window.location='boardContent.jsp?num=<%=dto.getNum()%>'"><%=dto.getTitle()%></td>
				<td><%=name%></td>
				<td><%=dto.getRead_count()%></td>
				<td><%=dto.getRecommend()%></td>
			</tr>
			<%} %>
		</table>
	<%} %>
	
	<div class="paging">
	<%
		if(count>0){
			int pageCount = count/pageSize + (count%pageSize == 0 ? 0 :1);
			int pageBlock = 10;

			int startPage = ((currPage-1)/pageBlock)*pageBlock + 1;
			int endPage = startPage + pageBlock -1 ;
			
			if(endPage > pageCount) endPage = pageCount; 
			
			if(startPage > pageBlock){%>
				<div class="page" onclick="window.location='board.jsp?pageNum=<%=startPage-pageBlock%>'">&lt;</div>
			<%}
			for(int i = startPage ; i<= endPage; i++){%>
				<div class="page" onclick="window.location='board.jsp?pageNum=<%=i%>'">&nbsp;<%=i %></div>	
			<%
			}			
			if(endPage > pageCount){%>
				<div class="page" onclick="window.location='board.jsp?pageNum=<%=startPage+pageBlock%>'">&gt;</div>		
			<%}	
		}
	%>	
	</div>

</body>
</html>