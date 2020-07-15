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
			pstmt.setString(4,dto.getId_number());
			pstmt.setString(5,dto.getAge());
			pstmt.setString(6,dto.getGender());
			pstmt.setString(7,dto.getVegi_type());
			pstmt.setString(8,dto.getProfile_img());
			pstmt.setString(9,null);//offence URL
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
	
	public boolean loginCheck(String id, String pw) {
		boolean result = false;
		System.out.println(id);
		System.out.println(pw);
		try {
			String sql = "select * from member where id=? and pw=?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}else {
				System.out.println("return FALSE");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}		
		}
		return result;
	}
	
	public String getMemberName(String id, String pw) {
		String result="";
		try {
			conn = getConnection();
			String sql = "SELECT name FROM MEMBER WHERE id=? AND pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString("name");
				System.out.println(result);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}		
		}
		return result;
	}
	
	public int deleteMember(String id) {
		int result=0;
		try {
			conn = getConnection();
			String sql = "delete from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		System.out.println(result);
		return result;
	}
	
	
}
