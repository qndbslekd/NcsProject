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


public class RecipeContentDAO {
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	private static RecipeContentDAO instance = new RecipeContentDAO();
	public static RecipeContentDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 조리단계 내용 가져오는 메서드(list로 받아서 for문으로 돌려주면되나??)
	public List selectRecipeContent(int num) {
		ArrayList recipeContentList = null;
		try {
			conn = getConnection();
			String sql ="select * from RECIPE_CONTENT where RECIPE_NUM=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				recipeContentList = new ArrayList();
				do {
					RecipeContentDTO recipeContent = new RecipeContentDTO();
					recipeContent.setContent(rs.getString("content"));
					recipeContent.setImg(rs.getString("img"));
					recipeContent.setNum(rs.getInt("num"));
					recipeContent.setRecipe_num(rs.getInt("recipe_num"));
					recipeContent.setStep(rs.getInt("step"));
					
				}while(rs.next());
			}
			
		}catch(Exception e) {
			
		}finally {
			
		}
		
		return recipeContentList;
		// 먼저 dto에 담아준 후에!
		// recipeContentList에  recipeContent 객체에 통으로 던져줄 것임 
	}
	
}
