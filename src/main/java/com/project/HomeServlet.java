package com.project;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String apiKey = "abeabd49919f4aafe92338a31ded7745";
		List<String> cities = new ArrayList<String>();
		List<String> temperatures = new ArrayList<String>();
		
		try {
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","9652");
			PreparedStatement stmt = con.prepareStatement("SELECT city_name FROM citiestab");
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				String city = rs.getString("city_name");
				cities.add(city);
				
				String apiURL = "https://api.openweathermap.org/data/2.5/weather?q=" +city+"&appid=" + apiKey;			
				String jsonRes = fetch(apiURL);
				JsonObject json = JsonParser.parseString(jsonRes).getAsJsonObject();
				double temp = json.getAsJsonObject("main").get("temp").getAsDouble();
				temperatures.add(String.valueOf(temp));
			}
		con.close();
		}
			catch (Exception e) {
				e.printStackTrace();
			}
		
		request.setAttribute("cities", cities);
		request.setAttribute("temperatures", temperatures);
		request.getRequestDispatcher("Home.jsp").forward(request, response);
	}
		private String fetch(String apiURL) throws URISyntaxException, IOException {
				URI	uri = new URI(apiURL);
				URL url = uri.toURL();
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String inputLine;
				StringBuilder content = new StringBuilder();
				while((inputLine = in.readLine()) != null) {
					content.append(inputLine);
				}
				in.close();
				conn.disconnect();
				return content.toString();

		}
}
