<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Weather Application</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="icon" href="images/favicon.ico">
<style type="text/css">
*{
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Poppins",sans-sarif;
}
body{
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background: url('images/image1.webp') no-repeat center center;
	background-position: center;
	background-size: cover;
}
.container{
	width: 35.25rem;
	background: transparent;
	border: 0.125rem solid rgba(255, 255, 255, .2);
	backdrop-filter: blur(1.25rem);
	box-shadow: 0 0 0.625rem rgba(0, 0, 0, .4);
	color: white;
	border-radius: 0.625rem;
	padding: 3.875rem 3.5rem;
}

.container h1{
	color: white;
	font-size: 4.25rem;
	text-align: center;
}

.login a{
	color: white;
	font-size: 1.25rem;
	text-align: center;
	display: block;
	margin-top: 3.25rem;
	border: 0.125rem solid rgba(255, 255, 255, .4);
	border-radius: 1em;
}
.login a:hover{
	color: rgb(240,240,240);
	box-shadow: 0 8px 16px 0 rgba(0,0,0,0.6);
}
</style>
</head>
<body>
<%
session.removeAttribute("uname");
session.invalidate();
%>
<div class="container">
	<h1>Welcome User!</h1>
<div class="login">
	<a href=LoginUser.jsp>LOGIN HERE</a>
</div>
</div>
</body>
</html>