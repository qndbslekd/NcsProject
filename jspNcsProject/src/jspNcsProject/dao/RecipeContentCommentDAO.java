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
					dto.setContentNum(contentNum);
					dto.setName(rs.getString("name"));
					dto.setNum(rs.getInt("num"));
					dto.setReLevel(rs.getInt("re_level"));
					dto.setReStep(rs.getInt("re_step"));
					dto.setRecipeNum(rs.getInt("recipe_num"));
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
	
	// 레시피 댓글 or 답글 다는 메서드 ref로 체크해서 처리.
	public void insertRecipeContentComment(RecipeContentCommentDTO dto) {
		int ref = dto.getRef();
		int reStep = dto.getReStep();
		int reLevel = dto.getReLevel();
		int contentNum = dto.getContentNum();
		int num = 0;
		System.out.println("ref :" + ref);
		String sql = "";
		

		try{
			conn = getConnection();
			
			sql = "SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME=('RECIPE_CONTENT_COMMENT_SEQ')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {			
				num = rs.getInt(1);

			}
			
			
			if(ref == 0) { // 댓글인 경우 
				sql = "update recipe_content_comment set re_step=re_step+1 where content_Num=? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, contentNum);
				pstmt.setInt(2, reStep);
				pstmt.executeUpdate();		

				reStep = reStep+1;
				reLevel = 0;
						
				sql = "insert into recipe_content_comment(num, recipe_num, content_num, ref, re_level, re_step, content, name, reg) values(recipe_content_comment_seq.nextVal,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, dto.getRecipeNum());
				pstmt.setInt(2, dto.getContentNum());
				pstmt.setInt(3, num);
				pstmt.setInt(4, reLevel);
				pstmt.setInt(5, reStep);
				pstmt.setString(6, dto.getContent());
				pstmt.setString(7, dto.getName());
				pstmt.setTimestamp(8, dto.getReg());
				
				
			}else{ // 댓글의 댓글인 경우(답글) ref는 0 이 아님 
				// 댓글의 댓글일 경우 ref는 가져온 ref값 그대로 넣어주면됨
				sql = "update recipe_content_comment set re_step=re_step+1 where content_Num=? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, contentNum);
				pstmt.setInt(2, reStep);
				pstmt.executeUpdate();
				
				reStep = reStep + 1;
				reLevel = reLevel + 1;								
				System.out.println("메서드에서 ref : " + ref );
				sql = "insert into recipe_content_comment(num, recipe_num, content_num, ref, re_level, re_step, content, name, reg) values(recipe_content_comment_seq.nextVal,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, dto.getRecipeNum());
				pstmt.setInt(2, dto.getContentNum());
				pstmt.setInt(3, ref);
				pstmt.setInt(4, reLevel);
				pstmt.setInt(5, reStep);
				pstmt.setString(6, dto.getContent());
				pstmt.setString(7, dto.getName());
				pstmt.setTimestamp(8, dto.getReg());
			}
					
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) { e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
	}
	
}
