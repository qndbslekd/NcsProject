package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
	
	//레시피 정보 넣기
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
	
	//레시피 세부 내용 넣기
	public void insertRecipeContent(RecipeContentDTO dto) {
		
		try {
			conn = getConnection();
			
			String sql = "insert into recipe_content values(recipe_content_seq.nextVal, ?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getRecipeNum());
			pstmt.setInt(2, dto.getStep());
			pstmt.setString(3, dto.getImg());
			pstmt.setString(4, dto.getContent());
			
			pstmt.executeUpdate();
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
	}
}
