package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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
}
