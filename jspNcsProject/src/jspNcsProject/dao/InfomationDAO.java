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
	
	public InfomationDTO getInfomation(String num) {
		InfomationDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select num,subject,content,reg,img from information where num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = new InfomationDTO();
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setNum(rs.getInt("num"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setImg(rs.getString("img"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return dto;
	}
	
	//getInfomation OverLoading
	public List<InfomationDTO> getInfomation(int start,int end) {
		List<InfomationDTO> informationDTOList =new ArrayList<InfomationDTO>();
		try {
			conn = getConnection();
			String sql = "select num,subject,content,reg,img,r from "
					+ "(select num,subject,content,reg,img,rownum r from "
					+ "(select * from information ORDER BY num desc)) where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				InfomationDTO dto = new InfomationDTO();
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setNum(rs.getInt("num"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setImg(rs.getString("img"));
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
	
	public int getSearchInfoCount(String option, String search) {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from information where "+option+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return count;
	}
	
	public List getSearchInfo(int start, int end, String option, String search) {
		List infoList = new ArrayList<InfomationDTO>();
		try {
			conn = getConnection();
			String sql = "select num,subject,content,reg,img,r from "
					+ "(select num,subject,content,reg,img, rownum r from "
					+ "(select * from information where "+option+" like '%"+search+"%' ORDER BY num desc)) where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				InfomationDTO dto = new InfomationDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setImg(rs.getString("img"));
				 infoList.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return infoList;
	}
	
	public int getinfoCount() {
		int x = 0;
		try {
			conn = getConnection(); 	//DB에 쿼리문 날리기
			String sql = "select count(*) from information";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x= rs.getInt(1);	
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return x;
	}

}
