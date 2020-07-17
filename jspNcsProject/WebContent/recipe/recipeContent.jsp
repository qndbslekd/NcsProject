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
<title>Recipe Content</title>
<link rel="stylesheet" href="../resource/team05_style.css">

<style>
	/* 이거 적용 안됨 */
	#comment{
		border-left:none;      
		border- right:none;		
		border- top:none;		
		border- bottom:none;
	}

</style>
	<script>
		function openReplyForm(nowContentNum, recipeNum, reLevel, reStep, ref){
			
			if(reLevel == 1){ // 답글을 이미 한번 단 경우
				window.alert("답글 작성은 한번만 가능합니다");
				return
			}else{
				var url = 'recipeContentCommentInsertForm.jsp?contentNum='+nowContentNum+'&recipeNum='+recipeNum+'&reLevel='+reLevel+'&reStep='+reStep+'&ref='+ref;
				window.name="recipeContent";
				// 부모창 이름			
				window.open(url, "commentInsertForm", "width=400, height=250, resizeable=no, scrollbars=no");
				// window.open("open할 window", "자식창 이름", "팝업창옵션")
			}
		}
	</script>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	String memName = (String)session.getAttribute("memName");
	int num = Integer.parseInt(request.getParameter("num"));
	System.out.println("아이디 :" + memName);
	//String pageNum = request.getParameter("pageNum");

	
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
	<jsp:include page="../header.jsp" flush="false" />
	<br />
	<h1 align="center">   content </h1>
	
	<table border="1">
		<tr >
			<td colspan="4">
				<img src="imgs/<%= recipeBoard.getThumbnail() %>" />
			</td>
		</tr>
		<tr>
			<td colspan="4">
				 레시피 제목 : <%= recipeBoard.getRecipeName() %>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				채식주의 타입 : <%= recipeBoard.getVegiType() %>
			</td>
		</tr>
		<tr>
			<td>
				인분 : <%= recipeBoard.getQuantity() %>
			</td>
			<td>
				소요시간 : <%= recipeBoard.getCookingTime() %>
			</td>
			<td>
				난이도 : <%= recipeBoard.getDifficulty() %>
			</td>
			<td>
				칼로리 : <%= recipeBoard.getCal() %>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				평점 관련 
			</td>
			<td colspan="2">
				작성자 : <%= recipeBoard.getWriter() %>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				키워드 탭
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				재료 탭
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				추천 제품 탭
			</td>			
		</tr>
		<tr>
			<td colspan="4">
				<table>
				<h3> 조리과정</h3>
				<%
				int reLevel = 0;
				int reStep = 0;
				for(int i = 0; i < recipeContentList.size(); i++){
					recipeContentdto = (RecipeContentDTO)recipeContentList.get(i); 
			
					// 조리과정 단계담아줄 변수
					int nowContentNum = recipeContentdto.getStep();
					
					int recipeNum = recipeContentdto.getRecipeNum();
					
					%>				
					<tr>
						<td>단계<%= nowContentNum%>.</td>
						<td><%= recipeContentdto.getContent() %> </td> 
						<td>
							<%-- 댓글쓰기 --%>
							
							<input type="button" value="댓글쓰기" onclick="openReplyForm(<%= nowContentNum %>, <%= recipeNum %>, <%= reLevel %>, <%= reStep %>, <%= 0 %>);" />
								<%-- function 호출할 때 해당 조리단계 관한 변수 보내줌  --%>
						</td>
						<td rowspan="2">사진자리 </td>
					</tr>
					<tr>
					<td colspan="3">
					<table id="comment">
							<%
							List recipeContentCommentlist = null;
							dao = RecipeContentCommentDAO.getInstance();
							recipeContentCommentlist = dao.selectRecipeContentComment(i+1, num);
							if(recipeContentCommentlist != null){									
								for(int k = 1; k <= recipeContentCommentlist.size(); k++){
						
									RecipeContentCommentDTO dto = (RecipeContentCommentDTO)recipeContentCommentlist.get(k-1);
									reStep = dto.getReStep();
									reLevel = dto.getReLevel();
							%>
						<tr>
							<td align="left">
								<% // 댓글 들여쓰기 처리
									int wid = 0;
									if(dto.getReLevel() > 0){
										wid = 8*(dto.getReLevel());
									
								%>
									<img src="imgs/tabImg.PNG" width="<%= wid %>" />
									<img src="imgs/replyImg.png" width="11" />
									<%} %>
								<%= dto.getContent()  %>
							</td>
							<td> <%= dto.getName() %>  </td>
							<td> 
								<% // 댓글의 name과 memName이 동일하면 수정삭제 동일하지 않으면 아무것도 안 뜨게.
									
									if(dto.getName().equals(memName)){ 
									// 댓글의 name과 memName이 동일하면 수정삭제asdsad
								%>
										<input type="button" value="수정" onclick="window.location='#'"/>
										<input type="button" value="삭제" onclick="window.location='#'"/>
								<% 	}else{
										if(recipeBoard.getWriter().equals(memName)){ // 레시피 글쓴아이디와 로그인 아이디 같으면 		
											System.out.println("reLevel: " + reLevel);
								%>
											<input type="button" value="답글쓰기" onclick="openReplyForm(<%= nowContentNum %>, <%= recipeNum %>, <%= reLevel %>, <%= reStep %>, <%= dto.getRef() %>);" />
											<input type="button" value="신고" onclick="window.location='#'"/>
								<%				
																					
								%>											
								<%		}
								
									}
									
								%>
								
						  	</td>
								<%} 								
							}%>						
						</tr>					
					</table>
				
					</td>
					</tr>
				<%
				} // 조리과정 제일 큰 for문
				%>
				</table>
		<tr>
			<td colspan="4">
				댓글 탭
			</td>			
		</tr>
	</table>
	<br /><br />
	<div align="center">
	<button onclick="window.location='recipeModifyForm.jsp?num=<%=num %>'">수정</button>
	<button onclick="window.location='recipeDeleteForm.jsp?num=<%=num %>'">삭제</button>
	</div>
</body>
</html>