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
.t {	
	border-top:2px solid #ccc;
}

.t>td{
	font-size:1.4em;
	text-align:center;
	padding:5px;
	padding-left: 20px;
	padding-right: 20px;
}

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
	<hr>
	<form>
	<%if(count == 0){ %>
		<div style="margin: 20px;"></div>
		<table>
			<tr class="t" >
				<td > 번호 </td> 
				<td > 제목 </td>
				<td > 내용 </td>
				<td > 작성일 </td>
			</tr> 
			<tr class="t">
				<td colspan="4" > 정보글이 없습니다. </td>
			</tr>
		<%if(session.getAttribute("memId")!=null&&session.getAttribute("memId").equals("admin")){ %>
			<tr class="t">
				<td>
					<button type="button" onclick="window.location='informationInsertForm.jsp'">글쓰기</button>
				</td>
			</tr>		
		<%}%>		
		</table>
	<%}else{%>
		<div style="margin: 20px;"></div>
		<table>
			<tr class="t" >
				<td> 번호 </td>
				<td> 제목 </td>
				<td> 작성일 </td>
			</tr>
		<%for(int i =0;i<infoList.size();i++){
			 %>
			<tr class="t">
				<td><%=number--%></td>
				<td><a href="information.jsp?num=<%=infoList.get(i).getNum()%>"><%=infoList.get(i).getSubject()%></a></td>
				<td><a href="information.jsp?num=<%=infoList.get(i).getNum()%>"><%=sdf.format(infoList.get(i).getReg())%></a></td>
			</tr>
		<%} %>
		<%if(session.getAttribute("memId")!=null&&session.getAttribute("memId").equals("admin")){ %>
			<tr>
				<td colspan="3">&nbsp;</td> 
			</tr>
			<tr>
				<td colspan="3">
					<button type="button" onclick="window.location='informationInsertForm.jsp'" class="grayButton" style="width: 80px; height: 30px; text-align: center">글쓰기</button>
				</td>
			</tr>
		<%} %>
		</table>
	<%} %>
	</form>
	<div style="margin: 5px;"></div>
	<div class="paging">
		<%
			if(count >0){
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				int pageBlock = 10;		
				int startPage = (int)((currPage-1)/pageBlock)*pageBlock +1;	// 1 11 21 ...
				int endPage = startPage + pageBlock -1;	// 10 20 30 ...
				if(endPage > pageCount) endPage = pageCount;
				if(startPage > pageBlock){%>
					<div class="page" style="cursor:pointer;" onclick="window.location='informationList.jsp?pageNum=<%=startPage-pageBlock%>'">&lt;</div>
				<%}
				for(int i =startPage; i<= endPage; i++){%>
					<div class="page" style="cursor:pointer;" onclick="window.location='informationList.jsp?pageNum=<%=i%>'">&nbsp;<%=i %></div>
				<%}
				if(endPage < pageCount){%>
					<div class="page" style="cursor:pointer;" onclick="window.location='informationList.jsp?pageNum=<%=startPage+pageBlock%>'">&gt;</div>
				<%}
			}
		%>
	</div> 
	<br/>
	<jsp:include page="../footer.jsp" flush="false"/>
</body>
</html>