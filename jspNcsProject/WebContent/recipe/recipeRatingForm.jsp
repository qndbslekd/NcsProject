<%@page import="jspNcsProject.dto.RatingDTO"%>
<%@page import="jspNcsProject.dao.RatingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평점 남기기</title>
<link rel="stylesheet" href="../resource/team05_style.css">																				

</head>
<%
	String memId = (String) session.getAttribute("memId");

	int num = Integer.parseInt(request.getParameter("num"));
	
	if(memId==null) {
		%><script>alert("회원만 평점을 남길 수 있습니다."); self.close(); </script><%
	} else {
		//평점을 준 적 있는지 확인
		RatingDAO dao = RatingDAO.getInstance();
		RatingDTO rate = dao.selectRating(num, memId);
		
		if(rate==null) { //준 적 없으면 새로 주기 %>
		<body>
			<form method="post" action="recipeRatingPro.jsp">
			<input type="hidden" name="num" value="<%=num %>" />
			<input type="hidden" name="TF" value="false" />
				<table>
					<tr>
						<td>평점을 선택하세요</td>
					</tr>
					<tr>
						<td>
							<select name="rate" required>
								<option value="5">&#11088;&#11088;&#11088;&#11088;&#11088;</option>
								<option value="4">&#11088;&#11088;&#11088;&#11088;</option>
								<option value="3">&#11088;&#11088;&#11088;</option>
								<option value="2">&#11088;&#11088;</option>
								<option value="1">&#11088;</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><input type="submit" value="평점 주기" /> </td>
					</tr>
				</table>
			</form>
		</body>

		<% } else { //준 적 있으면 수정하기 %>
		<body>
			<form method="post" action="recipeRatingPro.jsp">
			<input type="hidden" name="num" value="<%=num %>" />
			<input type="hidden" name="TF" value="true" />
				<table>
					<tr>
						<td>이미 평점을 남긴 레시피입니다.</td>
					</tr>
					<tr>
						<td>수정하시려면 평점을 다시 선택하세요.</td>
					</tr>
					<tr>
						<td>
							<select name="rate" required>
							<%System.out.println(rate.getRate());%>
								<option value="5" <%if (rate.getRate()==5) { %>selected<%} %>>&#11088;&#11088;&#11088;&#11088;&#11088;</option>
								<option value="4" <%if (rate.getRate()==4) { %>selected<%} %>>&#11088;&#11088;&#11088;&#11088;</option>
								<option value="3" <%if (rate.getRate()==3) { %>selected<%} %>>&#11088;&#11088;&#11088;</option>
								<option value="2" <%if (rate.getRate()==2) { %>selected<%} %>>&#11088;&#11088;</option>
								<option value="1" <%if (rate.getRate()==1) { %>selected<%} %>>&#11088;</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><input type="submit" class="greenButton" value="평점 수정" /> </td>
					</tr>
				</table>
			</form>
		</body>

		<%} %>

<%} %>
</html>