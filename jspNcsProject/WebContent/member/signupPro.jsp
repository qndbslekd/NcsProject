<%@page import="java.util.Calendar"%>
<%@page import="java.io.File"%>
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
String profile_img = mr.getFilesystemName("profile_img");
System.out.println(path);

MemberDAO dao = MemberDAO.getInstance();
MemberDTO dto = new MemberDTO();

//dto setting
if(id_number2.equals("1")||id_number2.equals("3")){
	dto.setGender("M");
}else if(id_number2.equals("2")||id_number2.equals("4")){
	dto.setGender("F");
}
//age cal
String age = id_number1.substring(0,2);
Calendar current = Calendar.getInstance();
int currentYear  = current.get(Calendar.YEAR);
int currentMonth = current.get(Calendar.MONTH) + 1;
int currentDay   = current.get(Calendar.DAY_OF_MONTH);
int id_number1_forCal = Integer.parseInt(age);
System.out.println(id_number1_forCal);
if(id_number2.equals("3")||id_number2.equals("4")){
	id_number1_forCal += 2000;
}else if(id_number2.equals("1")||id_number2.equals("2")){
	id_number1_forCal += 1900;
}
System.out.println(id_number1_forCal);
int age_ = currentYear - id_number1_forCal;
System.out.println("currentYear"+currentYear);
System.out.println("currentMonth"+currentMonth);
System.out.println("currentDay"+currentDay);
System.out.println("age_"+age_);
System.out.println("id_number1_forCal"+id_number1_forCal);

int brithMonth = Integer.parseInt(id_number1.substring(2,3));
int brithDay = Integer.parseInt(id_number1.substring(4,5));
//생일 안 지난 경우 -1
if (brithMonth * 100 + brithDay > currentMonth * 100 + currentDay){
	age_--;
}
dto.setAge(age_+"");
dto.setId(id);
dto.setId_number(id_number1+id_number2);
dto.setName(name);
dto.setProfile_img(profile_img);
dto.setPw(pw);
dto.setVegi_type(vegi_type);
dto.setProfile_img(profile_img);
System.out.println(dto.toString());
dao.insertMember(dto);  
 
//이미지 파일만 업로드하기
String contentType = mr.getContentType("profile_img");
if(contentType!=null){
	String[] type = contentType.split("/");
	if(!(type !=null && type[0].equals("image"))){
		File f = mr.getFile("profile_img");
		f.delete();
	}
}
//sendRedirect
response.sendRedirect("../main.jsp");
 
%>
<body>
</body>
</html>