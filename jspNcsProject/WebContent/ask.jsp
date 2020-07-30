<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의하기</title>
<link href="resource/team05_style.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="header.jsp" flush="false">
	<jsp:param value="ask" name="mode"/>
</jsp:include>

문의사항은 아래의 연락처로 주시면 답변해드리겠습니다<br/><br/>

메일 : admin@beginVegan.com <button class="greenButton" onclick="window.location='mailto:admin@beginVegan.com'" >메일 보내기</button>


<br/>
<br/>

</body>
</html>