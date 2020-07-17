<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Product Insert</title>
	<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
</head>
<jsp:include page="../header.jsp"/>
<%
	if(session.getAttribute("memId") == null){%>
		<script>
			alert("로그인 후 이용해주세요");
			window.location="productList.jsp";
		</script>
	<%}
%>
<body>
<form action="productInsertPro.jsp">
	<table>
		<br/>
		<tr >
			<td align="center">작성자</td>
			<td><%=session.getAttribute("memName") %></td>
		</tr>
		<tr >
			<td>제품명</td>
			<td><input type="text" name="subject" size="100"/></td>
		</tr>
		<tr>
			<td> 내용 </td>
			<td><textarea cols="100" rows="20" name="content"></textarea></td>
		</tr>
		<tr>
			<td>성분</td>
			<td ><input type="text" name="ingredients" placeholder="자연콩발효액,연두베이스순,발효주정,국산순야채양념,무" size="100"/></td>
		</tr>
		<tr>
			<td>제품 이미지</td>
			<td ><input type="file" name="product_img" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="확인"/>
				<input type="reset" value="재작성"/>
				<input type="button" value="취소" onclick="window.location='productList.jsp'"/>
			</td>
			
		</tr>
	</table>
</form>

</body>
</html>