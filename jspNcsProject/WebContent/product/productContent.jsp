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
	MemberDAO MDao = MemberDAO.getInstance();
	String offenceIdByName = "";
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
					<input type="button" onclick="commentFn()" value="댓글달기">
				</td> 
			<tr>
			<%for(int i=0;i<comment.size();i++){ %>
				<tr>  
					<td colspan="2" style="text-align: left;">
						<%=comment.get(i).getName()%> : <%=comment.get(i).getDetail()%> 작성시간 : <%=comment.get(i).getReg()%>
						<button type="button" onclick="recommentFn('<%=comment.get(i).getName()%>','<%=comment.get(i).getNum()%>')">답글</button>
						<%if(!session.getAttribute("memId").equals("admin")){%>
						<button type="button" onclick="report('<%=comment.get(i).getNum()%>','<%=comment.get(i).getName()%>')">신고</button>
						<%} %>
						<%if(session.getAttribute("memId").equals("admin")||session.getAttribute("memId").equals(comment.get(i).getName())){ %>
								<button type="button" onclick="deleteFn('<%=comment.get(i).getNum()%>','<%=comment.get(i).getName()%>','<%=dto.getNum()%>')">삭제</button>	
						<%} %>
						<%
							List<ProductDTO> recoment =  dao.selectRecomment(comment.get(i).getNum()+"");
							System.out.println("답글의 갯수 : " +recoment.size());
							System.out.println(recoment);
							for(int j=0;j<recoment.size();j++){
								System.out.println("======"+comment.get(i).getNum());
							%> 
								<!--before Name-->
								<br/>
								<%=recoment.get(j).getIngredients()%>
								<img src="../resource/replyImg.png" width="8px"/>
								<%=recoment.get(j).getName()%> : <%=recoment.get(j).getDetail()%> 작성시간 : <%=recoment.get(j).getReg()%>
								<button type="button" onclick="recommentFn('<%=recoment.get(j).getName()%>','<%=comment.get(i).getNum()%>')">답글</button>
								<%offenceIdByName = MDao.selectMemberIdForOffenceByName(recoment.get(j).getName());%>
								<%if(!session.getAttribute("memId").equals("admin")){%>
								<button type="button" onclick="report('<%=recoment.get(j).getNum()%>','<%=offenceIdByName%>')">신고</button>
								<%} %>
								<%if(session.getAttribute("memId").equals("admin")||session.getAttribute("memId").equals(recoment.get(j).getName())){ %>
								<button type="button" onclick="deleteFn('<%=recoment.get(j).getNum()%>','<%=recoment.get(j).getName()%>','<%=dto.getNum()%>')">삭제</button>	
								<%} %>
						<%}%>
						<input type="hidden" name="beforeName" value="default"/>
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
	
	function recommentFn(beforeName,num){ 
		//유효성검사
		
		console.log(beforeName);
		var url = "recomment.jsp?beforeName="+beforeName+"&num="+num;
		open(url,"답글달기","toolbar=no,location=no,status = no, menubar = no, scrollbars = no,resizable = no, width = 300,height = 200");
		
		var back = window.location.href;
		var form = document.getElementsByName("history");
		form[0].value = back;
	}
	
	function commentFn(){
		var back = window.location.href; 
		var form = document.getElementsByName("history");
		form[0].value = back;
		document.recommend.submit(); 
	}
	
	function report(commentNum,member) {
		if(confirm("이 댓글을 신고하시겠습니까?")==true) {
			var offenceCode = "PC"+commentNum;
			location.href= "../member/offenceMember.jsp?offenceUrl="+offenceCode+"&member="+member;
		}		
	}

	function deleteFn(num, name,backNum){
		if(confirm("이 댓글을 삭제하시겠습니까?")==true) {
			location.href= "deleteComment.jsp?num="+num+"&name="+name+"&backNum="+backNum;
		}
	}
	</script>
</html>