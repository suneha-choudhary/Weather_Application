package com.project;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","9652");
			String username=request.getParameter("User_name");
			String password=request.getParameter("Password");
			
			PreparedStatement pstmt = con.prepareStatement("SELECT * FROM login WHERE username=? AND password=?");
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				HttpSession session = request.getSession();
				session.setAttribute("uname", username);
				response.sendRedirect("Home.jsp");
			}
			else {
				
				out.println("<html><body>");
				out.println("<font color=red size=20 background=Lightblue>InValid Username or Password!!<br>");
				out.println("<a href=LoginUser.jsp>Please Try Again!!<br>");
				out.println("</body></html>");
				RequestDispatcher rd = request.getRequestDispatcher("LoginUser.jsp");
				rd.forward(request, response);
			}
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
