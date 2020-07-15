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
	Enumeration names =  request.getParameterNames();
	System.out.println("==MemberModifyProPrameters==");
	while(names.hasMoreElements()){
		System.out.println(names.nextElement().toString());
	}
	String profile_img = request.getParameter("profile_img");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String vegi_type = request.getParameter("vegi_type");
	
	MemberDTO dto = new MemberDTO();
	dto.setId(session.getAttribute("memId").toString());
	dto.setProfile_img(profile_img);
	dto.setPw(pw);
	dto.setName(name);
	dto.setVegi_type(vegi_type);
	MemberDAO dao = MemberDAO.getInstance();
	int update = dao.updateMember(dto);
%>
<body>
</body>
</html>