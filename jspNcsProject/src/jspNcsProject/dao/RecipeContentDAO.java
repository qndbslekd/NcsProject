package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.RecipeContentDTO;
import jspNcsProject.dto.RecipeDTO;

public class RecipeContentDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private RecipeContentDAO() {}
	private static RecipeContentDAO instance = new RecipeContentDAO();
	public static RecipeContentDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context ctx = (Context)new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//레시피 정보 작성
	public int insertRecipeBoard(RecipeDTO dto) {
		int x = 0;
		
		try {
			conn = getConnection();
			
			String sql = "insert into recipe_board values(recipe_board_seq.nextVal, ?,?,?,?,sysdate,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getRecipeStep());
			pstmt.setString(2, dto.getRecipeName());
			pstmt.setString(3, dto.getThumbnail());
			pstmt.setString(4, dto.getWriter());
			pstmt.setString(5, dto.getVegiType());
			pstmt.setString(6, dto.getDifficulty());
			pstmt.setInt(7, dto.getCal());
			pstmt.setInt(8, dto.getQuantity());
			pstmt.setString(9, dto.getIngredients());
			pstmt.setInt(10, 0);
			pstmt.setString(11, dto.getTag());
			pstmt.setInt(12, dto.getCookingTime());
			
			pstmt.executeUpdate();
			
			
			//글 num의 최대값 가져와서 리턴
			sql = "select max(num) from recipe_board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();}catch(Exception e) { e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
		
		return x;
	}
	//레시피 세부 내용 작성
	public void insertRecipeContent(List list) {
		try {
			conn = getConnection();
			
			String sql = "insert into recipe_content values(recipe_content_seq.nextVal,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			for(int i = 0; i < list.size(); i++) {
				
				RecipeContentDTO dto = (RecipeContentDTO) list.get(i);
				
				pstmt.setInt(1, dto.getRecipeNum());
				pstmt.setInt(2, dto.getStep());
				pstmt.setString(3, dto.getImg());
				pstmt.setString(4, dto.getContent());
				pstmt.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
	}
	
	//레시피 세부 내용 수정
	public void updateRecipeContent(List list, int oriStep) {
		
		try {
			conn = getConnection();
			
			
			//기존 단계만큼은 정해진 num 대로 적기
			String sql = "insert into recipe_content values(?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			for(int i = 0; i < oriStep; i++) {
				RecipeContentDTO dto = (RecipeContentDTO) list.get(i);
				
				pstmt.setInt(1, dto.getNum());
				pstmt.setInt(2, dto.getRecipeNum());
				pstmt.setInt(3, dto.getStep());
				pstmt.setString(4, dto.getImg());
				pstmt.setString(5, dto.getContent());
				pstmt.executeUpdate();
			}
			
			//기존 단계보다 높은 부분은 seq로 새로 num 부여
			sql = "insert into recipe_content values(recipe_content_seq.nextVal,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			for(int i = oriStep; i < list.size(); i++) {
				
				RecipeContentDTO dto = (RecipeContentDTO) list.get(i);
				
				pstmt.setInt(1, dto.getRecipeNum());
				pstmt.setInt(2, dto.getStep());
				pstmt.setString(3, dto.getImg());
				pstmt.setString(4, dto.getContent());
				pstmt.executeUpdate();
			}
			
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
	}
	
	//레시피 세부 내용만 가져오기
	public List selectRecipeContent(int num) {
		List list = null;
		
		try {
			conn = getConnection();
			
			String sql = "select * from recipe_content where recipe_num=? order by step asc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList();
				do {
					RecipeContentDTO dto = new RecipeContentDTO();
					dto.setNum(rs.getInt("num"));
					dto.setRecipeNum(num);
					dto.setStep(rs.getInt("step"));
					dto.setImg(rs.getString("img"));
					dto.setContent(rs.getString("content"));
					
					list.add(dto);
					
				} while(rs.next());
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs !=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt !=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn !=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return list;
	}
	
	
	//레시피 수정
	public void updateRecipeBoard(RecipeDTO dto) {
		try {
			conn = getConnection();
			
			String sql = "UPDATE RECIPE_BOARD SET recipe_step=?, recipe_name=?,thumbnail=?,vegi_type=?,difficulty=?,cal=?,quantity=?,ingredients=?,tag=?,cooking_time=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getRecipeStep());
			pstmt.setString(2, dto.getRecipeName());
			pstmt.setString(3, dto.getThumbnail());
			pstmt.setString(4, dto.getVegiType());
			pstmt.setString(5, dto.getDifficulty());
			pstmt.setInt(6, dto.getCal());
			pstmt.setInt(7, dto.getQuantity());
			pstmt.setString(8, dto.getIngredients());
			pstmt.setString(9, dto.getTag());
			pstmt.setInt(10, dto.getCookingTime());
			pstmt.setInt(11, dto.getNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt !=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn !=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	//레시피 세부 내용 삭제
	public void deleteRecipeContent(int num) {
		try {
			conn = getConnection();
			
			
			String sql = "delete from recipe_content where recipe_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt !=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn !=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
}
