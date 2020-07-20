package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.TagDTO;

public class TagDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private static TagDAO instance = new TagDAO();
	public static TagDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	public ArrayList searchTagList(String tagWhereQuery) {
		ArrayList searchTagList = null;
		try {
			conn= getConnection();
			String sql = "select a.* from(select rownum r, b.* from(select * from tag "+ tagWhereQuery + " order by taggedTimes desc)b order by taggedTimes desc)a "
					+ "where r<=20";
			pstmt = conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				searchTagList = new ArrayList();
				do {				
					TagDTO tag = new TagDTO();
					tag.setTag(rs.getString("tag"));
					searchTagList.add(tag);				
				}while(rs.next());	
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return searchTagList;
	}
	
	public void updateTag(String tag) {
		try {
			conn = getConnection();
			String sql = "select * from tag where tag=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tag);
			rs= pstmt.executeQuery();	
			if(!rs.next()) {//해당 태그명에 대한 검색결과가 없는경우
				sql = "insert into tag values(?,1)";
				pstmt =  conn.prepareStatement(sql);
				pstmt.setString(1, tag);
				pstmt.executeQuery();	
			}else {//검색결과가 있는 경우; taggedTimes증가
				sql ="update tag set taggedTimes = taggedTimes+1 where tag=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, tag);
				pstmt.executeQuery();			
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try{rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
}
