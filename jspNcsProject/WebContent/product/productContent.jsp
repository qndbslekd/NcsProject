<%@page import="java.text.SimpleDateFormat"%>
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
<style>
#greenButton {
	border:0px;
    color:white;
    padding: 8px 15px;
    cursor: pointer;
    width: auto;
    height: auto;
    background: rgb(139, 195, 74);
    border-radius: 10px;
    outline: none;
    margin: 5px auto;
}
</style>
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
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
%>
	<body>
		<form action="recommendPro.jsp" method="post" name="recommend" >
		<table style="width: 1000px;">
			<tr>  
				<td colspan="2">
					<input type="hidden" name="history" value="default" />	
					<input type="hidden" name="num" value="<%=dto.getNum()%>" />
				</td>
			</tr>
			<tr> 
				<td colspan="2">
					<%if(dto.getProduct_img()==null||dto.getProduct_img().equals("null")){ %>
					<img src="/jnp/product/imgs/unnamed.gif" style="width: 300px; height: 500px; margin-bottom: 10px" />
					<%}else{ %>  
					<img src="/jnp/product/imgs/<%=dto.getProduct_img()%>"  style="width: 300px; height: 500px; margin-bottom: 10px" />
					<%} %>
				</td>
			</tr>  
			<tr>
			<td colspan="2" style="border-top:2px solid #ccc; border-bottom:2px solid #ccc; padding-top: 30px; padding-bottom: 30px;">
				<h1 style="display: inline;"><%=dto.getName() %></h1>
				<button onclick = "recommand()">추천 <%=dto.getRecommend()%></button>
			</td>
			</tr> 
			<tr>
				<td colspan="2" style="text-align: left; border-bottom:2px solid #ccc; padding-top: 30px; padding-bottom: 30px;">
					<h1>성분</h1>
					<%=dto.getIngredients() %>
				</td>
			<tr>
			<tr>
				<td colspan="2" style="text-align: left; border-bottom:2px solid #ccc; padding-top: 30px; padding-bottom: 30px;">
					<h1>개요</h1>
					<%=dto.getDetail()%>
				</td>
			<tr>
			<tr>
<<<<<<< HEAD
				<td style="text-align: left; padding-top: 5px; padding-bottom: 5px;">
					<h1>댓글</h1>
				</td>
=======
				<td colspan="2" style="text-align: left; padding-top: 5px; padding-bottom: 5px;">
					<h1>댓글</h1>
				</td> 
>>>>>>> branch 'develop' of https://github.com/ysk0951/codinnnnng.git
			<tr>
			
			<%for(int i=0;i<comment.size();i++){ %>
				<tr>  
						<td style="text-align: left;">
						<%=comment.get(i).getName()%> 
						<button class="grayButton" type="button" style="background-color:rgb(139, 195, 74); color:white" onclick="recommentFn('<%=comment.get(i).getName()%>','<%=comment.get(i).getNum()%>')">&#x1F4AC;답글</button>
						
						<%if(!(session.getAttribute("memId")==null||session.getAttribute("memId").equals("admin")||comment.get(i).getName().equals("관리자")||session.getAttribute("memName").equals(comment.get(i).getName()))){%>
						<%offenceIdByName = MDao.selectMemberIdForOffenceByName(comment.get(i).getName());%>
						<button class="grayButton" type="button" onclick="report('<%=comment.get(i).getNum()%>','<%=offenceIdByName%>')">&#128680;신고</button>
						<%} %>
						
						<%if(session.getAttribute("memId")!=null){ %>
							<%if(session.getAttribute("memId").equals("admin")||session.getAttribute("memId").equals(comment.get(i).getName())){ %>
									<button class="grayButton" type="button" onclick="deleteFn('<%=comment.get(i).getNum()%>','<%=comment.get(i).getName()%>','<%=dto.getNum()%>')">삭제</button>	
							<%} %>
						<%} %>
						<%=comment.get(i).getDetail()%>
						</td>
						<td style="text-align:right;"><%=sdf.format(comment.get(i).getReg())%></td>
						</tr>
						<%
							List<ProductDTO> recoment =  dao.selectRecomment(comment.get(i).getNum()+"");
							System.out.println("답글의 갯수 : " +recoment.size());
							System.out.println(recoment);
							for(int j=0;j<recoment.size();j++){	
								System.out.println("======"+comment.get(i).getNum());
							%> 
								<!--before Name-->
							<tr>
								<td style="text-align: left;">
								<img src="/jnp/recipe/imgs/replyImg.png" width="10px"/>
								<%=recoment.get(j).getName()%> 		
								<button class="grayButton" type="button" style="background-color:rgb(139, 195, 74); color:white" onclick="recommentFn('<%=recoment.get(j).getName()%>','<%=comment.get(i).getNum()%>')">&#x1F4AC;답글</button>
								<%if(!(session.getAttribute("memId")==null||session.getAttribute("memId").equals("admin")||recoment.get(j).getName().equals("관리자")||session.getAttribute("memName").equals(recoment.get(j).getName()))){%>
								<%offenceIdByName = MDao.selectMemberIdForOffenceByName(recoment.get(j).getName());%>
								<button class="grayButton" type="button" onclick="report('<%=recoment.get(j).getNum()%>','<%=offenceIdByName%>')">&#128680;신고</button>
								<%} %>
								<%=recoment.get(j).getDetail()%> 
							<%if(session.getAttribute("memId")!=null){ %>	
								<%if(session.getAttribute("memId").equals("admin")||session.getAttribute("memId").equals(recoment.get(j).getName())){ %>
								<button class="grayButton" type="button" onclick="deleteFn('<%=recoment.get(j).getNum()%>','<%=recoment.get(j).getName()%>','<%=dto.getNum()%>')">삭제</button>
								<%} %>
							<%} %>
							</td>
							<td style="text-align: right;"><%=sdf.format(recoment.get(j).getReg())%></td>
							</tr>
						<%}%>
						<input type="hidden" name="beforeName" value="default"/>
					</td>
				</tr>  
			<%} %>
			
			<tr>
				<td style="padding-top: 30px; padding-bottom: 10px; text-align: left;">
					<%=name%>&nbsp;<input type="text" name="comment" size="70"/> 
					<button class="greenButton" type="button" onclick="commentFn()">댓글달기</button>
				</td> 
			<tr>
			
			<%if(name.equals("관리자")){ %>
			<tr>
				<td colspan="2">
					<button type="button" onclick="window.location = 'productModifyForm.jsp?num=<%=dto.getNum() %>'" >글 수정</button>
					<button type="button" onclick="window.location = 'productDeletePro.jsp?num=<%=dto.getNum() %>'" >삭제하기</button>
				</td>
			</tr>
			<% }%>
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