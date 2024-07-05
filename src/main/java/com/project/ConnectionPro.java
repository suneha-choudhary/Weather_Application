package com.project;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionPro {
	private static Connection con;
	
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","9652");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
