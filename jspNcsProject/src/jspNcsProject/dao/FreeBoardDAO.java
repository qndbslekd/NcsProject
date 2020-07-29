
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
			String sql = "select count(*) from freeboard "+whereQuery+" and reg>=?";
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
	public List selectAllArticle(int startRow, int endRow, String mode) {
		ArrayList articles = null;
		try {
			conn = getConnection();
			String sql = "SELECT a.*from(SELECT rownum r, b.* "
					+ "from(SELECT * FROM freeboard ORDER BY "+mode+" DESC)b ORDER BY "+mode+" DESC)a "
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
					article.setFix(rs.getString("fix"));
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
	public List selectAllArticle(int startRow, int endRow, String whereQuery,String mode) {
		ArrayList articles = null;
		try {
			
			conn = getConnection();
			String sql = "SELECT a.*from(SELECT rownum r, b.* "
					+ "from(SELECT * FROM freeboard "+whereQuery+" ORDER BY "+mode+" DESC)b ORDER BY "+mode+" DESC)a "
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
					article.setFix(rs.getString("fix"));
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
	
	public FreeBoardDTO selectArticle(int num, String route) {
		FreeBoardDTO article = null;
		
		try {
			conn = getConnection();
			String sql= null;
			//조회수 올리기
			if(!route.equals("recommend")) {
			sql ="update freeboard set read_count=read_count+1 where num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			}
			
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
				article.setFix(rs.getString("fix"));
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
		try {		
			conn=  getConnection();
			String sql = "select max(num) from freeboard";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			sql = "insert into freeboard values(freeboard_seq.nextVal,?,?,?,?,sysdate,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getTitle());
			pstmt.setString(2, article.getWriter());
			pstmt.setString(3, article.getCategory());
			pstmt.setString(4, article.getContent());
			pstmt.setInt(5, article.getRead_count());
			pstmt.setInt(6, article.getRecommend());
			pstmt.setString(7, article.getImg());
			pstmt.setString(8, "F");
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
			conn= getConnection();
			String sql = "delete from freeboard where num=?";
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql="delete from freeboard_comment where freeboard_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
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
				id = rs.getString(1);
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
	
	// id로 글 총 개수 가져오기
	public int getMyFreeBoardCount(String writer) {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from freeboard where writer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try { conn.close();}catch(Exception e) {e.printStackTrace();}		
		}
		return count;
	}
	
	// id로 글 가져오기(범위만큼)
	public List selectMyFreeContent(int start, int end, String writer) {
		ArrayList myFreeContentList = null;
		try {
			conn = getConnection();
			String sql = "SELECT f.* FROM(SELECT rownum AS r, f.* FROM (SELECT f.* FROM FREEBOARD f WHERE writer = ? ORDER BY f.reg desc) f)f WHERE r >= ? AND r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				myFreeContentList = new ArrayList();
				do {
					FreeBoardDTO content = new FreeBoardDTO();
					content.setCategory(rs.getString("category"));
					content.setContent(rs.getString("content"));
					content.setImg(rs.getString("img"));
					content.setNum(rs.getInt("num"));
					content.setRead_count(rs.getInt("read_count"));
					content.setRecommend(rs.getInt("recommend"));
					content.setFix(rs.getString("fix"));
					content.setReg(rs.getTimestamp("reg"));
					content.setTitle(rs.getString("title"));
					content.setWriter(writer);		
					myFreeContentList.add(content);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}	
		return myFreeContentList;
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
		

	// num으로 글 한개 가져오기 
	public FreeBoardDTO selectParentArticle(int num) {
		FreeBoardDTO article = null;
		try {
			conn = getConnection();
			String sql = "select * from freeboard where num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new FreeBoardDTO();
				article.setCategory(rs.getString("category"));
				article.setContent(rs.getString("content"));
				article.setImg(rs.getString("img"));
				article.setNum(num);
				article.setRead_count(rs.getInt("read_count"));
				article.setRecommend(rs.getInt("recommend"));
				article.setFix(rs.getString("fix"));
				article.setReg(rs.getTimestamp("reg"));
				article.setTitle(rs.getString("title"));
				article.setWriter(rs.getString("writer"));		
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	return article;
	}
	
	//관리자 페이지 신고처리이용
	public String getSeq(String booleanCheckNum) {
		String result = "";
		try {			
			conn = getConnection();				
			String sql = "SELECT  FREEBOARD_NUM FROM FREEBOARD_COMMENT WHERE COMMENT_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(booleanCheckNum));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString(1);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	

}
