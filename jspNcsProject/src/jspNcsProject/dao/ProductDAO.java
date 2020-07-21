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

import jspNcsProject.dto.MemberDTO;
import jspNcsProject.dto.ProductDTO;
import jspNcsProject.dto.RecipeDTO;

public class ProductDAO {
	private Connection conn  = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	private static ProductDAO instance = new ProductDAO();
	public static ProductDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		Context ctx = (Context)new InitialContext();
		Context env  = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();	
	}
	
	//product 글 수 가져오기
	public int getProductCount() {
		int count = 0;
		try {
			conn= getConnection();
			String sql = "SELECT count(*) FROM product where re_level = 0 and re_step = 0";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			} 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try { conn.close();}catch(Exception e) {e.printStackTrace();}		
		}
		return count;
	}
	
	//product 검색된 글 수 가져오기
	public int getProductCount(String option,String search) {
		int countForSearch = 0;
		try {
			conn= getConnection();
			String sql =  "SELECT COUNT(*) FROM PRODUCT WHERE "+option+" LIKE '%"+search+"%' + and re_level = 0 and re_step = 0 ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				countForSearch = rs.getInt(1);
			} 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try { conn.close();}catch(Exception e) {e.printStackTrace();}		
		}
		return countForSearch;
	}
	
	//Product 최신순으로 검색하여 가져오기
		public List seletAllProduct(int startrow, int endrow, String mode,String option,String search) {
			ArrayList productList = null;
			try {
				conn= getConnection();
				String sql = "";
				if(mode.equals("num")) {
					sql = "select b.* from(select rownum r, a.* "
						+ "from(select * from product where "+option+" like '%"+search+"%' and re_level = 0  and re_step = 0 order by num desc)a order by num desc)b where r >= ? and r<=?";
				}else if(mode.equals("rating")) {//mode가 rating
					sql="select b.* from(select rownum r, a.* "
							+ "from(select * from product where "+option+" like '%"+search+"%' and re_level = 0  and re_step = 0 order by recommend desc, num desc)a order by recommend desc,num desc)b where r>=? and r<=?";			
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startrow);
				pstmt.setInt(2, endrow);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					productList = new ArrayList();
					do{
						ProductDTO product = new ProductDTO();
						product.setNum(rs.getInt("num"));
						product.setName(rs.getString("name"));
						product.setIngredients(rs.getString("ingredients"));
						product.setDetail(rs.getString("detail"));
						product.setProduct_img(rs.getString("product_img"));
						product.setReg(rs.getTimestamp("reg"));
						product.setRecommend(rs.getInt("recommend"));
						product.setRef(rs.getInt("ref"));
						product.setRe_level(rs.getInt("re_level"));
						product.setRe_step(rs.getInt("re_step"));
						productList.add(product);
					}while(rs.next());			
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null)try { conn.close();}catch(Exception e) {e.printStackTrace();}
				
			}
			return productList;
		} 
	
		//Product 최신순으로 가져오기
		public List seletAllProduct(int startrow, int endrow, String mode) {
			ArrayList productList = null;
			try {
				conn= getConnection();
				String sql = "";
				if(mode.equals("num")) {
					sql = "select b.* from(select rownum r, a.* "
						+ "from(select * from product where re_level = 0 and re_step = 0 order by num desc)a order by num desc)b where r >= ? and r<=?";
				}else if(mode.equals("rating")) {//mode가 rating
					sql="select b.* from(select rownum r, a.* "
							+ "from(select * from product where re_level = 0 and re_step = 0 order by recommend desc, num desc)a order by recommend desc,num desc)b where r>=? and r<=?";			
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startrow);
				pstmt.setInt(2, endrow);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					productList = new ArrayList();
					do{
						ProductDTO product = new ProductDTO();
						product.setNum(rs.getInt("num"));
						product.setName(rs.getString("name"));
						product.setIngredients(rs.getString("ingredients"));
						product.setDetail(rs.getString("detail"));
						product.setProduct_img(rs.getString("product_img"));
						product.setReg(rs.getTimestamp("reg"));
						product.setRecommend(rs.getInt("recommend"));
						product.setRef(rs.getInt("ref"));
						product.setRe_level(rs.getInt("re_level"));
						product.setRe_step(rs.getInt("re_step"));
						productList.add(product);
					}while(rs.next());			
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null)try { rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null)try { pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null)try { conn.close();}catch(Exception e) {e.printStackTrace();}
				
			}
			return productList;
		} 
	//제품 등록 
	public int insertProduct(ProductDTO dto) {
		int result=0;
		int ref = 0;
		try {
			conn = getConnection();
			String sql_ = "SELECT MAX(NUM) FROM PRODUCT";
			pstmt = conn.prepareStatement(sql_);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ref = rs.getInt(1);
			}
			
			String sql = "INSERT INTO product(num,name, ingredients, detail, product_img,reg,ref) values(seq_product.nextval,?,?,?,?,sysdate,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getName());
			pstmt.setString(2,dto.getIngredients());
			pstmt.setString(3,dto.getDetail());
			pstmt.setString(4,dto.getProduct_img());
			pstmt.setInt(5,ref+1);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return result;
	}
	
	public ProductDTO selectProduct(String num) {
		ProductDTO product = new ProductDTO();
		try {
			conn = getConnection();
			String sql = "select * from product where num = ?";
			pstmt = conn.prepareStatement(sql);
			int num_ = Integer.parseInt(num);
			pstmt.setInt(1, num_);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				product.setNum(rs.getInt("num"));
				product.setName(rs.getString("name"));
				product.setIngredients(rs.getString("ingredients"));
				product.setDetail(rs.getString("detail"));
				product.setProduct_img(rs.getString("product_img"));
				product.setReg(rs.getTimestamp("reg"));
				product.setRecommend(rs.getInt("recommend"));
				product.setRef(rs.getInt("ref"));
				product.setRe_level(rs.getInt("RE_LEVEL"));
				product.setRe_step(rs.getInt("RE_STEP"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) {try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try {conn.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return product;
	}
	//수정
	public int updateProduct(ProductDTO dto){
		int result = 0;
		try {
			String sql = "UPDATE PRODUCT SET DETAIL = ?,product_img=?, INGREDIENTS = ?, name=? where num = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getDetail());
			pstmt.setString(2, dto.getProduct_img());
			pstmt.setString(3, dto.getIngredients());
			pstmt.setString(4, dto.getName());
			pstmt.setInt(5,dto.getNum());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	//제품삭제
	public int deleteProduct(String num) {
		int result = 0;
		try {
			String sql = "DELETE FROM PRODUCT p2 WHERE num = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	//추천기능
	public void updateRecommend(String num) {
		try {
			String sql = "update PRODUCT set recommend = recommend+1 WHERE num = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
	}
	
	//제품 댓글 달기
	public int insertComment(String num,String name,String comment) {
		int result = 0;
		int ref = 0;
		try {
			conn= getConnection();
			
			String sql = "INSERT INTO PRODUCT(num,name,DETAIL,ingredients,REG,ref,re_level,re_step) "
					+ "VALUES (seq_product.nextval,?,?,'comment',sysdate,?,1,0)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2,comment);
			pstmt.setInt(3, Integer.parseInt(num));
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	//제품 답글 달기
	public int insertComment(String num,String name,String recomment,String beforeName) {
		int result = 0;
		try {
			conn = getConnection();
			String sql_selectRef = "select ref from product where num = ?";
			pstmt = conn.prepareStatement(sql_selectRef);
			pstmt.setInt(1, Integer.parseInt(num));
			rs = pstmt.executeQuery();
			int ref = 0;
			while(rs.next()) {
				ref = rs.getInt(1);
			}
						
			String sql = "INSERT INTO PRODUCT(num,name,INGREDIENTS,DETAIL,REG,ref,re_level,re_step) "
					+ "VALUES (seq_product.nextval,?,?,?,sysdate,?,1,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, beforeName);
			pstmt.setString(3,recomment);
			pstmt.setInt(4, ref);
			pstmt.setInt(5,Integer.parseInt(num));
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	//댓글을 가져오기
	public List<ProductDTO> selectComment(String num){
		List<ProductDTO> comment = new ArrayList<ProductDTO>();
		try {
			String sql = "select * from product where ref = ? AND re_level>0 and re_step = 0 ORDER BY num";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,Integer.parseInt(num));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setIngredients(rs.getString("ingredients"));
				dto.setDetail(rs.getString("detail"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setRe_step( rs.getInt("re_step"));
				dto.setReg(rs.getTimestamp("reg"));
				comment.add(dto);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return comment;
	}
	
	//답글을 가져오기
	public List<ProductDTO> selectRecomment(String num){
		List<ProductDTO> comment = new ArrayList<ProductDTO>();
		try {
			String sql = "SELECT DISTINCT p.* FROM PRODUCT p,PRODUCT p2 WHERE p.NAME = p2.INGREDIENTS AND p.RE_STEP =? ORDER BY p.reg";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,Integer.parseInt(num));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setIngredients(rs.getString("ingredients"));
				dto.setDetail(rs.getString("detail"));
				dto.setRe_level(rs.getInt("re_level")); 
				dto.setRe_step( rs.getInt("re_step"));
				dto.setReg(rs.getTimestamp("reg"));
				comment.add(dto);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return comment;
	}
	
	//댓글삭제
	public int deleteComment(String num, String name) {
		int result = 0;
		try {
			String sql = "DELETE FROM PRODUCT p2 WHERE num = ? and name=?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			pstmt.setString(2, name);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return result;
	}
}
