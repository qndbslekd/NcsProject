<%@page import="jspNcsProject.dao.ProductDAO"%>
<%@page import="org.apache.catalina.ha.backend.Sender"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<%	if(session.getAttribute("memName")==null||
		request.getParameter("comment")==null||
		request.getParameter("num")==null){ %>
		<script type="text/javascript">
			alert("로그인후 가능합니다");
			window.location = "http://localhost:8080/jnp/member/loginForm.jsp";
		</script>
	<%}else{
		request.setCharacterEncoding("UTF-8");
		System.out.println("PRO페이지 호출");
	
		ProductDAO dao = ProductDAO.getInstance();
		String comment = request.getParameter("comment");
		String num = request.getParameter("num");
		String name = session.getAttribute("memName").toString();
	
		if(comment.equals("")){
			//추천일경우만
			//추천한지 24시간이 안지난 경우
			boolean isExistCookie = false;
			Cookie[] cookies = request.getCookies();
			for(Cookie cookie : cookies){
				if(cookie.getName().equals("recommend")){
					isExistCookie = true;
					System.out.println("ON :"+isExistCookie);
				}
			}
			
			if(!isExistCookie){
				Cookie recommend = new Cookie("recommend","on");
				recommend.setMaxAge(60*60*24);
				response.addCookie(recommend);
				dao.updateRecommend(request.getParameter("num"));
				%>
				<script type="text/javascript">
					alert("추천되었습니다");
					window.location = "<%=request.getParameter("history")%>";
				</script>
				<%
			}else{
				%>
				<script type="text/javascript">
					alert("추천은 하루에 한번만 가능합니다");
					history.go(-1);
				</script>
				<%
			}
		}else{
			//댓글달기이 경우
			System.out.println("num" + num);
			System.out.println("name" + name);
			System.out.println("comment" + comment);
			
			int result  = dao.insertComment(num,name,comment);
			System.out.println(result+"개의 댓글이작성되었습니다");
			response.sendRedirect(request.getParameter("history"));
		}
	}
%>
</body>
</html>