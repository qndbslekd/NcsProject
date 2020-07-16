package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.RecipeContentCommentDTO;

public class RecipeContentCommentDAO {
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	private static RecipeContentCommentDAO instance = new RecipeContentCommentDAO();
	public static RecipeContentCommentDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//일괄 삭제
	public void deleteRecipeContentCommentAll(int num) {
		try {
			
			conn = getConnection();
			
			String sql = "delete from recipe_content_comment where recipe_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
	}
	
	// 레시피 조리단계별 댓글 가져오는 메서드 : 이것도 list로 받아서 for문 
	public List selectRecipeContentComment(int contentNum, int recipeNum) {
		List list = null;
		try {
		
			conn = getConnection();	
			String sql = "SELECT * FROM RECIPE_CONTENT_COMMENT where content_num=? and recipe_num=? ORDER BY CONTENT_NUM ASC, REF ASC, RE_STEP ASC";
			pstmt = conn.prepareStatement(sql);	
			pstmt.setInt(1, contentNum);
			pstmt.setInt(2, recipeNum);
	
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList();
				do {
					RecipeContentCommentDTO dto = new RecipeContentCommentDTO();
					dto.setContent(rs.getString("content"));
					dto.setContent_num(contentNum);
					dto.setName(rs.getString("name"));
					dto.setNum(rs.getInt("num"));
					dto.setRe_level(rs.getInt("re_level"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRecipe_num(rs.getInt("recipe_num"));
					dto.setRef(rs.getInt("ref"));
					dto.setReg(rs.getTimestamp("reg"));
					list.add(dto);
				}while(rs.next());
			}		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) { e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}		
		return list;
	}
	
	
}
