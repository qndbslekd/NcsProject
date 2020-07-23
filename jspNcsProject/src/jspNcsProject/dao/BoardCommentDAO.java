package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jspNcsProject.dto.BoardCommentDTO;
import jspNcsProject.dto.FreeBoardDTO;


public class BoardCommentDAO {
	private Connection conn= null;
	private ResultSet rs =null;
	private PreparedStatement pstmt = null;
	
	private static BoardCommentDAO instance = new BoardCommentDAO();
	public static BoardCommentDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
		Context ctx = (Context)new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	public List selectAllBoardComment(int num) {
		ArrayList commentList = null;
		try {			
			conn = getConnection();
			String sql = "select * from freeboard_comment where freeboard_num =? order by ref asc, comment_num asc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				commentList = new ArrayList();
				do {
					BoardCommentDTO comment = new BoardCommentDTO();
					comment.setComment_num(rs.getInt("comment_num"));
					comment.setFreeboard_num(rs.getInt("freeboard_num"));
					comment.setRef(rs.getInt("ref"));
					comment.setRe_level(rs.getInt("re_level"));
					comment.setReg(rs.getTimestamp("reg"));
					comment.setReceiver(rs.getString("receiver"));
					comment.setWriter(rs.getString("writer"));
					comment.setContent(rs.getString("content"));
					commentList.add(comment);
				}while(rs.next());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)	try {rs.close();} catch (Exception e) {e.printStackTrace();	}
			if (pstmt != null)	try {pstmt.close();	} catch (Exception e) {	e.printStackTrace();}
			if (conn != null)	try {conn.close();} catch (Exception e) {e.printStackTrace();}			
		}	
		return commentList;
	}
	//댓글 고유번호로 댓글 하나만 가져오기
	public BoardCommentDTO selectBoardComment(int comment_num) {
		BoardCommentDTO comment = null;
		
		try {
			
			conn = getConnection();
			
			String sql = "select * from freeboard_comment where comment_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, comment_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				comment = new BoardCommentDTO();				
				comment.setComment_num(rs.getInt("comment_num"));
				comment.setFreeboard_num(rs.getInt("freeboard_num"));
				comment.setRef(rs.getInt("ref"));
				comment.setRe_level(rs.getInt("re_level"));
				comment.setReg(rs.getTimestamp("reg"));
				comment.setReceiver(rs.getString("receiver"));
				comment.setWriter(rs.getString("writer"));
				comment.setContent(rs.getString("content"));
			}
							
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
		
		return comment;
	}
		
	
	public void insertBoardComment(BoardCommentDTO comment) {
		try {	
			conn=  getConnection();
			if(comment.getRef()!=0) {//기존댓글에 대한 답글 쓰기
				int re_level = comment.getRe_level()+1;
				String sql = "insert into freeboard_comment values(freeboard_comment_seq.nextVal,?,?,?,sysdate,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, comment.getFreeboard_num());
				pstmt.setInt(2, comment.getRef());
				pstmt.setInt(3, re_level);
				pstmt.setString(4, comment.getReceiver());
				pstmt.setString(5, comment.getWriter());
				pstmt.setString(6, comment.getContent());
				pstmt.executeQuery();		
			}else {//새댓글
				String sql="insert into freeboard_comment values(freeboard_comment_seq.nextVal,?,freeboard_comment_seq.currVal,0,sysdate,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, comment.getFreeboard_num());
				pstmt.setString(2, null);//receiver
				pstmt.setString(3, comment.getWriter());
				pstmt.setString(4, comment.getContent());
				pstmt.executeQuery();		
			};				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)	try {pstmt.close();	} catch (Exception e) {	e.printStackTrace();}
			if (conn != null)	try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
	}
	
	public String selectNameById(String id) {
		String name = null;	
		try {		
			conn = getConnection();		
			String sql = "select name from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();			
			if(rs.next()) {
				name = rs.getString(1);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}	
		return name;
	}
	
	//id 받고 이미지 반환
	public String selectImgById(String id) {
		String img = null;
		
		try {
			
			conn = getConnection();
			
			String sql = "select profile_img from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				img = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return img;
	}
	//댓글 하나 삭제
	public void deleteBoardComment(int comment_num) {
		try {
			
			conn = getConnection();
			
			String sql = "delete from freeboard_comment where comment_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, comment_num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
	}
	

	
	// id로 댓글 총 개수 체크
	public int getMyFreeBoardCommentCount(String writer) {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from freeboard_comment where writer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
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
		
	// id로 글 가져오기(범위만큼)
	public List selectMyFreeBoardComment(int start, int end, String writer) {
		ArrayList myFreeBoardCommentList = null;
		try {
			conn = getConnection();
			String sql = "SELECT fc.* FROM(SELECT rownum AS r, fc.* FROM (SELECT fc.* FROM FREEBOARD_COMMENT fc WHERE writer = ? ORDER BY fc.reg asc) fc)fc WHERE r >= ? AND r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				myFreeBoardCommentList = new ArrayList();
				do {
					BoardCommentDTO comment = new BoardCommentDTO();
					comment.setComment_num(rs.getInt("comment_num"));
					comment.setContent(rs.getString("content"));
					comment.setFreeboard_num(rs.getInt("freeboard_num"));
					comment.setRe_level(rs.getInt("re_level"));
					comment.setReceiver(rs.getString("receiver"));
					comment.setRef(rs.getInt("ref"));
					comment.setReg(rs.getTimestamp("reg"));
					comment.setWriter(writer);
					myFreeBoardCommentList.add(comment);
				}while(rs.next());
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return myFreeBoardCommentList;
	}

	//댓글 수정
	public void updateBoardComment(int comment_num,String content) {
		try {
			
			conn = getConnection();
			
			String sql = "update freeboard_comment set content=? where comment_num=?";			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, comment_num);
			
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(Exception e) {e.printStackTrace();}
		}
	}

	
	
>>>>>>> branch 'develop' of https://github.com/ysk0951/codinnnnng.git
	

}
