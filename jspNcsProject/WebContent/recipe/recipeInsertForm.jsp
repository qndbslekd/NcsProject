<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 작성</title>
<link rel="stylesheet" href="../resource/team05_style.css">
</head>
<%
	String memId = (String) session.getAttribute("memId");

	if(memId==null) { %>
	<script> alert("로그인 후 이용해주세요."); window.location="../member/loginForm.jsp"; </script>
	<%} else { %>
<body>

<jsp:include page="../header.jsp"/>
	<form action="recipeStepInsertForm.jsp" method="post">
		<table>
			<tr>
				<td>제목</td>
				<td width="300"><input type="text" name="recipeName" required /></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%=session.getAttribute("memName") %><input type="hidden" name="writer" value="<%=memId%>" /></td>
			</tr>
			<tr>
				<td>채식유형</td>
				<td style="text-align:left">
					<input type="radio" name="vegiType" value="vegan" required />비건<br/>
					<input type="radio" name="vegiType" value="lacto" required />락토<br/>
					<input type="radio" name="vegiType" value="ovo" required />오보<br/>
					<input type="radio" name="vegiType" value="lacto ovo" required />락토오보<br/>
					<input type="radio" name="vegiType" value="pesco" required />페스코<br/>
					<input type="radio" name="vegiType" value="pollo" required />폴로<br/>
					<input type="radio" name="vegiType" value="flexitarian" required />플렉시테리언<br/>
				</td>
			</tr>
			<tr>
				<td>요리 분량</td>
				<td><input type="number" name="quantity" required />인분</td>
			</tr>
			<tr>
				<td>요리 시간</td>
				<td><input type="number" name="cookingTime" required />분</td>
			</tr>
			<tr>
				<td>난이도</td>
				<td>
					<select name="difficulty" required >
						<option value="" disabled selected>난이도를 선택하세요</option>
						<option value="쉬움">쉬움</option>
						<option value="보통">보통</option>
						<option value="어려움">어려움</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>칼로리</td>
				<td><input type="number" name="cal" /></td>
			</tr>
			<tr>
				<td>재료</td>
				<td><textarea cols="40" rows="5" placeholder="예) 감자:1개, 양파:2개, 고추장:두스푼, ..." style="resize:none" name="ingredients"></textarea><br/> '재료명:분량,재료명:분량'의 형식으로 적어주세요</td>
			</tr>
			<tr>
				<td>요리 단계</td>
				<td><input type="number" name="recipeStep" required />단계</td>
			</tr>
			<tr>
				<td>키워드</td>
				<td><input type="text" placeholder="예) 태그,태그,태그 ..." name="tag" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="레시피 작성단계로" />
			</tr>
		</table>
	</form>

</body>
<%} %>
</html>