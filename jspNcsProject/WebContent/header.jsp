<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<link href="../resource/team05_style.css" type="text/css" rel="stylesheet"/>

<title>header</title>
<style>

#header {
	width: 1000px;
	border-collapse: collapse;
}

#header .title {
	font-size: 40px;
}

#header .tab {
	width: 250px;
	background-color: rgb(139, 195, 74);
}

a:link {
	text-decoration: none;
}

a:visited {
	text-decoration: none;
	color: #ffff;
}

a:hover {
	text-decoration: underline;
	color: #559AFC;
}

#header .title {
	font-size: 40px;
}

#header .tab {
	width: 250px;
	background-color: rgb(139, 195, 74);
}

a:link {
	text-decoration: none;
	color: #ffff;
}

a:visited {
	text-decoration: none;
	color: #ffff;
}

a:active {
	text-decoration: none;
	color: #ffff;
}

a:hover {
	text-decoration: underline;
	color: #559AFC;
}
</style>
</head> 
<%
	System.out.println("===HEADER START===");
	System.out.println("Header Session값 : "+session.getAttribute("memId"));
	if(session.getAttribute("memId")==null){ //비로그인상태(세션없을때)
		// 세션이 없지만 쿠키가 있는지 2중 체크
		String id = null, pw = null, auto = "n",name = null; 
		Cookie[] cookies = request.getCookies();
		if(cookies !=null){ 
			for(Cookie cookie : cookies){
				System.out.println("Cookie Null Test :"+cookie.getName());
				if(cookie.getName().equals("autoId")){
					id = cookie.getValue();
					System.out.println("쿠키 아이디 :"+id);
					}		
				if(cookie.getName().equals("autoPw")){
					pw = cookie.getValue();
					System.out.println("쿠키 pw :"+pw);
					}		
				if(cookie.getName().equals("autoCh")) {
					auto = cookie.getValue();
					System.out.println("쿠키 auto :"+auto);
					}
				if(cookie.getName().equals("autoName")) {
					name = cookie.getValue();
					System.out.println("쿠키 name :"+name);
					}	
			}
		} 
		if(auto.equals("y")&&id!=null&&pw!=null){
			System.out.println("loginPro Header Redirect TEST2 : session = cookie ");
			session.setAttribute("memId", id);
			session.setAttribute("memName", name);
		}
		System.out.println("===HEADER END===");
	}
%>
<body>
	<table id="header">
		<tr>
			
			<td class="title" colspan="4">
			<img src="/jnp/leaf.png" width="100px"/>
			<a href="/jnp/main.jsp">BEGIN VEGAN</a>
			</td>
		<tr>
			<td>
			<td>
			<td>
			<%if(session.getAttribute("memId") == null){
			%>
			<td>
				<button onclick="window.location='/jnp/member/loginForm.jsp'">로그인</button>
				<button onclick="window.location='/jnp/member/signupForm.jsp'">회원가입</button>
			</td>
			<%}else{%>
			<td>
				<p><%=session.getAttribute("memId")%>님</p>		
				<button onclick="window.location='/jnp/logoutPro.jsp'">로그아웃</button>
				<button onclick="window.location='/jnp/member/myPage.jsp'">마이페이지</button>
			</td>
			<%} %>
		</tr>
		<tr>
			<td class="tab" onclick="window.location='/jnp/information/information.jsp'">채식정보</td>
			<td class="tab" onclick="window.location='/jnp/recipe/recipeList.jsp?mode=num'">레시피</td>
			<td class="tab" onclick="window.location='/jnp/product/productList.jsp'">제품</td>
			<td class="tab" onclick="window.location='/jnp/freeboard/board.jsp'">자유게시판</td>
		</tr>
	</table>
</body>
</html>