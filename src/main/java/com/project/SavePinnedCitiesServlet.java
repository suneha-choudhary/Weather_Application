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
import java.sql.SQLException;

//@WebServlet("/savePinnedCities")
public class SavePinnedCitiesServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/project";
    private static final String DB_USER = "root"; 
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String citiesJson = request.getParameter("pinnedCities");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            String deleteQuery = "DELETE FROM pinned_cities WHERE username = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
                deleteStmt.setString(1, username);
                deleteStmt.executeUpdate();
            }


            String insertQuery = "INSERT INTO pinned_cities (username, pincity, temperature, description) VALUES (?, ?, ?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {

            	org.json.JSONArray cities = new org.json.JSONArray(citiesJson);
                for (int i = 0; i < cities.length(); i++) {
                    org.json.JSONObject city = cities.getJSONObject(i);
                    insertStmt.setString(1, username);
                    insertStmt.setString(2, city.getString(citiesJson));
                    insertStmt.setString(3, city.getString("temperature"));
                    insertStmt.setString(4, city.getString("description"));
                    insertStmt.addBatch();
                }
                insertStmt.executeBatch();
            }

            response.getWriter().write("Pinned cities saved");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

