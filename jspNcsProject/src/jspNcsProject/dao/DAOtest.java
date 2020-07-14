package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DAOtest {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	//singleton
	private DAOtest() {}
	private static DAOtest instance = new DAOtest();
	public static DAOtest getInstance() {
		return instance;
	}
	 
	public Connection getConnection() throws Exception {
		Context ctx = (Context)new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	public int getTest() {
		try {
			String sql = "SELECT * FROM TEAM05_TESTTABLE";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getInt(1));
				System.out.println(rs.getString(2));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return 0;
	}
}
