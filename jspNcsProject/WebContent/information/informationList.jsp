<%@page import="jspNcsProject.dto.InfomationDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jspNcsProject.dao.InfomationDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="../header.jsp"></jsp:include>
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
<%
	int pageSize=10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	String pageNum = request.getParameter("pageNum");
	if(pageNum==null){
		pageNum = "1";
	}
	
	int currPage = Integer.parseInt(pageNum);
	int startRow = (currPage -1) * pageSize + 1;
	System.out.println(startRow);
	int endRow = currPage * pageSize;
	System.out.println(endRow);
	int count = 0;
	int number = 0;
	
	InfomationDAO dao = InfomationDAO.getInstance();
	List<InfomationDTO> infoList = null;
	
	System.out.println("ELSE");
	count = dao.getinfoCount();
	if(count > 0){
		infoList = dao.getInfomation(startRow, endRow);
	} 
	number = count - (currPage -1) * pageSize;
%>
<body>
<br/>
<h1 align="center"> 채식 정보 </h1>
	<form>
	<%if(count == 0){ %>
		<table>
			<tr>
				<td> 번호 </td>
				<td> 제목 </td>
				<td> 내용 </td>
				<td> 작성일 </td>
			</tr>
			<tr>
				<td colspan="4" > 정보글이 없습니다. </td>
			</tr>
		<%if(session.getAttribute("memId")!=null&&session.getAttribute("memId").equals("admin")){ %>
			<tr>
				<td>
					<button type="button" onclick="window.location='informationInsertForm.jsp'">글쓰기</button>
				</td>
			</tr>		
		<%}%>		
		</table>
	<%}else{%>
		<table>
			<tr>
				<td> 번호 </td>
				<td> 제목 </td>
				<td> 작성일 </td>
			</tr>
		<%for(int i =0;i<infoList.size();i++){
			 %>
			<tr>
				<td><%=number--%></td>
				<td><a href="information.jsp?num=<%=infoList.get(i).getNum()%>"><%=infoList.get(i).getSubject()%></a></td>
				<td><a href="information.jsp?num=<%=infoList.get(i).getNum()%>"><%=infoList.get(i).getReg()%></a></td>
			</tr>
		<%} %>
		<%if(session.getAttribute("memId")!=null&&session.getAttribute("memId").equals("admin")){ %>
			<tr>
				<td>
					<button type="button" onclick="window.location='informationInsertForm.jsp'">글쓰기</button>
				</td>
			</tr>
		<%} %>
		</table>
	<%} %>
	</form>
	<div class="paging">
		<%
			if(count >0){
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				int pageBlock = 10;		
				int startPage = (int)((currPage-1)/pageBlock)*pageBlock +1;	// 1 11 21 ...
				int endPage = startPage + pageBlock -1;	// 10 20 30 ...
				if(endPage > pageCount) endPage = pageCount;
				if(startPage > pageBlock){%>
					<div class="page" onclick="window.location='informationList.jsp?pageNum=<%=startPage-pageBlock%>'">&lt;</div>
				<%}
				for(int i =startPage; i<= endPage; i++){%>
					<div class="page" onclick="window.location='informationList.jsp?pageNum=<%=i%>'">&nbsp;<%=i %></div>
				<%}
				if(endPage < pageCount){%>
					<div class="page" onclick="window.location='informationList.jsp?pageNum=<%=startPage+pageBlock%>'">&gt;</div>
				<%}
			}
		%>
		</div> 
</body>
</html>