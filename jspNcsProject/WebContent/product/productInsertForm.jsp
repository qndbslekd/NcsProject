<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Product Insert</title>
	<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
</head>
	<jsp:include page="../header.jsp" flush="false">
		<jsp:param value="product" name="mode"/>
	</jsp:include>
<%
	if(session.getAttribute("memId") == null || !session.getAttribute("memId").equals("admin")){%>
		<script>
			alert("관리자만 제품 등록이 가능합니다");
			window.location="productList.jsp";
		</script>
	<%}else{
%>
<body>
<form action="productInsertPro.jsp" method="post" enctype="multipart/form-data">
	<table>
		<br/>
		<tr >
			<td align="center">작성자</td>
			<td><%=session.getAttribute("memName") %></td>
		</tr>
		<tr >
			<td>제품명</td>
			<td><input type="text" name="name" size="100" required="required"/></td>
		</tr>
		<tr>
			<td> 내용 </td>
			<td><textarea cols="100" rows="20" name="detail" required="required"></textarea></td>
		</tr>
		<tr>
			<td>성분</td>
			<td ><input type="text" name="ingredients" placeholder="ex)자연콩발효액,연두베이스순,발효주정,국산순야채양념,무" size="100" required="required"/></td>
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
<br/>
		<jsp:include page="../footer.jsp" flush="false"/>
</body>
<%} %>
</html>