<%@page import="jspNcsProject.dao.FreeBoardDAO"%>
<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="jspNcsProject.dao.RecipeContentCommentDAO"%>
<%@page import="jspNcsProject.dao.RecipeCommentDAO"%>
<%@page import="jspNcsProject.dto.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../team05_style.css" rel="stylesheet" type="text/css">
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
	if(session.getAttribute("memId")==null||!session.getAttribute("memId").toString().equals("admin")){%>
		<script>
			alert("관리자 페이지 입니다.");
			window.location="main.jsp";
		</script>
	<%}else{
		
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
		
		MemberDAO dao = MemberDAO.getInstance();
		
		String option = request.getParameter("option");
		String offence = request.getParameter("offence");
		String search = request.getParameter("search");
		
		System.out.println("Roffence : "+request.getParameter("offence"));
		System.out.println("Roption : "+request.getParameter("option"));
		System.out.println("Rsearch : "+request.getParameter("search"));
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();
		
		if(search==null||search.equals("")){
			if(offence==null){
				count = dao.selectAllMember();
				if(count > 0){
					memberList = dao.getSearchMemberList(startRow, endRow);
				}
				System.out.println("LIST SIZE : "+memberList.size());
			}else if(offence.equals("1")){
				count = dao.selectAllMemberByOffence();
				if(count > 0){
					memberList = dao.getSearchMemberListByOffence(startRow, endRow);
				}
				System.out.println("LIST SIZE : "+memberList.size());				
			}
		}else{
			count = dao.selectAllMember(option,search);
			System.out.println("Search Count"+count);
			if(count > 0){
				memberList = dao.getSearchMemberList(startRow, endRow,option,search);
			}
			System.out.println("LIST SIZE : "+memberList.size());
		}
		
		//seq로 각테이블 접근
		RecipeCommentDAO rcDao = RecipeCommentDAO.getInstance();
		RecipeContentCommentDAO rccDao = RecipeContentCommentDAO.getInstance(); 
		ProductDAO pDao = ProductDAO.getInstance();
		FreeBoardDAO fDao = FreeBoardDAO.getInstance();
	%>

<body>
	<br/>
	<h1 align="center"> 회원목록 </h1>
	<%if(count == 0){ %>
		<table>
			<tr>
				<td> 가입한 회원이 없습니다.</td>
			</tr>
			<tr>
				<td><button onclick="window.location='main.jsp'">메인으로</button></td>
			</tr>				
		</table>
	<%}else{ %>
		<table>
			<tr>
				<td> 회원 ID </td>
				<td> PW </td>
				<td> 생년월일 </td>
				<td> 성별 </td>
				<td> 닉네임 </td>
				<td> 가입일 </td>
				<td> 신고누적횟수</td>
				<td> 신고당한 게시글</td>
				<td> 활동상태 </td>
				<td> 강퇴 </td>
			</tr>
			<%for(int i =0;i<memberList.size();i++){%>
				<%if(memberList.get(i).getOffence_count()>=5){%> 
				<tr>
					<td style="background-color: red;"><%=memberList.get(i).getId()%></td>
					<td style="background-color: red;"><%=memberList.get(i).getPw()%></td>
					<td style="background-color: red;"><%=memberList.get(i).getAge()%></td>
					<td style="background-color: red;"><%=memberList.get(i).getGender()%></td>
					<td style="background-color: red;"><%=memberList.get(i).getName()%></td>
					<td style="background-color: red;"><%=memberList.get(i).getRegdate()%></td>
					<td style="background-color: red;"><%=memberList.get(i).getOffence_count()%></td>
					<td style="background-color: red;">
						<%
							if(memberList.get(i).getOffence_url()!=null){
								String[] urls = memberList.get(i).getOffence_url().split(",");
								for(int splitUrls = 0;splitUrls<urls.length;splitUrls++){
									//테이블 고유번호
									String seq = "";
									if(urls[splitUrls].contains("RCC")){
										seq = rccDao.selectSeqForMemberList(urls[splitUrls].substring(3));
										%> <a href="http://localhost:8080/jnp/recipe/recipeContent.jsp?num=<%=seq%>">조리단계댓글</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
									}else if(urls[splitUrls].contains("RC")){
										seq = rcDao.selectSeqForMemberList(urls[splitUrls].substring(2));
										%> <a href="http://localhost:8080/jnp/recipe/recipeContent.jsp?num=<%=seq%>">레시피댓글</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
									}else if(urls[splitUrls].contains("R")){
										seq = urls[splitUrls].substring(1);
										%> <a href="http://localhost:8080/jnp/recipe/recipeContent.jsp?num=<%=seq%>">레시피</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
									}else if(urls[splitUrls].contains("PC")){
										//댓글구분
										String booleanCheckNum = urls[splitUrls].substring(2);
										boolean isComment = pDao.isComment(booleanCheckNum);
										if(isComment){
											seq = pDao.getSeq(booleanCheckNum);
										%> <a href="http://localhost:8080/jnp/product/productContent.jsp?num=<%=seq%>">제품댓글</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
										}else{
											seq = urls[splitUrls].substring(2);
										%> <a href="http://localhost:8080/jnp/product/productContent.jsp?num=<%=seq%>">제품</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
										}
									}else if(urls[splitUrls].contains("FC")){
										String booleanCheckNum = urls[splitUrls].substring(2);
										boolean isComment = pDao.isComment(booleanCheckNum);
										if(isComment){
											seq = fDao.getSeq(booleanCheckNum);
											%>
											 <a href="http://localhost:8080/jnp/freeboard/boardContent.jsp?num=<%=seq%>">제품댓글</a>
												<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
												v</button>
											<%
										}
									}else if(urls[splitUrls].contains("F")){
										seq = urls[splitUrls].substring(1);
										%> <a href="http://localhost:8080/jnp/freeboard/boardContent.jsp?num=<%=seq%>">자유게시판</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
									}
								} 
							}
						%>
					</td>
					<td style="background-color: red;"><%=memberList.get(i).getState()%></td>
					<td style="background-color: red;">
					<%if(!memberList.get(i).getId().equals("admin")){
						if(memberList.get(i).getState().equals("활동")){%>
							<button onclick="window.location='memberKickOutPro.jsp?id=<%=memberList.get(i).getId() %>'" >강퇴</button>					
					<%}else if(memberList.get(i).getState().equals("강퇴")){%>
							<button onclick="window.location='memberKickOutPro.jsp?id=<%=memberList.get(i).getId() %>'" >강퇴취소</button>										
					<%}
					}%>
					</td>
				</tr>	
				<%}else{%>
				<tr> 
					<td><%=memberList.get(i).getId()%></td>
					<td><%=memberList.get(i).getPw()%></td>
					<td><%=memberList.get(i).getAge()%></td>
					<td><%=memberList.get(i).getGender()%></td>
					<td><%=memberList.get(i).getName()%></td>
					<td><%=memberList.get(i).getRegdate()%></td>
					<td><%=memberList.get(i).getOffence_count()%>
					</td>
					<td>
					
						<%
							if(memberList.get(i).getOffence_url()!=null){
								String[] urls = memberList.get(i).getOffence_url().split(",");
								for(int splitUrls = 0;splitUrls<urls.length;splitUrls++){
									//테이블 고유번호
									String seq = "";
									if(urls[splitUrls].contains("RCC")){
										seq = rccDao.selectSeqForMemberList(urls[splitUrls].substring(3));
										%> <a href="http://localhost:8080/jnp/recipe/recipeContent.jsp?num=<%=seq%>">조리단계댓글</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
									}else if(urls[splitUrls].contains("RC")){
										seq = rcDao.selectSeqForMemberList(urls[splitUrls].substring(2));
										%> <a href="http://localhost:8080/jnp/recipe/recipeContent.jsp?num=<%=seq%>">레시피댓글</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
									}else if(urls[splitUrls].contains("R")){
										seq = urls[splitUrls].substring(1);
										%> <a href="http://localhost:8080/jnp/recipe/recipeContent.jsp?num=<%=seq%>">레시피</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
									}else if(urls[splitUrls].contains("PC")){
										//댓글구분
										String booleanCheckNum = urls[splitUrls].substring(2);
										boolean isComment = pDao.isComment(booleanCheckNum);
										if(isComment){
											seq = pDao.getSeq(booleanCheckNum);
										%> <a href="http://localhost:8080/jnp/product/productContent.jsp?num=<%=seq%>">제품댓글</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
										}else{
											seq = urls[splitUrls].substring(2);
										%> <a href="http://localhost:8080/jnp/product/productContent.jsp?num=<%=seq%>">제품</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
										}
									}else if(urls[splitUrls].contains("FC")){
										String booleanCheckNum = urls[splitUrls].substring(2);
										boolean isComment = pDao.isComment(booleanCheckNum);
										if(isComment){
											seq = fDao.getSeq(booleanCheckNum);
											%>
											 <a href="http://localhost:8080/jnp/freeboard/boardContent.jsp?num=<%=seq%>">제품댓글</a>
												<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
												v</button>
											<%
										}
									}else if(urls[splitUrls].contains("F")){
										seq = urls[splitUrls].substring(1);
										%> <a href="http://localhost:8080/jnp/freeboard/boardContent.jsp?num=<%=seq%>">자유게시판</a>
											<button type="button" onclick="window.open('memberOffenceUpdate.jsp?url=<%=urls[splitUrls] %>&id=<%=memberList.get(i).getId()%>','신고확정','toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 500,height = 150');">
											v</button>
										<%
									}
								} 
							}
						%>
					</td>
					<td><%=memberList.get(i).getState()%></td>
					<td>
					<%if(!memberList.get(i).getId().equals("admin")){
						if(memberList.get(i).getState().equals("활동")){%>
							<button onclick="window.location='memberKickOutPro.jsp?id=<%=memberList.get(i).getId()%>&option=kickOff'" >강퇴</button>					
					<%}else if(memberList.get(i).getState().equals("강퇴")){%>
							<button onclick="window.location='memberKickOutPro.jsp?id=<%=memberList.get(i).getId()%>&option=kickOffCancle'" >강퇴취소</button>										
					<%}
					}%>
					</td>
				</tr>
			<%		}
				}%>
			<tr> 
				<td colspan="10">
					<button onclick="window.location='../main.jsp'">메인으로</button>
					<button onclick="window.location='memberList.jsp?offence=1'">신고받은 회원 조회</button>
					<form action="memberList.jsp" method="get">
					<select name="option">
							<option value="id">id</option>
							<option value="name">활동명</option>
					</select>
					<input type="text" name="search" /> <input type="submit" value="검색" />
					</form>
				</td>
			</tr>				 
		</table>	
		<br/>
		<div class="paging">
		<%
			if(count >0){
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				int pageBlock = 10;		
				int startPage = (int)((currPage-1)/pageBlock)*pageBlock +1;	// 1 11 21 ...
				int endPage = startPage + pageBlock -1;	// 10 20 30 ...
				if(endPage > pageCount) endPage = pageCount;
				if(startPage > pageBlock){%>
					<div class="page" onclick="window.location='memberList.jsp?pageNum=<%=startPage-pageBlock%>'">&lt;</div>
				<%}
				for(int i =startPage; i<= endPage; i++){%>
					<div class="page" onclick="window.location='memberList.jsp?pageNum=<%=i%>'">&nbsp;<%=i %></div>
				<%}
				if(endPage < pageCount){%>
					<div class="page" onclick="window.location='memberList.jsp?pageNum=<%=startPage+pageBlock%>'">&gt;</div>
				<%}
			}
		%>
		</div> 
	<%} %>
</body>
<%} %>
</html>