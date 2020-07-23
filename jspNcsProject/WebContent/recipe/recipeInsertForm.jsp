<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 작성</title>
<link rel="stylesheet" href="../resource/team05_style.css">
</head>
<style>
	.insertTable td {
		font-size:20px;
		vertical-align:middle;
		padding:20px;
	}
	.h {
		vertical-align:middle;
		text-align:left;
		margin-left:20px;
	}
	.t {
		text-align:right;
		padding:20px;
		border-right:2px solid #ccc;
		font-size:1.4em;
	}
	input[type="text"]{
		border:1px solid #ccc;
		border-radius:5px;
		font-size:25px;
		self-align:left;
		margin-left:20px;
		vertical-align:middle;
	}
	input[type="number"]{
		border:1px solid #ccc;
		border-radius:5px;
		font-size:25px;
		self-align:left;
		margin-left:20px;
		vertical-align:middle;
	}
	select, option {
		border:1px solid #ccc;
		border-radius:5px;
		font-size:25px;
		self-align:left;
		margin-left:20px;
		vertical-align:middle;
	}
	
</style>
<%
	String memId = (String) session.getAttribute("memId");

	if(memId==null) { %>
	<script> alert("로그인 후 이용해주세요."); window.location="../member/loginForm.jsp"; </script>
	<%} else { %>
<body>

<jsp:include page="../header.jsp"/>
	<br/>
	<h1>레시피 작성</h1>
	<br/>
	<form action="recipeStepInsertForm.jsp" method="post">
		<table style="padding:10px;" class="insertTable">
			<tr>
				<td class="t">제목</td>
				<td class="h" width="500"><input type="text" name="recipeName" class="inputInfo" placeholder="제목을 입력해주세요" required style="width:90%"/></td>
			</tr>
			<tr>
				<td class="t">작성자</td>
				<td class="h" style="padding-left:40px;"><%=session.getAttribute("memName") %><input type="hidden" name="writer"  style="border:0px;" value="<%=memId%>" /></td>
			</tr>
			<tr>
				<td class="t">채식유형</td>
				<td class="h" style="text-align:left">
					<input type="radio" name="vegiType" value="vegan" required />비건<br/>
					<input type="radio" name="vegiType" value="lacto" required />락토<br/>
					<input type="radio" name="vegiType" value="ovo" required   />오보<br/>
					<input type="radio" name="vegiType" value="lacto ovo" required   />락토오보<br/>
					<input type="radio" name="vegiType" value="pesco" required   />페스코<br/>
					<input type="radio" name="vegiType" value="pollo" required   />폴로<br/>
					<input type="radio" name="vegiType" value="flexitarian" required  />플렉시테리언<br/>
				</td>
			</tr>
			<tr>
				<td class="t">요리 분량</td>
				<td class="h"><input type="number" name="quantity" required style="width:50px" />인분</td>
			</tr>
			<tr>
				<td class="t">요리 시간</td>
				<td class="h"><input type="number" name="cookingTime" required style="width:50px"/>분</td>
			</tr>
			<tr>
				<td class="t">난이도</td>
				<td class="h">
					<select name="difficulty" required  >
						<option value="" disabled selected>난이도를 선택하세요</option>
						<option value="쉬움">쉬움</option>
						<option value="보통">보통</option>
						<option value="어려움">어려움</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="t">칼로리</td>
				<td class="h"><input type="number" name="cal" /></td>
			</tr>
			<tr>
				<td class="t">재료</td>
				<td class="h"><input type="text" placeholder="예) 감자:1개, 양파:2개, 고추장:두스푼, ..." name="ingredients"/><br/> '재료명:분량,재료명:분량'의 형식으로 적어주세요</td>
			</tr>
			<tr>
				<td class="t">요리 단계</td>
				<td class="h"><input type="number" name="recipeStep" required />단계</td>
			</tr>
			<tr>
				<td class="t">키워드</td>
				<td class="h"><input type="text" placeholder="예) 태그,태그,태그 ..." name="tag" /></td>
			</tr>
			<tr>
			
				<td colspan="2" style="text-align:center;"><br/><input type="submit" class="greenButton" value="레시피 작성단계로" />
			</tr>
		</table>
	</form>
	<br/><br/>

</body>
<%} %>
</html>