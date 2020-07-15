package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.RecipeDTO;

public class RecipeDAO {
	private Connection conn  = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	private static RecipeDAO instance = new RecipeDAO();
	public static RecipeDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env  = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();	
	}
	
	public List seletAllReceipe(int startrow, int endrow) {
		ArrayList recipeList = null;
		try {
			conn= getConnection();
			String sql = "";
			
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			
			
		}
		return recipeList= null;
		
	} 
	
	// 레시피내용만 가져오는 메서드
	public RecipeDTO selectRecipeBoard(int num) {
		RecipeDTO recipeBoard = null;
		try {
			conn = getConnection();
			String sql = "select * from recipe_board where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				recipeBoard = new RecipeDTO();
				recipeBoard.setNum(Integer.parseInt(rs.getString("num")));
				recipeBoard.setRecipeStep(Integer.parseInt(rs.getString("recipeStep")));
				recipeBoard.setRecipeName(rs.getString("recipeName"));
				recipeBoard.setThumbnail(rs.getString("thumbnail"));
				recipeBoard.setWriter(rs.getString("writer"));
				recipeBoard.setReg(rs.getTimestamp("reg"));
				recipeBoard.setVegiType(rs.getString("vegiType"));
				recipeBoard.setCookingTime(Integer.parseInt(rs.getString("cookingTime")));
				recipeBoard.setDifficulty(rs.getString("difficulty"));
				recipeBoard.setCal(Integer.parseInt(rs.getString("cal")));
				recipeBoard.setQuantity(Integer.parseInt(rs.getString("quantity")));
				recipeBoard.setIngredients(rs.getString("ingredients"));
				recipeBoard.setRating(Integer.parseInt(rs.getString("rating")));
				recipeBoard.setTag(rs.getString("tag"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return recipeBoard;
	}
	
	
	
}