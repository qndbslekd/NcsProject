package jspNcsProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DAOconnection {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DAOconnection instance = new DAOconnection();	
	private DAOconnection() {}
	public DAOconnection getInstance() {
		return instance;
	}
}
