<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	//img file update
	String path = request.getRealPath("product/imgs");
	int max = 1024*1024*5; //5MB byte 단위
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); //중복파일금지
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	
	//file paramTest
	System.out.println("[NEW mr product_img :"+mr.getFilesystemName("product_img")+"]");
	System.out.println("[NEW mr product_img_before :"+mr.getParameter("product_img_before")+"]");
	
	//img null point 방지
	//기존 이미지를 등록해놓지 않았을 경우
	String product_img="";
	if(mr.getFilesystemName("product_img")==null){
		product_img= mr.getParameter("product_img_before");
	}else{
		product_img= mr.getFilesystemName("product_img");
	}
	//이미지 파일만 업로드하기
	String contentType = mr.getContentType("profile_img");
	if(contentType!=null){
		String[] type = contentType.split("/");
		if(!(type !=null && type[0].equals("image"))){
			File f = mr.getFile("product_img");
			f.delete();
		}
	}
	
	String name = mr.getParameter("name");
	String detail = mr.getParameter("datail");
	String Ingredients = mr.getParameter("Ingredients");
	System.out.println("product_img"+product_img);
	System.out.println("name"+name);
	System.out.println("detail"+name);
	System.out.println("Ingredients"+name);
		
%>
<body>

</body>
</html>