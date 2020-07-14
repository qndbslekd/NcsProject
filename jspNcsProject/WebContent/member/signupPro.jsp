<%@page import="jspNcsProject.dto.MemberDTO"%>
<%@page import="jspNcsProject.dao.MemberDAO"%>
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
String path = request.getRealPath("save");
int max = 1024*1024*5; //5MB byte 단위
String enc = "UTF-8";
DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); //중복파일금지
MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp); 

String id = mr.getParameter("id");
String pw = mr.getParameter("pw");
String name = mr.getParameter("name");
String id_number1 = mr.getParameter("id_number1");
String id_number2 = mr.getParameter("id_number2");
String vegi_type = mr.getParameter("vegi_type");
String profile_img = mr.getParameter("profile_img");
System.out.println(path);

MemberDAO dao = MemberDAO.getInstance();
MemberDTO dto = new MemberDTO();

//dto setting
if(id_number2.equals("1")||id_number2.equals("3")){
	dto.setGender("M");
}else if(id_number2.equals("2")||id_number2.equals("4")){
	dto.setGender("F");
}
dto.setAge(id_number1.substring(0,1));
dto.setId(id);
dto.setId_number(id_number1+id_number2);
dto.setName(name);
dto.setProfile_img(profile_img);
dto.setPw(pw);
dto.setVegi_type(vegi_type);
System.out.println(dto.toString());
dao.insertMember(dto); 
/* 
이미지 파일만 업로드하기
String[] type = contentType.split("/");
if(!(type !=null && type[0].equals("image"))){
	File f = mr.getFile("upload");
	f.delete();
}
*/
%>
SIGNUP PRO
<body>
</body>
</html>