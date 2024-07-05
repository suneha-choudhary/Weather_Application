<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="english">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Weather Application</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="icon" href="images/favicon.ico">

<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Poppins", sans-sarif;
}

body {
	display: flex;
	justify-content: left;
	padding: 0 3rem 0 2.625rem;
	align-items: center;
	min-height: 100vh;
	background: url('images/imag.jpg') no-repeat center center;
	background-size: cover;
	background-position: center;
	overflow: hidden;
}

.container {
	position: relative;
	width: 31rem;
	height: 80vh;
	background: rgba(255, 255, 255, .1);
	backdrop-filter: blur(3.875rem);
	border: 0.125rem solid rgba(255, 255, 255, .7);
	border-radius: 1rem;
	padding: 1rem;
	color: white;
	transition: height .3s ease;
	margin: 0.2em;
}

.search-box, .coord-box {
	position: relative;
	width: 100%;
	height: 1.638rem;
	display: flex;
	align-items: center;
	margin: 0.2rem;
}

.search-box i, .coord-box i {
	position: absolute;
	left: 0.625rem;
	font-size: 1.45rem;
}

.search-box input, .coord-box input {
	position: absolute;
	width: 100%;
	height: 100%;
	background: transparent;
	border: 0.125rem solid rgba(255, 255, 255, .4);
	outline: none;
	border-radius: 0.625;
	font-size: 1.375rem;
	color: white;
	font-weight: 500;
	text-transform: uppercase;
	padding: 0 3rem 0 2.625rem;
}

.search-box input::placeholder, .coord-box input::placeholder {
	color: white;
	text-transform: capitalize;
	background: transparent;
}

.search-box button, .coord-box button {
	position: absolute;
	right: 0;
	width: 2.5rem;
	height: 100%;
	background: transparent;
	border: none;
	outline: none;
	font-size: 1.45rem;
	color: white;
	padding: 0 2.5rem 0 0.313rem;
	cursor: pointer;
}

.weather-box {
	text-align: center;
	margin: 2.5rem 0;
}

.weather-box, .weather-details, .not-found {
	overflow: hidden;
	visibility: hidden;
}

.weather-box.active, .weather-details.active, .not-found.active {
	visibility: visible;
}

.weather-box .box, .not-found .box {
	transform: translateY(-100%);
}

.weather-box.active .box, .not-found.active .box {
	transform: translateY(0%);
	transition: transform 1s ease;
	transition-delay: .6s;
}

.weather-box .box .info-weather {
	transform: translate(-120%);
}

.container.active .weather-box .box .info-weather, .container.active .weather-details .humidity .info-humidity,
	.container.active .weather-details .wind .info-wind {
	transform: translateY(0%);
	transition: transform 1s ease;
}

.weather-box img {
	width: 60%;
}

.weather-box .temperature {
	position: relative;
	font-size: 4rem;
	line-height: 1;
	font-weight: 700;
	margin: 1.25rem 0 0.375rem -1.875rem;
}

.weather-box .temperature span {
	position: absolute;
	font-size: 1.5rem;
	margin-left: 0.25;
}

.weather-box .description {
	font-size: 1.375rem;
	font-weight: 500;
	text-transform: capitalize;
}

.weather-details {
	position: absolute;
	bottom: 2.5rem;
	left: 0;
	width: 100%;
	padding: 0 1.25rem;
	display: flex;
}

.weather-details .humidity, .weather-details .wind {
	display: flex;
	align-items: center;
	width: 50%;
	transform: traslateY(-100%);
}

.weather-details.active .humidity, .weather-details.active .wind {
	transform: translateY(0%);
	transition: transform 1s ease;
	transition-delay: 1.2s;
}

.weather-details .humidity {
	padding-left: 1.25rem;
	justify-content: flex-start;
}

.weather-details .wind {
	padding-left: 1.25rem;
	justify-content: flex-end;
}

.weather-details i {
	font-size: 3.5rem;
	margin-right: 0.625rem;
}

.weather-details span {
	display: inline-block;
	font-size: 1.375rem;
	font-weight: 500;
}

.weather-details p {
	font-size: 0.975rem;
	font-weight: 800;
}

.not-found {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	text-align: center;
	margin-top: 6.875rem;
}

.not-found img {
	width: 65%;
}

.not-found p {
	font-size: 1.375rem;
	font-weight: 500;
	margin-top: 0.75rem;
}

.city-hide {
	display: none;
}

 #clone-info-weather, #clone-info-humidity, #clone-info-wind { 
 	position: absolute; 
 	transform: translateY(-100%); 
 }

#clone-info-weather .weather {
	transform: translateY(120%);
	transition: transform 1s ease, opacity 0s;
	transition-delay: 0s, 2s;
}

.weather-box:not(.active) #clone-info-weather .weather {
	opacity: 0;
	transition-delay: 0s;
}

.active-clone#clone-info-weather .weather {
	transform: translateY(0%);
}

.logout {
	position: fixed;
	top: 0;
	right: 0;
	margin: 0.8em;
	z-index: 1;
	border: 0.12rem solid rgba(255, 255, 255, .7);
	border-radius: 0.25em;
	padding: 0.5em 1em;
	color: white;
	font-size: 1.2rem;
	text-align: justify;
	display: flex;
	justify-content: flex-end;
	align-items: flex-start;
	backdrop-filter: blur(3.875rem);
	font-weight: 500;
}

.logout:hover {
	background-color: #ecebed;
}

.cards {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin: 0.8em;
	border: 0.125rem solid rgba(255, 255, 255, .7);
	border-radius: 1em;
	justify-content: right;
	height: 80vh;
	width: 80vw;
	backdrop-filter: blur(3.875rem);
	box-shadow: 0 0 1em rgba(0, 0, 0, 0.1);
}

.currentDate {
	margin: 1em;
	border-radius: 1em;
	justify-content: right;
	height: 13em;
	width: 51rem;
	padding: 0 3rem 0 2.625rem;
	backdrop-filter: blur(3.875rem);
	flex-wrap: nowrap;
	color: white;
}

.currentDate h1 {
	font-size: 2em;
	color: white;
}

.AverageTemp {
	margin: 1em;
	border-radius: 1em;
	justify-content: right;
	height: 16em;
	width: 51rem;
	padding: 0 3rem 0 2.625rem;
	backdrop-filter: blur(3.875rem);
}

.AverageTemp .startDate, .AverageTemp .endDate {
	height: 3rem;
	width: 9rem;
	font-size: 1.1rem;
	backdrop-filter: blur(3.875rem);
	background: transparent;
	color: white;
	border: 0.125rem solid rgba(255, 255, 255, .4);
	margin: 0.2rem;
	border-radius: 0.5rem;
}

.AverageTemp .startDate::placeholder, .AverageTemp .endDate::placeholder
	{
	color: white;
	text-align: center;
}

.avgCity {
	height: 3rem;
	width: 9rem;
	font-size: 1.2rem;
	border: 0.125rem solid rgba(255, 255, 255, .4);
	margin: 0.2rem;
	border-radius: 0.5rem;
}
.AverageTemp .average{
	height: 3rem;
	width: 9rem;
	font-size: 1.2rem;
	border: 0.125rem solid rgba(255, 255, 255, .4);
	margin: 0.2rem;
	border-radius: 0.5rem;
	cursor: pointer;
}

.averageResult{
	height: 3rem;
	width: 38rem;
	font-size: 1.2rem;
	border: 0.125rem solid rgba(255, 255, 255, .4);
	margin: 0.2rem;
	border-radius: 0.5rem;
	display: flex;
	flex-wrap: nowrap;
}

.saved-cities {
	margin: 1em;
	border-radius: 1em;
	justify-content: space-between;
	height: 100%;
	width: 51rem;
	padding: 2em;
	display: flex;
	flex-wrap: nowrap;
	gap: 0.1rem;
	backdrop-filter: blur(3.875rem);
}

.saved-cities .PinnedLocation1, .saved-cities .PinnedLocation2, .saved-cities .PinnedLocation3 {
	border: 0.125rem solid rgba(255, 255, 255, .4);
	border-radius: 1em;
	padding: 0.5em;
	width: 15em;
	transition: 0.3s;
	margin: 0.2em;
}

.saved-cities .PinnedLocation1:hover, .saved-cities .PinnedLocation2:hover , .saved-cities .PinnedLocation3:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.6);
}

.PinnedLocation1 .pincity1, .PinnedLocation2 .pincity2, .PinnedLocation3 .pincity3{
	font-size: 2rem;
	text-align: center;
	color: white;
}

.PinnedLocation1 .pintemp1, .PinnedLocation2 .pintemp2, .PinnedLocation3 .pintemp3 {
	position: relative;
	font-size: 2rem;
	line-height: 1;
	font-weight: 700;
	margin: 1.2rem;
	color: white;
}

.PinnedLocation1 .pintemp1 span, .PinnedLocation2 .pintemp2 span, .PinnedLocation3 .pintemp3 span {
	position: absolute;
	font-size: 0.8rem;
	margin-left: 0.25rem;
}

.PinnedLocation1 .description1, .PinnedLocation2 .description2, .PinnedLocation3 .description3 {
	font-size: 1.4rem;
	font-weight: 500;
	color: white;
}

.pin-box {
	position: absolute;
	right: 0.625rem;
	bottom: 0.12rem;
	margin: 0;
	font-size: 3.45rem;
	color: white;
	padding: 0;
	cursor: pointer;
}

.pin-box:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.6);
}
</style>

</head>
<body>
	<%
	if (session.getAttribute("uname") == null) {
		response.sendRedirect("LoginUser.jsp");
	}
	%>
	<div class="container">
		<div class="search-box">
			<i class='bx bxs-map'></i> <input type="text" name="city"
			id="cityInput"	placeholder="Enter city name" required>
			<button class="bx bx-search"></button>
		</div>
		<div class="coord-box">
			<i class='bx bxs-map'></i> <input type="number" id="latitude"
				placeholder="Enter Latitude">
		</div>
		<div class="coord-box">
			<i class='bx bxs-map'></i> <input type="number" id="longitude"
				placeholder="Enter Longitude">
			<button class="bx bx-search" id="search-coord"></button>
		</div>
		<p class="city-hide">city hide</p>

		<div class="weather-box">
			<div class="box">
				<div class="info-weather">
					<div class="weather">
						<img alt="" src="images/cloud.png">
						<p class="temperature">
							0<span>°C</span>
						</p>
						<p class="description">Broken Clouds</p>
					</div>
				</div>
			</div>
		</div>

		<div class="weather-details">
			<div class="humidity">
				<i class='bx bx-water'></i>
				<div class="text">
					<div class="info-humidity">
						<span>0%</span>
					</div>
					<p>Humidity</p>
				</div>
			</div>

			<div class="wind">
				<i class='bx bx-wind'></i>
				<div class="text">
					<div class="info-wind">
						<span>0Km/h</span>
					</div>
					<p>Wind Speed</p>
				</div>
			</div>
		</div>
		<div class="not-found">
			<div class="box">
				<img src="images/404.png">
				<p>Oops! Location not found!</p>
			</div>
		</div>
	</div>
	<div>
		<a href="LogHome.jsp" class="logout">LOGOUT</a>
	</div>
	<div class="cards">
		<div class="currentDate">
			<h1>Current Date is:</h1>
			<%
			Date date = new Date();
			out.println("<h2>" + date.toString() + "</h2>");
			%>
		</div>

		<div class="AverageTemp">
        <form id="customDateInput" onsubmit="event.preventDefault(); fetchAndCalculateAverage(startDate.value, endDate.value, avgCity.value);">
            <input type="text"class="startDate" id="startDate" placeholder="Enter starting date">
            <input type="text" class="endDate" id="endDate" placeholder="Enter ending date">
            <select class="avgCity" id="avgCity">
                <option value="Jaipur">Jaipur</option>
                <option value="Mumbai">Mumbai</option>
                <option value="Pune">Pune</option>
                <option value="Delhi">Delhi</option>
            </select>
            <button type="submit" class="average">Calculate</button>
        </form>
        <div id="averageResult" class="averageResult"></div>
    </div>
		
	<div class="saved-cities">
		<div class="PinnedLocation1" id="pinned-location1">
			<button class="remove-button" onclick="removeCity('pincity1')">
				<i class='bx bxs-minus-circle'></i>
			</button>
			<h2 class="pincity1" id="pincity1"></h2>
			<p class="pintemp1">0<span>°C</span></p>
			<p class="description1">Broken Clouds</p>
		</div>
		<div class="PinnedLocation2" id="pinned-location2">
			<button class="remove-button" onclick="removeCity('pincity2')">
				<i class='bx bxs-minus-circle'></i>
			</button>
			<h2 class="pincity2" id="pincity2"></h2>
			<p class="pintemp2">0<span>°C</span></p>
			<p class="description2">Broken Clouds</p>
		</div>
		<div class="PinnedLocation3" id="pinned-location3">
			<button class="remove-button" onclick="removeCity('pincity3')">
				<i class='bx bxs-minus-circle'></i>
			</button>
			<h2 class="pincity3" id="pincity3"></h2>
			<p class="pintemp3">0<span>°C</span></p>
			<p class="description3">Broken Clouds</p>
		</div>
	</div>
	<div class="pin-box" id="pinbutton">
		<i class='bx bx-pin'></i>
	</div>
	</div>
	<script src="script.js"></script>
</body>
</html>