<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="jspNcsProject.dao.MemberDAO"%>
<%@page import="jspNcsProject.dto.MemberDTO"%>
<%@page import="java.util.Enumeration"%>
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
	String path = request.getRealPath("save");
	int max = 1024*1024*5; //5MB byte 단위 
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); //중복파일금지
	if(session.getAttribute("memId")==null){%>
	<script type="text/javascript">
		alert("로그인후 이용해주세요.");
		window.location = "../main.jsp";
	</script>
<%}else{
	if (request.getContentType()!=null) {
		MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
		String profile_img="";
		if(mr.getFilesystemName("profile_img")==null){
			profile_img= mr.getParameter("profile_img_before");
		}else{
			profile_img= mr.getFilesystemName("profile_img");
		}
		System.out.println("[DTO profileIMG:"+profile_img+"]");
		String pw = mr.getParameter("pw");
		String name = mr.getParameter("name");
		String vegi_type = mr.getParameter("vegi_type");
		System.out.println("pw"+pw);
		System.out.println("name"+name);
		System.out.println("vegi_type"+vegi_type);
		MemberDTO dto = new MemberDTO();
		dto.setId(session.getAttribute("memId").toString());
		dto.setProfile_img(profile_img);
		dto.setPw(pw);
		dto.setName(name);
		dto.setVegi_type(vegi_type);
		MemberDAO dao = MemberDAO.getInstance();
		int update = dao.updateMember(dto);
		
		//delete before img file
		//if(!request.getParameter("profile_img").equals("")){
		//	File f = mr.getFile("profile_img_before");
		//	f.delete();
		//}
		//이미지 파일만 업로드하기
		String contentType = mr.getContentType("profile_img");
		if(contentType!=null){
			String[] type = contentType.split("/");
			if(!(type !=null && type[0].equals("image"))){
				File f = mr.getFile("profile_img");
				f.delete();
			}
		}
	}else{
		System.out.println("비정상적인 접근");
		response.sendRedirect("../main.jsp");
		return;
	}
	//img null point 방지
	//기존 이미지를 등록해놓지 않았을 경우
	response.sendRedirect("../logoutPro.jsp");
	return;
}
%> 
<body>
</body>
</html>