<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>자유게시판</title>
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
	//게시판 내 글번호
	int number = 0;
	

%>
<body>
	<table>
		<tr>
			<td>
				<p>새글 550/1655<p>
			</td>
			<td colspan='3'></td>
			<td></td>	
			<td></td>	
		</tr>
			<td>[말머리]</td>
			<td>제목</td>
			<td>글쓴이</td>
			<td>조회수</td>
			<td>추천수</td>
		<tr>
	</table>
	

</body>
</html>