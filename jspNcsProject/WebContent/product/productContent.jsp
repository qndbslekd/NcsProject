<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="jspNcsProject.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="../header.jsp"></jsp:include>
<%
	String name = (String)session.getAttribute("memName");
	if(name == null){
		name = "";	
	}
	String num = request.getParameter("num");
	
	//if num DB 에 존재하지 않으면 Back
	ProductDAO dao = ProductDAO.getInstance();
	ProductDTO dto = dao.selectProduct(num);
	List<ProductDTO> comment =  dao.selectComment(num);
	
%>
	<body>
		<form action="recommendPro.jsp" method="post" name="recommend" >
		<table>
		<%if(name.equals("관리자")){ %>
			<tr>
				<td colspan="2">
					<button type="button" onclick="window.location = 'productModifyForm.jsp?num=<%=dto.getNum() %>'" >글 수정</button>
					<button type="button" onclick="window.location = 'productDeletePro.jsp?num=<%=dto.getNum() %>'" >삭제하기</button>
				</td>
			</tr>
		<% }%>
			<tr> 
				<td colspan="2">
					<%=dto.getRecommend()%>
					<button onclick = "recommand()">추천</button>
					<input type="hidden" name="history" value="default" />	
					<input type="hidden" name="num" value="<%=dto.getNum()%>" />
				</td>
			</tr>
			<tr> 
				<td rowspan="2">
					<%if(dto.getProduct_img()==null||dto.getProduct_img().equals("null")){ %>
					<img src="/jnp/product/imgs/unnamed.gif">
					<%}else{ %> 
					<img src="/jnp/product/imgs/<%=dto.getProduct_img()%>">
					<%} %>
				</td>			
				<td>
					<%=dto.getName() %>
				</td>
			</tr> 
			<tr>
				<td>
					<%=dto.getIngredients() %>
				</td>
			<tr>
			<tr>
				<td colspan="2">
					개요
				</td>
			<tr>
			<tr>
				<td colspan="2">
					<%=dto.getDetail()%>
				</td>
			<tr>
			<tr>
				<td colspan="2">
					<%=name%><input type="text" name="comment"/>
					<input type="submit" value="댓글달기" />
				</td>
			<tr>
			<%for(int i=0;i<comment.size();i++){ %>
				<tr>
					<td colspan="2">
						<%=comment.get(i).getName()%> : <%=comment.get(i).getDetail()%> 작성시간 : <%=comment.get(i).getReg()%>
						<input type="hidden" name="beforeName" value="<%=comment.get(i).getName()%>"/>
						<input type="text" name="recomment"/>
						<!-- 답글의 답글 진행중  -->
<!-- 						<button type="button" onclick="recomment()">답글</button> -->
						<input type="button" onclick="recommentFn()" value="답글">
						
						<button type="button" onclick="alert('답글')">신고</button>
					</td>
				</tr> 
			<%} %>
		</table>
		</form> 
	</body>
	<script type="text/javascript">
	function recommand(){
		var back = window.location.href ; 
		var form = document.getElementsByName("history");
		form[0].value = back;
		document.recommend.submit();
	}
	
	function recommentFn(){
		//유효성검사
		//test
		var actionForm = document.recommend;
		actionForm.action = 'recomment.jsp';
		var back = window.location.href; 
		var form = document.getElementsByName("history");
		form[0].value = back;
		document.recommend.submit(); 
	}
	</script>
	
</html>