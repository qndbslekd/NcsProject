package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.RatingDTO;

public class RatingDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static RatingDAO instance = new RatingDAO();
	public static RatingDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context) ctx.lookup("java:comp/env");
		DataSource ds = (DataSource) env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	//글 번호, 회원 아이디로 평점 조회(평점 준 적 있는지 확인)
	public RatingDTO selectRating(int num, String id) {
		RatingDTO dto = null;
		
		try {
			
			conn = getConnection();
			
			String sql = "select * from rating where recipe_num=? and rater=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new RatingDTO();
				dto.setNum(rs.getInt("num"));
				dto.setRecipeNum(rs.getInt("recipe_num"));
				dto.setRate(rs.getInt("rate"));
				dto.setRater(rs.getString("rater"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close();} catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try { pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		return dto;
	}
	
	//평점 삭제
	public void deleteRating(int num, String id) {
		try {
			
			conn = getConnection();
			
			String sql = "delete from rating where recipe_num=? and rater=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
					
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close();} catch(Exception e) {e.printStackTrace();}
		}
	}
	
	//평점 남기기
	public void insertRating(RatingDTO dto) {
		try {
			
			conn = getConnection();
			
			String sql = "insert into rating values(rating_seq.nextVal,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getRate());
			pstmt.setInt(2, dto.getRecipeNum());
			pstmt.setString(3, dto.getRater());
			pstmt.executeUpdate();
					
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close();} catch(Exception e) {e.printStackTrace();}
		}
	}
	
	//레시피 정보의 평점 수정
	public void updateRating(int num) {
		try {
			
			conn = getConnection();
			
			String sql = "update recipe_board set rating=(select avg(rate) from rating where recipe_num=?) where num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close();} catch(Exception e) {e.printStackTrace();}
		}
	}
	
	//글번호에 해당하는 평점들 list로 가져오기
	public int getCountRating(int num) {
		int count = 0; 
		try {
			conn= getConnection();
			String sql = "select count(rate) from rating where recipe_num=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close();} catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try { pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
}
