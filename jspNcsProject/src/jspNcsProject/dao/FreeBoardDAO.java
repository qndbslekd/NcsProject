package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.FreeBoardDTO;

public class FreeBoardDAO {
	private Connection conn= null;
	private ResultSet rs =null;
	private PreparedStatement pstmt = null;
	
	private static FreeBoardDAO instance = null;
	public static FreeBoardDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context ctx = (Context)new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	public int getArticlesCount() {
		int count = 0;
		try {
			conn =getConnection();
			String sql = "select count(*) from freeboard";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)	try {rs.close();} catch (Exception e) {e.printStackTrace();	}
			if (pstmt != null)	try {pstmt.close();	} catch (Exception e) {	e.printStackTrace();}
			if (conn != null)	try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return count;
	}
	
	public List getArticles(int startRow, int endRow) {
		ArrayList articles = null;
		try {
			conn = getConnection();
			String sql = "SELECT a.*from(SELECT rownum r, b.* "
					+ "from(SELECT * FROM freeboard ORDER BY REF DESC, re_level ASC)b ORDER BY REF DESC, re_level asc)a "
					+ "WHERE r>=? AND r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articles = new ArrayList();
				do {
//					FreeBoardDTO article = new FreeBoardDTO();
//					article.setNum(rs.getInt("num"));
//					article.setTitle(rs.getString("title"));
//					article.setWriter(rs.getString("writer"));
//					article.setCategory(rs.getString("category"));
//					article.setReg("reg");
//					article.setReg(rs.getTimestamp("reg"));
//					article.setReadcount(rs.getInt("readcount"));
//					article.setIp(rs.getString("ip"));
//					article.setRef(rs.getInt("ref"));
//					article.setRe_step(rs.getInt("re_step"));
//					article.setRe_level(rs.getInt("re_level"));
//					article.setArticlePw(rs.getString("articlepw"));
//					articles.add(article);
				}while(rs.next());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)	try {rs.close();} catch (Exception e) {e.printStackTrace();	}
			if (pstmt != null)	try {pstmt.close();	} catch (Exception e) {	e.printStackTrace();}
			if (conn != null)	try {conn.close();} catch (Exception e) {e.printStackTrace();}
			
		}
		
		return articles;
	}
	
	
	
	
}
