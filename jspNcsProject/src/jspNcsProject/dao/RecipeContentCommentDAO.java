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
			String sql = "SELECT * FROM RECIPE_CONTENT_COMMENT where content_num=? and recipe_num=? ORDER BY CONTENT_NUM ASC, RE_STEP ASC, REF ASC";
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
		String sql = "";
		

		try{
			conn = getConnection();
			
			sql = "SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME=('RECIPE_CONTENT_COMMENT_SEQ')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				num = rs.getInt(1)-1;

			}
			System.out.println("ref = " + num);
			if(reLevel == 1) {
				System.out.println("답글 한개 이미 달음");
				return;
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
				pstmt.setInt(3, num+1);
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
				System.out.println(ref);
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
	
	// 레시피 답글 체크하는 메서드(relevel 최대값 리턴해줌) 
	public int selectMaxRelevel(int ref) {
		int maxReLevel = 0;
		// 최대값이 1 미만이면 false, 1이상이면 true
		try {
			conn = getConnection();
			String sql = "select max(re_level) from RECIPE_CONTENT_COMMENT where ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				maxReLevel = rs.getInt(1);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null) try {rs.close();}catch(Exception e) { e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
		return maxReLevel;
	}
	
	// 댓글 정보 가져오는 메서드 dto에 담아서 리턴.
	public RecipeContentCommentDTO selectRecipeStepComment(int num) {
		RecipeContentCommentDTO dto = new RecipeContentCommentDTO();
		
		try {
			conn = getConnection();
			String sql = "select * from RECIPE_CONTENT_COMMENT where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setContent(rs.getString("content"));
				dto.setContentNum(rs.getInt("content_num"));
				dto.setName(rs.getString("name"));
				dto.setNum(num);
				dto.setRecipeNum(rs.getInt("recipe_num"));
				dto.setRef(rs.getInt("ref"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReLevel(rs.getInt("re_level"));
				dto.setReStep(rs.getInt("re_step"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) { e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
		
		return dto; 
	} 
	
	// 조리단계별 댓글 수정해주는 메서드 
	public void updateRecipeStepComment(int num, String content) {
		try {
			conn = getConnection();
			String sql = "update RECIPE_CONTENT_COMMENT set content=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
	}
	
	// 댓글 삭제 위한 ref 개수 체크 메서드 
	public int countRecipeStepCommentRef(int ref) {
		int count=0;
		try {
			conn = getConnection();
			String sql = "select count(ref) from RECIPE_CONTENT_COMMENT where ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null) try {rs.close();}catch(Exception e) { e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
		return count;
	}
	
	// 댓글 1개만 있는 경우 삭제
	public void deleteRecipeStetpcomment(int num) {
		try {
			conn = getConnection();
			String sql = "delete from RECIPE_CONTENT_COMMENT where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
	
	}
	
	// 댓글 + 답글 한꺼번에삭제
	public void deleteRecipeStepAllComment(int ref) {
		try {
			conn = getConnection();
			String sql ="delete from RECIPE_CONTENT_COMMENT where ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.executeUpdate();			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}	
	}
	

	
	// 작성자 아이디로 레시피 조리단계별 총 댓글 수 가져오기(name이 id값임)
	public int getMyRecipeStepCommentCount(String writer) {
		int count = 0;
		try {
			conn= getConnection();
			String sql = "SELECT count(*) FROM recipe_content_comment where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			} 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try { conn.close();}catch(Exception e) {e.printStackTrace();}		
		}
		return count;
	}
	
	// 작성자 아이디로 댓글 가져오기(범위만큼)
	public List selectMyRecipeStepComment(int start, int end, String writer) {
		ArrayList myStepCommentList = null;
		try {
			conn = getConnection();
			String sql = "SELECT rcc.* FROM(SELECT rownum AS r, rcc.* FROM (SELECT rcc.* FROM RECIPE_CONTENT_COMMENT rcc WHERE name = ? ORDER BY rcc.reg ASC) rcc)rcc WHERE r >= ? AND r <= ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				myStepCommentList = new ArrayList();
				do {
					RecipeContentCommentDTO stepComment = new RecipeContentCommentDTO();
					stepComment.setContent(rs.getString("content"));
					stepComment.setContentNum(rs.getInt("content_num"));
					stepComment.setName(writer);
					stepComment.setNum(rs.getInt("num"));
					stepComment.setRecipeNum(rs.getInt("recipe_num"));
					stepComment.setRef(rs.getInt("ref"));
					stepComment.setReg(rs.getTimestamp("reg"));
					stepComment.setReLevel(rs.getInt("re_level"));
					stepComment.setReStep(rs.getInt("re_step"));
					myStepCommentList.add(stepComment);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}	
		return myStepCommentList;
	}
		
}
