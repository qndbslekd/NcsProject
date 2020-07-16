package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.InfomationDTO;

public class InfomationDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	//singleton
	private InfomationDAO() {}
	private static InfomationDAO instance = new InfomationDAO();
	public static InfomationDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context ctx = (Context)new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	public List<InfomationDTO> getInfomation() {
		List<InfomationDTO> informationDTOList =new ArrayList<InfomationDTO>();
		try {
			conn = getConnection();
			String sql = "select * from INFORMATION ORDER BY NUM";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				InfomationDTO dto = new InfomationDTO();
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setNum(rs.getInt("num"));
				informationDTOList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return informationDTOList;
	}
	
	public int updateInfomation(String num,String subject,String content) {
		int result=0; 
		try {
			conn = getConnection();
			String sql = "UPDATE INFORMATION SET SUBJECT =?,CONTENT =? WHERE NUM = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setInt(3, Integer.parseInt(num));
			result= pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return result;
	}
}
