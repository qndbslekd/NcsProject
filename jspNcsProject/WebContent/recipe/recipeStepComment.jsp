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
<style>
	#nonBorder {
		border:0px;
	}
	#nonBorder tr {
		border:0px;
	}
	#nonBorder td {
		border:0px;
	}

</style>
	<script>
		// 조리단계별 댓글 or 답글 달기 
		function openReplyForm(nowContentNum, recipeNum, reLevel, reStep, ref){			
			if(reLevel >= 1){ // 답글을 이미 한번 단 경우
				window.alert("답글 작성은 한번만 가능합니다");
				return
			}else{
				
				var url = 'recipeContentCommentInsertForm.jsp?contentNum='+nowContentNum+'&recipeNum='+recipeNum+'&reLevel='+reLevel+'&reStep='+reStep+'&ref='+ref;	
				window.open(url, "댓글쓰기", "width=400, height=250, resizeable=no, scrollbars=no");
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
	<table id="nonBorder">
	<h3> 조리과정</h3>
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
			<td style="width:70px; vertical-align:top;">Step <%= nowContentNum%>.</td>
			<td style="width:400px; vertical-align:top; text-align:left;max-height:0">
				<%= recipeContentdto.getContent() %>
				 <table id="nonBorder" style="margin:10px; left:0px;">
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
			<tr>
				<td align="left">
					<% // 댓글 들여쓰기 처리
						int wid = 0;
						if(dto.getReLevel() > 0){ //if4
							wid = 20*(dto.getReLevel());
						
					%>
						<img src="imgs/tabImg.PNG" width="<%= wid %>" />
						<%} // if4 끝%>
						<img src="imgs/replyImg.png" width="11" />
					"<%= dto.getContent()  %>"
					</td>
				<td>|  <%= recipeDAO.selectNameById(dto.getName()) %>  </td>
				<td> 
					<% 
					if(session.getAttribute("memId") == null){//if3 로그아웃 상태%>
					
					<%}else{ // 로그인 상태 
						if(dto.getName().equals(session.getAttribute("memId"))){// if2 
						// 댓글의 name과 memName이 동일하면 수정삭제 뜨게					
					%>
							<input type="button" value="수정" onclick="openModifyForm(<%=dto.getNum()%>);"/>
							<input type="button" value="삭제" onclick="openDeleteForm(<%=dto.getNum()%>, <%= dto.getRef() %>)"/>
							
					<%	}else if(session.getAttribute("memId").equals("admin")){ // 관리자면 수정 삭제 다 뜨게 %>	
							<input type="button" value="수정" onclick="openModifyForm(<%=dto.getNum()%>)"/>
							<input type="button" value="삭제" onclick="openDeleteForm(<%=dto.getNum()%>, <%= dto.getRef() %>)"/>					
					<% 	}else{ // 댓글쓴이 != 로그인 아이디 
							if(recipeBoard.getWriter().equals(session.getAttribute("memId"))){ // 레시피글쓴이 == 로그인아이디 
								int maxReLevel = dao.selectMaxRelevel(dto.getRef());
					%>				
								<input type="button" value="답글쓰기" onclick="openReplyForm(<%= nowContentNum %>, <%= recipeNum %>, <%= maxReLevel %>, <%= reStep %>, <%= dto.getRef() %>);" />
								<input type="button" value="신고" onclick="report('RCC','<%=dto.getNum()%>','<%=dto.getName()%>')"/>
					<%		}else{	%>			
								<input type="button" value="신고" onclick="report('RCC','<%=dto.getNum()%>','<%=dto.getName()%>')"/>
					<%		}
						}	
					}//if3의 else끝	
					%>				
			  	</td>
					<%} // for1 끝								
				} // if5끝 %>						
			</tr>					
		</table>
			
			</td> 
			<td style="width:80px; vertical-align:top;">	 		
				<%
					if(session.getAttribute("memId") == null ){// 로그아웃 상태면 댓글쓰기 안보임		
					}else if(recipeBoard.getWriter().equals(session.getAttribute("memId"))){// 레시피글작성자가 로그인한거면 댓글쓰기 안보임
					}else{ // 레시피 글 작성자가 아니면 댓글쓰기 보임%>
						<input type="button" value="댓글쓰기" onclick="openReplyForm(<%= nowContentNum %>, <%= recipeNum %>, <%= reLevel %>, <%= reStep %>, <%= 0 %>);" />
						<%-- function 호출할 때 해당 조리단계 관한 변수 보내줌  --%>
				<% 	}
				
				%>
				
				
			</td>
			<td>
				<img src="./imgs/<%= recipeContentdto.getImg() %>" width="200px" height="200px" />
			</td>
		</tr>
	<% // 이거 아니라고ㅠ
	} // 조리과정 제일 큰 for문
	%>
	</table>
</body>
</html>
   