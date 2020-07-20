package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.RecipeCommentDTO;

public class RecipeCommentDAO {
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	private static RecipeCommentDAO instance = new RecipeCommentDAO();
	public static RecipeCommentDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//일괄 삭제
	public void deleteRecipeCommentAll(int num) {
		try {
			
			conn = getConnection();
			
			String sql = "delete from recipe_comment where recipe_num=?";
			
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
	
	//레시피 번호로 댓글 모두 가져오기
	public List selectRecipeCommentAll(int num) {
		List list = null;
		
		try {
			
			conn = getConnection();
			
			String sql = "select * from recipe_comment where recipe_num=? order by ref asc, num asc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList();
				do {
					RecipeCommentDTO dto = new RecipeCommentDTO();
					
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setReceiver(rs.getString("receiver"));
					dto.setContent(rs.getString("content"));
					dto.setRecipeNum(rs.getInt("recipe_num"));
					dto.setReLevel(rs.getInt("re_level"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setRef(rs.getInt("ref"));
					
					list.add(dto);
				} while(rs.next());
			}
			
					
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
		
		return list;
	}
	
	
	
	
	//댓글 작성
	public void insertRecipeComment(RecipeCommentDTO dto) {
		try {
			
			conn = getConnection();
			
			if(dto.getRef()!=0) {//받아온 ref값이 있다면(대댓글이라면)

				
				//기존 댓글들 re_step 하나씩 뒤로 미뤄주기 (새로 달린 대댓글이 위로)
//				String sql = "update recipe_comment set re_step=re_step+1 where ref=?";
//				pstmt = conn.prepareStatement(sql);
//				pstmt.setInt(1, dto.getRef());
//				pstmt.executeUpdate();
				
				String sql = "insert into recipe_comment values(recipe_comment_seq.nextVal, ?,?,?,?,?,?,sysdate)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getRecipeNum());
				pstmt.setInt(2, dto.getRef()); //ref값 그대로넣어주고
				pstmt.setInt(3, dto.getReLevel());
				pstmt.setString(4, dto.getContent());
				pstmt.setString(5, dto.getName());
				pstmt.setString(6, dto.getReceiver());
				
				pstmt.executeUpdate();
				
			} else {	//ref값이 없다면(일반댓글이라면) 고유번호=ref 같도록
				
				
				
				//새 댓글 삽입
				String sql = "insert into recipe_comment values(recipe_comment_seq.nextVal, ?,recipe_comment_seq.currVal,?,?,?,?,sysdate)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getRecipeNum());
				pstmt.setInt(2, dto.getReLevel());
				pstmt.setString(3, dto.getContent());
				pstmt.setString(4, dto.getName());
				pstmt.setString(5, null);
				pstmt.executeUpdate();
				
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
	}
	
	//댓글 고유번호로 댓글 하나만 가져오기
	public RecipeCommentDTO selectRecipeComment(int num) {
		RecipeCommentDTO dto = null;
		
		try {
			
			conn = getConnection();
			
			String sql = "select * from recipe_comment where num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new RecipeCommentDTO();
				
				dto.setNum(num);
				dto.setName(rs.getString("name"));
				dto.setReceiver(rs.getString("receiver"));
				dto.setContent(rs.getString("content"));
				dto.setRecipeNum(rs.getInt("recipe_num"));
				dto.setRef(rs.getInt("ref"));
				dto.setReLevel(rs.getInt("re_level"));
				dto.setReg(rs.getTimestamp("reg"));
			}
					
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
		
		return dto;
	}
	
	
	//댓글 수정
	public void updateRecipeComment(int num,String content) {
		try {
			
			conn = getConnection();
			
			String sql = "update recipe_comment set content=? where num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, num);
			
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
	}
	
	//댓글 하나 삭제
	public void deleteRecipeComment(int num) {
		try {
			
			conn = getConnection();
			
			String sql = "delete from recipe_comment where num=?";
			
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
}
