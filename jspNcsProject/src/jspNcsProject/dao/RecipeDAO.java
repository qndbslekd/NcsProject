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
	
	public List seletAllReceipe(int startrow, int endrow) {
		ArrayList recipeList = null;
		try {
			conn= getConnection();
			String sql = null;
			
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			
			
		}
		return recipeList= null;
		
	} 
	
	
	
}
