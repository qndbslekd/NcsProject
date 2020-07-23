package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RecommendDAO {
	
	private Connection conn= null;
	private ResultSet rs =null;
	private PreparedStatement pstmt = null;
	
	private static RecommendDAO instance = new RecommendDAO();
	public static RecommendDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context ctx = (Context)new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//추천하기
	public void insertRecommend(int freeboard_num, String mem_id) {
		try {
			conn =getConnection();
			String sql = "insert into recommend values(recommend_seq.nextVal,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, freeboard_num);
			pstmt.setString(2, mem_id);
			int result = pstmt.executeUpdate();
			if(result ==1) {
				sql="update freeboard set recommend = recommend+1 where num=?";
				pstmt.setInt(1, freeboard_num);
				pstmt.executeUpdate();
			}
			
		} catch (Exception e) {
			e.printStackTrace();			
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		
	}
	
	//추천 해제하기
	public void deleteRecommend(int freeboard_num, String member_id) {
		try {
			//추천여부 한번 확인해주고 해제하기
			boolean ch = checkRecommend(freeboard_num, member_id);
			if(ch == true) {
				conn= getConnection();
				String sql="delete from recommend where freeboard_num=? and member_id=?";
				pstmt.setInt(1, freeboard_num);
				pstmt.setString(2,member_id);
				int result = pstmt.executeUpdate();
				if(result == -1) {
					sql ="update freeboard set recommend = recommend-1 where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, freeboard_num);
					pstmt.executeUpdate();
				}
			}
				
		} catch (Exception e) {
			e.printStackTrace();			
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
	}

	//추천 여부 가져오기
	public boolean checkRecommend(int freeboard_num, String member_id) {
		boolean ch =false;
		try {
			conn =getConnection();
			String sql= "select * from recommend where freeboard_num=? and member_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, freeboard_num);
			pstmt.setString(2, member_id);
			rs = pstmt.executeQuery();
			if(rs.next()) ch=true;
			
		} catch (Exception e) {
			e.printStackTrace();			
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		return ch;
	}
	
	

}
