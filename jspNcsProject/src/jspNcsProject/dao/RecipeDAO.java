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
	
	private static RecipeDTO instance = new RecipeDTO();
	public static RecipeDTO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env  = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();	
	}
	
	//recipe_board 글 수 가져오기
	public int getRecipeCount() {
		int count = 0;
		try {
			conn= getConnection();
			String sql = "select count(*) from recipe_board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) count = rs.getInt("1");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try { conn.close();}catch(Exception e) {e.printStackTrace();}		
		}
		
		return count;
	}
	
	//recipeList 최신순으로 가져오기
	public List seletAllReceipeByReg(int startrow, int endrow) {
		ArrayList recipeList = null;
		try {
			conn= getConnection();
			String sql = "select b.* from(select rownum r, a.* "
					+ "from(select * from recipe_board order by num desc)a order by num desc)b where r >= ? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				recipeList = new ArrayList();
				do{
					RecipeDTO recipe = new RecipeDTO();
					recipe.setNum(rs.getInt("num"));
					recipe.setRecipeName(rs.getString("recipe_name"));
					recipe.setThumbnail(rs.getString("thumbnail"));
					recipe.setWriter(rs.getString("writer"));	
					recipe.setRating(0);
					recipeList.add(recipe);				
				}while(rs.next());			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try { conn.close();}catch(Exception e) {e.printStackTrace();}
			
		}
		return recipeList= null;
		
	} 
	
	//평점순으로 가져오기
	public List seletAllReceipeByRating(int startrow, int endrow) {
		ArrayList recipeList = null;
		try {
			conn= getConnection();
			String sql = "select b.* from(select rownum r, a.* "
					+ "from(select * from recipe_board order by rating desc)a order by rating desc)b where r >= ? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				recipeList = new ArrayList();
				do{
					RecipeDTO recipe = new RecipeDTO();
					recipe.setNum(rs.getInt("num"));
					recipe.setRecipeName(rs.getString("recipe_name"));
					recipe.setThumbnail(rs.getString("thumbnail"));
					recipe.setWriter(rs.getString("writer"));	
					recipe.setRating(0);
					recipeList.add(recipe);				
				}while(rs.next());			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try { conn.close();}catch(Exception e) {e.printStackTrace();}
			
		}
		return recipeList= null;
		
	} 
	
	
	
}
