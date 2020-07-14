<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 작성</title>
</head>
<body>
	<form>
		<table>
			<tr>
				<td>제목</td>
				<td><input type="text" name="recipeName"/></td>
			</tr>
			<tr>
				<td>채식유형</td>
				<td>
					<input type="radio" name="vegiType" value="vegan"/>비건<br/>
					
				</td>
			</tr>
		</table>
	</form>

</body>
</html>