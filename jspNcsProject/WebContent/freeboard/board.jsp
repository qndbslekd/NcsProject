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
	
	.list{
		overflow: hidden;
		height: auto;
		width:1000px; 
		align:center; 
		margin:0 auto;
	
	}
	.write_button{
		width:90px;
		float:left;
		border: 1px solid #DADBD7;
		padding: 5px 7px 5px 7px;
		background-color: rgb(139, 195, 74);
		color: white;
		cursor: pointer;
		border-radius : 5px;
		font-size:15px;
		
	}
	.buttn{
		width:70px;
		float:left;
		border: 1px solid #DADBD7;
		padding: 3px 7px 3px 7px;
		cursor: pointer;
		
	}
	#selected{
		background-color: #8bc34a;
		color: white;
		cursor: pointer;
	}
	
	table{
		border-collapse: collapse;
	
	}
	
	.sub{
		width:1000px;
		margin: 0 auto;
	
	
	}
	
	.fixedArticle{
		background-color: #d6e0f5;
	
	}
	
	.list-title{
		
		border-bottom: 1px solid black;
	}
	
	.link {
		cursor:pointer;
	}
	
	.link:hover, .link strong:hover {
		color:#ccc;
	}

</style>
<script>
	function check(){
		var inputs = document.searchForm;
		var sel = inputs.sel.value;
		var str ="";
		if(sel != "total" && !inputs.search.value){
			if(sel == "title"){
				str+="제목을"
			}
			if(sel =="writer"){
				str+="작성자를"
			}
			if(sel =="content"){
				str+="내용을"
			}
			str +=" 입력하세요."
			alert(str);
			return false;
		}
		
	}


</script>
</head>
<%
	request.setCharacterEncoding("utf-8");	
	
	//정렬기준
	String mode= request.getParameter("mode");// reg, recommend, read_count
	
	if(mode==null || mode.equals("")){
		mode = "reg";
	}
		
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
	
	//검색처리
	String category = request.getParameter("category");
	String sel = request.getParameter("sel");//검색조건
	String search = request.getParameter("search"); //검색결과
	
	
	if(category != null && category.equals("null")) {category=null;}
	if(sel != null &&sel.equals("null")) {sel=null;}
	if(search != null &&search.equals("null")) {search=null;}
	

	
	
	
	List articleList = null;
	

	if(category!= null && !category.equals("") && sel != null && !sel.equals("")){
		//검색 요청 찾기
		String whereQuery = "where 1=1 ";
		String name = "";
		//작성자명은 활동명이므로 검색시 쿼리문 검색을 위해 id를 받아와야함
			
		if(!category.equals("total") && !sel.equals("total")){		
			if(search!=null && !search.equals("")){
				if(sel.equals("writer")){
					//활동명->아이디
					name = dao.selectIdByName(search);
					whereQuery += "and category='"+category+"' and "+sel+" like '%"+name+"%'";
				}else{
					whereQuery += "and category='"+category+"' and "+sel+" like '%"+search+"%'";
				}		
			}
			
		}else if(!category.equals("total") && sel.equals("total")){
			whereQuery += "and category='"+category+"'";
		
		}else if(!sel.equals("total")){
			if(search!=null && !search.equals("")){
				if(sel.equals("writer")){
					//활동명->아이디
					name = dao.selectIdByName(search);
					whereQuery += "and "+sel+" like '%"+name+"%'";
				}else{
					whereQuery += "and "+sel+" like '%"+search+"%'";
				}		
			}
		}		
		
		count = dao.getArticlesCount(whereQuery);
		if(count > 0 ){
			//검색 요청한 글 리스트 가져오기
			newCount = dao.getArticlesCount(new Timestamp(today_todate.getTime()),whereQuery);
			articleList = dao.selectAllArticle(startRow, endRow, whereQuery, mode);
		}		
	}else{
		
		count = dao.getArticlesCount();
		
		if( count > 0 ){
			newCount = dao.getArticlesCount(new Timestamp(today_todate.getTime()));
			articleList = dao.selectAllArticle(startRow, endRow, mode);
		}
	}
	
	number = count -(currPage-1)*pageSize;
	
	//고정 리스트 가져오기
	int fCount = dao.getFixedArticleCount();
	List fixedArticles  = null;
	if(fCount>0){
		fixedArticles = dao.selectAllfixedArticle();	
	}
		
%>
<body>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="freeboard" name="mode"/>
	</jsp:include>
	<h1 align="center">자유게시판</h1>
	<table class="sub">
		<tr>
			<%if(session.getAttribute("memId")!= null){ %>
			<td style="width:100px">
				<button class="write_button" onclick="window.location='boardInsertForm.jsp'">글쓰기</button>			
			</td>
			<%}else{%>
			<td></td>
			<%} %>
		</tr>
		<tr>
			<td style="width:780px;"></td>
			<td >
				<button class="buttn" <%if(mode.equals("reg")){%>id="selected"<%}%> onclick="window.location='board.jsp?mode=reg&category=<%=category%>&sel=<%=sel%>&search=<%=search%>&pageNum=<%=pageNum%>'">최신순</button>
				<button class="buttn" <%if(mode.equals("read_count")){%>id="selected"<%}%> onclick="window.location='board.jsp?mode=read_count&category=<%=category%>&sel=<%=sel%>&search=<%=search%>&pageNum=<%=pageNum%>'">조회순</button>
				<button class="buttn" <%if(mode.equals("recommend")){%>id="selected"<%}%> onclick="window.location='board.jsp?mode=recommend&category=<%=category%>&sel=<%=sel%>&search=<%=search%>&pageNum=<%=pageNum%>'">추천순</button>
			</td>
			
		</tr>

		
	</table>
	<table class="list" >
		<thead>	
		<tr class="list-title">
			<th>NO</th>
			<th>CATEGORY</th>
			<th>TITLE</th>
			<th>WRITER</th>
			<th>DATE</th>
			<th>HIT</th>
			<th>LIKE</th>
		</tr>
		</thead>
	<%if(count == 0){ %>
		<tr>
			<td colspan='6'>게시글이 없습니다.</td>
		</tr>			
	<%}else{
		if(fCount > 0){
			for(int i = 0 ; i< fixedArticles.size(); i++){
				FreeBoardDTO fixedArticle = (FreeBoardDTO)(fixedArticles.get(i));
				String name = dao.selectNameById(fixedArticle.getWriter());%>
		<tr class="fixedArticle">
			<%if(fixedArticle.getCategory().equals("notice")){%>	
			<td><strong>공 지</strong></td>
			<%}else{ %>
			<td><strong>★</strong></td>
			<%}%>
			<%if(fixedArticle.getCategory().equals("notice")){%>	
			<td>공지사항</td>
			<%}else if(fixedArticle.getCategory().equals("freetalk")){%>	
			<td>잡담과일기</td>
			<%}else if(fixedArticle.getCategory().equals("information")){%>	
			<td>정보 공유</td>
			<%}else if(fixedArticle.getCategory().equals("question")){%>	
			<td>고민과질문</td>
			<%} %>
			<td class="link" style="text-align:left; cursor: pointer;" onclick="window.location='boardContent.jsp?num=<%=fixedArticle.getNum()%>&mode=<%=mode%>&category=<%=category%>&sel=<%=sel%>&search=<%=search%>&pageNum=<%=pageNum%>'"><strong><%=fixedArticle.getTitle()%></strong></td>
			<td ><%=name%></td>
			<td><%=sdf.format(fixedArticle.getReg())%></td>
			<td><%=fixedArticle.getRead_count()%></td>
			<td><%=fixedArticle.getRecommend()%></td>
		</tr>
			<% }		
		}
		
		for(int i = 0; i< articleList.size();i++){
			FreeBoardDTO dto = (FreeBoardDTO)(articleList.get(i));
			//활동명 받아오기
			String name = dao.selectNameById(dto.getWriter());
		%>
		<tr>
			<td><%=number--%></td>	
			<%if(dto.getCategory().equals("notice")){%>	
			<td>공지사항</td>
			<%} %>
			<%if(dto.getCategory().equals("freetalk")){%>	
			<td>잡담과일기</td>
			<%} %>
			<%if(dto.getCategory().equals("information")){%>	
			<td>정보 공유</td>
			<%} %>
			<%if(dto.getCategory().equals("question")){%>	
			<td>고민과질문</td>
			<%} %>
			<td class="link" style="text-align:left;" onclick="window.location='boardContent.jsp?num=<%=dto.getNum()%>&mode=<%=mode%>&category=<%=category%>&sel=<%=sel%>&search=<%=search%>&pageNum=<%=pageNum%>'"><%=dto.getTitle()%></td>
			<td ><%=name%></td>
			<td><%=sdf.format(dto.getReg())%></td>
			<td><%=dto.getRead_count()%></td>
			<td><%=dto.getRecommend()%></td>
		</tr>
		<%}
	}%>
	</table>
	
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
			<%}			
			if(endPage > pageCount){%>
				<div class="page" onclick="window.location='board.jsp?pageNum=<%=startPage+pageBlock%>'">&gt;</div>		
			<%}	
		}
	%>	
	</div>
	<form action="board.jsp" method="post" name="searchForm" onsubmit="return check()">
		<table>
			<tr>
				<td colspan='2'>
					<p>새글 <%=newCount%>/<%=count%><p>
				</td>
				<td colspan='4'>
					<select name="category">
						<option value="total" <%if(category != null && category.equals("total")){%>selected<%}%>>카테고리</option>
						<option value="question" <%if(category != null && category.equals("question")){%>selected<%}%>>고민과질문</option>
						<option value="information" <%if(category != null && category.equals("information")){%>selected<%}%>>정보 공유</option>
						<option value="freetalk" <%if(category != null && category.equals("freetalk")){%>selected<%}%>>잡담과일기</option>
					</select>
					<select name="sel">
						<option value="total" <%if(sel != null && sel.equals("total")){%>selected<%}%>>검색조건</option>
						<option value="title" <%if(sel != null && sel.equals("title")){%>selected<%}%>>제목</option>
						<option value="content" <%if(sel != null && sel.equals("content")){%>selected<%}%>>내용</option>
						<option value="writer" <%if(sel != null && sel.equals("writer")){%>selected<%}%>>작성자</option>
					</select>
					<input type="text" name="search"/>
				</td>	
				<td><input type="submit" value="검색"/></td>				
			</tr>
		</table>
	</form>

</body>
</html>