package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.MemberDTO;

public class MemberDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	//singleton
	private MemberDAO() {}
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context ctx = (Context)new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	public int insertMember(MemberDTO dto) {
		int result = 0;
		try {
			//11개
			String sql = "INSERT INTO MEMBER values(?,?,?,?,?,?,?,?,0,?,'활동',sysdate)";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getId());
			pstmt.setString(2,dto.getPw());
			pstmt.setString(3,dto.getName());
			pstmt.setString(4,dto.getAge());
			pstmt.setString(5,dto.getId());
			pstmt.setString(6,dto.getId());
			pstmt.setString(7,dto.getId());
			pstmt.setString(8,dto.getId());
			pstmt.setString(9,dto.getId());
			result = pstmt.executeUpdate();
			System.out.println("[Insert된 회원의 수"+result+"]");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//close block
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return result;
	}
}
