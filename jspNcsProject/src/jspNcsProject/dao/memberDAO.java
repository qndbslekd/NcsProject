package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class memberDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	//singleton
	private memberDAO() {}
	private static memberDAO instance = new memberDAO();
	public static memberDAO getInstance() {
		return instance;
	}
}
