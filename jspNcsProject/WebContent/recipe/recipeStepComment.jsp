 <%@page import="jspNcsProject.dto.RecipeContentCommentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jspNcsProject.dao.RecipeContentCommentDAO"%>
<%@page import="java.util.List"%>
<%@page import="jspNcsProject.dto.RecipeContentDTO"%>
<%@page import="jspNcsProject.dao.RecipeContentDAO"%>
<%@page import="jspNcsProject.dto.RecipeDTO"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resource/team05_style.css">
	<script>
		// 팝업창 위치 관한 변수
		var _width = '400';
		var _height = '250';
		
		// 팝업 가운데 위치 시키기 위해서 중간 값 구해주기
		var _left = Math.ceil((window.screen.width - _width)/2);
		var _top = Math.ceil((window.screen.height - _height)/2);
		
		// 조리단계별 댓글 or 답글 달기 
		function openReplyForm(nowContentNum, recipeNum, reLevel, reStep, ref, cRef){			
			if(cRef > 1){ // 답글을 이미 한번 단 경우
				window.alert("답글 작성은 한번만 가능합니다");
				return
			}else{				
				var url = 'recipeContentCommentInsertForm.jsp?contentNum='+nowContentNum+'&recipeNum='+recipeNum+'&reLevel='+reLevel+'&reStep='+reStep+'&ref='+ref;	
				window.open(url, "댓글쓰기", "width="+ _width + ", height="+ _height + ", left=" + _left + ", top=" + _top + ", resizeable=no, scrollbars=no");
				// window.open("open할 window", "이름", "팝업창옵션")
			}
		}
		// 댓글 수정하기 
		function openModifyForm(num){
			var url = 'recipeStepCommentModifyForm.jsp?num='+num;
			window.open(url, "댓글수정", "width=400, height=250, resizeable=no, scrollbars=no");
		}
		//댓글 삭제하기
		function openDeleteForm(num, ref){
			if(confirm("댓글을 삭제하시겠습니까?")==true) {
				window.location="recipeStepCommentDeletePro.jsp?num=" + num+"&ref="+ref;
			}
		}				
	</script>
</head>
<style>
	#contentNum{
		width:40px; 
		height:40px;
		border-radius:20px; 
		border:0px; 
		color:white; 
		background-color: rgb(139, 195, 74); 
		top:10px; text-align:center; 
		vertical-align:middle; 
		font-size:1.5em; 
		font-weight:800; 
		cursor:default;"
	}
	#span1{
		font-size:18px; 
		margin-bottom:7px; 
		background:linear-gradient(to top, #cceba9 50%, transparent 50%);	
	}
</style>

<%
	request.setCharacterEncoding("UTF-8");
	
	String memName = (String)session.getAttribute("memName");
	int num = Integer.parseInt(request.getParameter("num"));
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
	
	RecipeDAO recipeDAO = RecipeDAO.getInstance();
	RecipeDTO recipeBoard = new RecipeDTO();

	recipeBoard = recipeDAO.selectRecipeBoard(num);
	int contentNum = recipeBoard.getRecipeStep();
	
	RecipeContentDTO recipeContentdto = new RecipeContentDTO();
	RecipeContentDAO recipeContentdao = RecipeContentDAO.getInstance();
	
	// recipeContentList : 레시피 조리단계  담아준 리스트 -> for문 돌려서 뽑기
	List recipeContentList = recipeContentdao.selectRecipeContent(num);
	
	for(int i = 0; i < recipeContentList.size(); i++){
		recipeContentdto = (RecipeContentDTO)recipeContentList.get(i);
		System.out.println(recipeContentdto.getContent());		
	}	
	// 조리단계 댓글 dao
	RecipeContentCommentDAO dao = null;
%>
<body>
	<table class="nonBorder">
	<%
	for(int i = 0; i < recipeContentList.size(); i++){
		recipeContentdto = (RecipeContentDTO)recipeContentList.get(i); 

		int reLevel = 0;
		int reStep = 0;
		// 조리과정 단계담아줄 변수
		int nowContentNum = recipeContentdto.getStep();		
		int recipeNum = recipeContentdto.getRecipeNum();		
		%>				
		<tr>
			<td style="width:70px; vertical-align:top;">
				<button id="contentNum"><%= nowContentNum%></button>
			</td>
			<td style="width:600px; vertical-align:top; text-align:left; padding-top:15px;">
				<span id="span1"><%= recipeContentdto.getContent() %></span>
				 <table class="nonBorder" style="margin:3px; left:0px;">
				<%
				List recipeContentCommentlist = null;
				dao = RecipeContentCommentDAO.getInstance();
				recipeContentCommentlist = dao.selectRecipeContentComment(i+1, num);
				if(recipeContentCommentlist != null){ //if5									
					for(int k = 1; k <= recipeContentCommentlist.size(); k++){ //for1		
						RecipeContentCommentDTO dto = (RecipeContentCommentDTO)recipeContentCommentlist.get(k-1);
						reStep = dto.getReStep();
						reLevel = dto.getReLevel();
				%>
				
			<tr style="max-height:10px;height:10px">
				<td style="padding:2px; padding-top:10px;vertical-align:top;max-width:400px;text-align:left;" rowspan="2" >
					<% // 댓글 들여쓰기 처리
						int wid = 0;
						if(dto.getReLevel() > 0){ //if4
							wid = 20*(dto.getReLevel());						
					%>
						<div style="width:<%= wid %>px; display:inline-block;" >&nbsp;</div>
						<%} // if4 끝%>
						<div style="display:inline-block;vertical-align:top; "><img src="imgs/replyImg.png" width="11"  height="11"/></div>
					<div style="display:inline-block; max-width:<%=340-wid%>px;">"<%= dto.getContent()  %>"</div>
				</td>
				<td style="padding:2px;max-height:40px;height:40px"> <span style="vertical-align:middle;">| <%=recipeDAO.selectNameById(dto.getName()) %></span></td>
				<td style="padding:2px;max-height:40px;height:40px;text-align:left"> 
					<% 
					if(session.getAttribute("memId") == null){//if3 로그아웃 상태%>
					
					<%}else{ // 로그인 상태 
						if(dto.getName().equals(session.getAttribute("memId"))){// if2 
						// 댓글의 name과 memName이 동일하면 수정삭제 뜨게					
					%>
							<input type="button" class="grayButton" value="수정" onclick="openModifyForm(<%=dto.getNum()%>);"/>
							<input type="button" class="grayButton" value="삭제" onclick="openDeleteForm(<%=dto.getNum()%>, <%=dto.getRef()%>)"/>
							
					<%	}else if(session.getAttribute("memId").equals("admin")){ // 관리자면 수정 삭제 다 뜨게 %>	
							<input type="button" class="grayButton" value="수정" onclick="openModifyForm(<%=dto.getNum()%>)"/>
							<input type="button" class="grayButton" value="삭제" onclick="openDeleteForm(<%=dto.getNum()%>, <%=dto.getRef()%>)"/>					
					<% 	}else{ // 댓글쓴이 != 로그인 아이디 
							if(recipeBoard.getWriter().equals(session.getAttribute("memId"))){ // 레시피글쓴이 == 로그인아이디 
								int maxReLevel = dao.selectMaxRelevel(dto.getRef());				
								int cRef = dao.countRef(dto);								
					%>				
								<input type="button" value="&#x1F4AC;답글쓰기" class="greenButton" style="padding:5px;
									"onclick="openReplyForm(<%= nowContentNum %>, <%= recipeNum %>, <%= maxReLevel %>, <%= reStep %>, <%= dto.getRef() %>, <%=cRef %>);" />
								<input type="button" value="&#128680;신고"class="grayButton" onclick="report('RCC','<%=dto.getNum()%>','<%=dto.getName()%>')"/>
					<%		}else{	%>			
								<input type="button" value="&#128680;신고"class="grayButton" onclick="report('RCC','<%=dto.getNum()%>','<%=dto.getName()%>')"/>
					<%		}
						}	
					}//if3의 else끝	
					%>				
			  	</td>
			  	</tr>
			  	<tr style="min-height:1px;padding:0px;">
			  		<td style="padding:0; min-height:1px;"><div style="width:1px; height:1px; display:block"></div></td>
			  		<td style="padding:0; min-height:1px;"><div style="width:1px; height:1px; display:block"></div></td>
			  	</tr>
					<%} // for1 끝								
				} // if5끝 %>						
			</tr>					
		</table>			
			</td>		 
			<%
				if(session.getAttribute("memId") == null ){// 로그아웃 상태면 댓글쓰기 안보임		
				}else if(recipeBoard.getWriter().equals(session.getAttribute("memId"))){// 레시피글작성자가 로그인한거면 댓글쓰기 안보임
				}else{ // 레시피 글 작성자가 아니면 댓글쓰기 보임%>
				
				<td style="width:80px; vertical-align:top;">	 		
						<input type="button" value="댓글쓰기" class="greenButton" style="padding:5px;"onclick="openReplyForm(<%= nowContentNum %>, <%= recipeNum %>, <%= reLevel %>, <%= reStep %>, <%= 0 %>);" />
						<%-- function 호출할 때 해당 조리단계 관한 변수 보내줌  --%>				
				</td>
			<%}%>
			
			<%if(!recipeContentdto.getImg().equals("default.png")) { %>
			<td>
				<img src="./imgs/<%= recipeContentdto.getImg() %>" width="200px" height="200px" />
			</td>
			<%} %>
		</tr>
	<% 
	} // 조리과정 제일 큰 for문
	%>
	</table>
	<br/><br/><br/>
</body>
</html>
   