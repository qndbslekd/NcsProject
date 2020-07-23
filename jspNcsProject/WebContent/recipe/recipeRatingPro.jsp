<%@page import="jspNcsProject.dao.RatingDAO"%>
<%@page import="jspNcsProject.dto.RatingDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평점 처리</title>
</head>
<%
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String memId = (String) session.getAttribute("memId");
	
	if(memId==null) {
		%><script>alert("회원만 평점을 남길 수 있습니다."); self.close(); </script><%
	} else {
		
		int rate = Integer.parseInt(request.getParameter("rate"));
		
		RatingDTO dto = new RatingDTO();
		dto.setRate(rate);
		dto.setRater(memId);
		dto.setRecipeNum(num);
		
		RatingDAO dao = RatingDAO.getInstance();
		
		String TF = request.getParameter("TF");
		if(TF.equals("true")) { //기존에 평점 남긴 적 있으면
			//삭제하고
			dao.deleteRating(num, memId);
		}
		
		//평점 작성 후
		dao.insertRating(dto);
		//레시피의 평점(평균) 업데이트
		dao.updateRating(num);
%>
<script>
	opener.parent.location.reload();
	window.close();
</script>
<body>

</body>
<%} %>
</html>