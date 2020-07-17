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
			String sql = "SELECT count(*) FROM product";
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
			String sql =  "SELECT COUNT(*) FROM PRODUCT WHERE "+option+" LIKE '%"+search+"%'";
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
						+ "from(select * from product where "+option+" like '%"+search+"%' order by num desc)a order by num desc)b where r >= ? and r<=?";
				}else if(mode.equals("rating")) {//mode가 rating
					sql="select b.* from(select rownum r, a.* "
							+ "from(select * from product where "+option+" like '%"+search+"%' order by recommend desc, num desc)a order by recommend desc,num desc)b where r>=? and r<=?";			
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
	
	//Product 최신순으로 가져오기
	public List seletAllProduct(int startrow, int endrow, String mode) {
		ArrayList productList = null;
		try {
			conn= getConnection();
			String sql = "";
			if(mode.equals("num")) {
				sql = "select b.* from(select rownum r, a.* "
					+ "from(select * from product order by num desc)a order by num desc)b where r >= ? and r<=?";
			}else if(mode.equals("rating")) {//mode가 rating
				sql="select b.* from(select rownum r, a.* "
						+ "from(select * from product order by recommend desc, num desc)a order by recommend desc,num desc)b where r>=? and r<=?";			
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
	
	public ProductDTO updateProduct(String name){
		ProductDTO result = null;
		try {
			String sql = "select * from member where id = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if(rs.next()){
				
			}
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
