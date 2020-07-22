package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
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
	
	private static FreeBoardDAO instance = new FreeBoardDAO();
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
	
	//검색결과 글수 가져오기
	public int getArticlesCount(String whereQuery) {
		int count = 0;
		try {
			conn =getConnection();
			String sql = "select count(*) from freeboard "+whereQuery;
			
			pstmt = conn.prepareStatement(sql);;
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
	//날짜 기준으로 가져오기
	public int getArticlesCount(Timestamp date) {
		int count = 0;
		System.out.println(date);
		try {
			conn =getConnection();
			String sql = "select count(*) from freeboard where reg >= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, date);
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
	//검색결과 글수를 날짜 기준으로 받아오기
	public int getArticlesCount(Timestamp date,String whereQuery) {
		int count = 0;
		try {
			conn =getConnection();
			String sql = "select count(*) from freeboard "+whereQuery+" reg>=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, date);
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
	
	//전체리스트
	public List selectAllArticle(int startRow, int endRow) {
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
					FreeBoardDTO article = new FreeBoardDTO();
					article.setNum(rs.getInt("num"));
					article.setTitle(rs.getString("title"));
					article.setWriter(rs.getString("writer"));
					article.setCategory(rs.getString("category"));
					article.setContent(rs.getString("content"));
					article.setReg(rs.getTimestamp("reg"));
					article.setRecommend(rs.getInt("recommend"));
					article.setRead_count(rs.getInt("read_count"));
					article.setRef(rs.getInt("ref"));
					article.setRe_level(rs.getInt("re_level"));
					article.setRe_step(rs.getInt("re_step"));
					articles.add(article);
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
	
	//검색결과 전체리스트
	public List selectAllArticle(int startRow, int endRow, String whereQuery) {
		ArrayList articles = null;
		try {
			conn = getConnection();
			String sql = "SELECT a.*from(SELECT rownum r, b.* "
					+ "from(SELECT * FROM freeboard "+whereQuery+" ORDER BY REF DESC, re_level ASC)b ORDER BY REF DESC, re_level asc)a "
					+ "WHERE r>=? AND r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articles = new ArrayList();
				do {
					FreeBoardDTO article = new FreeBoardDTO();
					article.setNum(rs.getInt("num"));
					article.setTitle(rs.getString("title"));
					article.setWriter(rs.getString("writer"));
					article.setCategory(rs.getString("category"));
					article.setContent(rs.getString("content"));
					article.setReg(rs.getTimestamp("reg"));
					article.setRecommend(rs.getInt("recommend"));
					article.setRead_count(rs.getInt("read_count"));
					article.setRef(rs.getInt("ref"));
					article.setRe_level(rs.getInt("re_level"));
					article.setRe_step(rs.getInt("re_step"));
					articles.add(article);
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
	
	public FreeBoardDTO selectArticle(int num) {
		FreeBoardDTO article = null;
		
		try {
			conn = getConnection();
			
			//조회수 올리기
			String sql ="update freeboard set read_count=read_count+1 where num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql ="select * from freeboard where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new FreeBoardDTO();
				article.setNum(rs.getInt("num"));
				article.setTitle(rs.getString("title"));
				article.setWriter(rs.getString("writer"));
				article.setCategory(rs.getString("category"));
				article.setContent(rs.getString("content"));
				article.setReg(rs.getTimestamp("reg"));
				article.setRead_count(rs.getInt("read_count"));
				article.setRecommend(rs.getInt("recommend"));
				article.setRef(rs.getInt("ref"));
				article.setRe_level(rs.getInt("re_level"));
				article.setRe_step(rs.getInt("re_step"));
				article.setImg(rs.getString("img"));
			}		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null)	try {rs.close();} catch (Exception e) {e.printStackTrace();	}
			if (pstmt != null)	try {pstmt.close();	} catch (Exception e) {	e.printStackTrace();}
			if (conn != null)	try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return article;
	}
	
	public void insertArticle(FreeBoardDTO article) {
		int num = article.getNum();
		int ref= article.getRef();
		int re_level = article.getRe_level();
		int re_step = article.getRe_step();
		int number = 0; 
		try {		
			conn=  getConnection();
			String sql = "select max(num) from freeboard";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				number = rs.getInt(1)+1;
			}else {
				number = 1;
			}
			if(num != 0) {//답글쓰기
				sql = "update freeboard set re_step= re_step+1 where ref=? and re_step>?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeQuery();
				re_step = re_step+1;
				re_level = re_level+1;
				
			}else {//글쓰기
				ref = number;
				re_step = 0;
				re_level = 0;
			}		
			sql = "insert into freeboard values(freeboard_seq.nextVal,?,?,?,?,sysdate,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getTitle());
			pstmt.setString(2, article.getWriter());
			pstmt.setString(3, article.getCategory());
			pstmt.setString(4, article.getContent());
			pstmt.setInt(5, article.getRead_count());
			pstmt.setInt(6, article.getRecommend());
			pstmt.setInt(7, ref);
			pstmt.setInt(8, re_step);
			pstmt.setInt(9, re_level);
			pstmt.setString(10, article.getImg());
			pstmt.executeQuery();		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)	try {rs.close();} catch (Exception e) {e.printStackTrace();	}
			if (pstmt != null)	try {pstmt.close();	} catch (Exception e) {	e.printStackTrace();}
			if (conn != null)	try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
	}
	
	public int updateArticle(FreeBoardDTO article) {
		int x= -1;

		try {
			conn = getConnection();
			String sql = "update freeboard set title=?, category=?, content=?, img=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getTitle());
			pstmt.setString(2, article.getCategory());
			pstmt.setString(3, article.getContent());
			pstmt.setString(4, article.getImg());
			pstmt.setInt(5, article.getNum());
			pstmt.executeUpdate();	
			x= 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)	try {pstmt.close();	} catch (Exception e) {	e.printStackTrace();}
			if (conn != null)	try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return x;
	}
	
	public void deleteArticle(int num) {
		try {
			FreeBoardDTO article = selectArticle(num);
			conn= getConnection();
			String sql = "delete from freeboard where ref=? and re_step >=0";
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(1, article.getRef());
			pstmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)	try {pstmt.close();	} catch (Exception e) {	e.printStackTrace();}
			if (conn != null)	try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
	}
	
	public void updateRecommend(int num) {
		try {
			conn = getConnection();
			String sql="update freeboard set recommend = recommend+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeQuery();		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)	try {pstmt.close();	} catch (Exception e) {	e.printStackTrace();}
			if (conn != null)	try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
	
	
	}
	
	//id 받고 활동명 반환
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
	//활동명받고 아이디반환
	public String selectIdByName(String name) {
		String id = null;	
		try {		
			conn = getConnection();		
			String sql = "select id from member where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
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
		return id;
	}
	

}
