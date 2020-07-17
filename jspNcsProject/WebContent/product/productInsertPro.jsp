<%@page import="jspNcsProject.dto.ProductDTO"%>
<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getRealPath("imgs");
	int max = 1024*1024*5; 
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp); 
	
	String contentType = mr.getContentType("product_img");
	if(contentType!=null){
		String[] type = contentType.split("/");
		if(!(type !=null && type[0].equals("image"))){
			File f = mr.getFile("product_img");
			f.delete();
		}
	}

	ProductDAO dao = ProductDAO.getInstance();
	ProductDTO dto = new ProductDTO();
	
	dao.insertProduct(dto);
	
%>
<body>

</body>
</html>