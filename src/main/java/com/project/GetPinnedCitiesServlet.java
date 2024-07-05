package com.project;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//@WebServlet("/getPinnedCities")
public class GetPinnedCitiesServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/project";
    private static final String DB_USER = "root"; 
    private static final String DB_PASSWORD = "9652";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT pincity, temperature, description FROM pinned_cities WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    org.json.JSONArray cities = new org.json.JSONArray();
                    while (rs.next()) {
                        org.json.JSONObject city = new org.json.JSONObject();
                        city.put("pincity", rs.getString("pincity"));
                        city.put("temperature", rs.getString("temperature"));
                        city.put("description", rs.getString("description"));
                        cities.put(city);
                    }
                    response.getWriter().write(cities.toString());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
