package recipe;

import java.sql.Timestamp;

public class RecipeContentCommentDTO {
	/*
	num	number	고유번호
	recipe_num	number	recipe테이블의 PK
	content_num	number	recipe_content테이블의 PK
	ref	number	댓글 그룹
	re_level	number	댓글 단계값
	re_step	number	댓글 정렬값
	content	varchar2(2000)	댓글 내용
	name	varchar2(200)	member의 활동명(name)
	reg	date	작성 시간
	*/
	
	int num;
	int recipeNum;
	int contentNum;
	int ref;
	int reLevel;
	int reStep;
	String content;
	String name;
	Timestamp reg;
	
}
