package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ScrapDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private static ScrapDAO instance = new ScrapDAO();
	public static ScrapDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//찜하기
	public void insertScrapRecipe(int num, String scraper) {
		try {
			conn  = getConnection();
			
			String sql = "insert into scrap values(scrap_seq.nextVal,"+num+",'"+scraper+"')";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
	}
	
	
	//찜 취소
	public void deleteScrapRecipe(int num, String scraper) {
		try {
			conn  = getConnection();
			
			String sql = "delete from scrap where recipe_num=? and scraper=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, scraper);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
	}
	
	//찜 여부 확인
	public boolean confirmScrap(int num, String scraper) {
		boolean x = false;
		
		try {
			
			conn = getConnection();
			
			String sql = "select * from scrap where recipe_num=? and scraper=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, scraper);
			
			rs = pstmt.executeQuery();

			if(rs.next()) {
				x = true;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
		return x;
	}
	
	//id 받고 스크랩한 레시피 리스트 반환
	public List selectScrapRecipe(String id) {
		List list = null;
		List numList = null;
		
		try {
			
			conn = getConnection();
			
			//레시피 번호 리스트 만들기
			String sql = "select recipe_num from scrap where scraper=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				numList = new ArrayList();
				do {
					numList.add(rs.getInt(1));
				} while(rs.next());
				//레시피 번호로 정보 가져오기
				RecipeDAO dao = RecipeDAO.getInstance();
				list = new ArrayList();
				for(int i = 0; i < numList.size(); i++) {
					list.add(dao.selectRecipeBoard((int)(numList.get(i))));
				}
			}
			

			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
		return list;
	}
	
	//글번호에 해당하는 스크랩 정보 모두 삭제
	public void deleteScrapAllByNum(int num) {
		try {
			conn = getConnection();
			
			String sql = "delete from scrap where recipe_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
	}
}
