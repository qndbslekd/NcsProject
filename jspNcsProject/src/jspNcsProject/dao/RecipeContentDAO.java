package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.RecipeContentDTO;

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
	
	
	//레시피 내용 작성
	public void insertRecipeContent(RecipeContentDTO dto) {
		
		try {
			conn = getConnection();
			
			String sql = "insert into recipe_content values(recipe_content_seq.nextVal, ?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 1);
			pstmt.setInt(2, dto.getStep());
			pstmt.setString(3, dto.getImg());
			pstmt.setString(4, dto.getContent());
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) { e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) { e.printStackTrace();}
		}
	}
}
