	<%@page import="jspNcsProject.dto.ProductDTO"%>
<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Product Insert</title>
	<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>
</head>
<jsp:include page="../header.jsp"/>
<%if(session.getAttribute("memId") == null || !session.getAttribute("memId").equals("admin")){%>
	<script>
		alert("관리자만 이용할 수 있습니다.");
		window.location="productList.jsp";
	</script>
<%}else{
	String num = request.getParameter("num");
	ProductDAO dao = ProductDAO.getInstance();
	ProductDTO dto = dao.selectProduct(num);
%>
<body>
<form action="productModifyPro.jsp" method="post" enctype="multipart/form-data">
	<table>
		<br/>
		<tr >
			<td>제품명</td>
			<td><input type="text" name="name" size="100" value="<%=dto.getName()%>"/></td>
			<input type = "hidden" name = "num" value="<%=dto.getNum()%>"/>
		</tr>
		<tr>
			<td> 내용 </td>
			<td><textarea cols="100" rows="20" name="datail" ><%=dto.getDetail()%></textarea></td>
		</tr>
		<tr>
			<td>성분</td>
			<td ><input type="text" name="Ingredients" size="100" value="<%=dto.getIngredients()%>"/></td>
		</tr>
		<tr>
			<td>제품 이미지</td>
			<td >
				<%if(dto.getProduct_img()==null||dto.getProduct_img().equals("null")){ %>
					<img src="/jnp/product/imgs/unnamed.gif">
				<%}else{ %> 
					<img src="/jnp/product/imgs/<%=dto.getProduct_img()%>">
				<%} %>
			</td>
			<input type="hidden" value="<%=dto.getProduct_img()%>" name = "product_img_before" /> 
		</tr>
		<tr>
			<td>수정할 이미지</td>
			<td ><input type="file" name="product_img"/></td>
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
<%} %>
</html>