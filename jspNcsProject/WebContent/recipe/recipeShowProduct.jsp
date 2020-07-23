<%@page import="jspNcsProject.dto.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="jspNcsProject.dao.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 제품</title>
<link rel="stylesheet" href="../resource/team05_style.css">

</head>
<%
int num = Integer.parseInt(request.getParameter("num"));

RecipeDAO dao = RecipeDAO.getInstance();

HashMap<String,String> ingre = dao.selectIngredients(num);

Set keySet = ingre.keySet();
Iterator it = keySet.iterator();

List recommendList = new ArrayList();

while(it.hasNext()) {
	String key = (String) it.next();
	ProductDTO dto = dao.selectProductByIngredient(key);
	if (dto != null) {
		recommendList.add(dto);
	}
}

int maxSize = 4;

if(recommendList.size() < maxSize) {
	maxSize = recommendList.size();
}

if(maxSize > 0) {

%>

<body>
<table style="max-width:1100px; min-width:1100px;">
	<tr>
		<td colspan="4" style="max-width:1100px; min-width:1100px; padding:0px; "><span style="text-align:left; margin:0px;" ><h1>추천 제품</h1></span></td>
	</tr>
	<tr >
		<%for(int i = 0; i < maxSize; i++) {
			ProductDTO dto = (ProductDTO) recommendList.get(i);
		%>
		<td>
			<span onclick="window.location='../product/productContent.jsp?num=<%=dto.getNum()%>'" style="width:200px; height:200px; text-align:center;">
				<img src = "/jnp/product/imgs/<%= dto.getProduct_img() %>" style="display:block; height:150px; margin:auto;"/>
				<%=dto.getName() %>
			</span>
		</td>
		<%} %>
	</tr>
</table>
<hr size="2px" width="1100px" color="#ccc">
</body>

<%} %>
</html>