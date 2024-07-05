<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width , intital-scale=1.0">
	<title>Weather Application</title>
	<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
	<link rel="icon" href="images/favicon.ico">
	
<style type="text/css">
	*{
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Poppins",cursive;
	}
	
	body{
		display: flex;
		justify-content: center;
		align-items: center;
		min-height: 100vh;
		background : url("images/image2.webp") no-repeat;
		background-position: center;
		background-size: cover;
	}
	.wrapper{
		width: 26.25rem;
		background: transparent;
		border: 1.125rem solid rgba(255, 255, 255, .1);
		box-shadow: 0 0 2.625rem rgba(0, 0, 0, .2);
		color: white;
		border-radius: 0.625rem;
		padding: 1.875rem 2.5rem;
	}
	.wrapper h1{
		font-size: 2.25rem;
		text-align: center;
	}
	.wrapper .input-box{
		position: relative;
		width: 100%;
		height: 4rem;
		margin: 2rem 0;
		background: transparent;
	}
	.input-box input{
		width: 100%;
		height: 100%;
		background: transparent;
		border:none;
		outline: none;
		border: 0.125rem solid rgba(255, 255, 255, .2);
		border-radius: 2.5rem;
		font-size: 1rem;
		color: white;
		padding: 1.25rem 2.5rem 1.25rem 1.25rem;
	}
	.input-box input::placeholder{
		color: rgb(210, 210, 210);
	}
	.input-box i{
		position: absolute;
		right: 1.25rem;
		top: 50%;
		transform: translateY(-50%);
		font-size: 1.25rem;
		color: white;
		cursor: pointer;
	}
	.wrapper .remember-forgot{
		display: flex;
		justify-content: space-between;
		font-size: 1rem;
		margin: -0.938rem 0 0.938rem;
	}
	.remember-forgot label input{
		accent-color: white;
		margin-right: 0.188rem;
	}
	.remember-forgot a{
		color: white;
		text-decoration: none;
	}
	.remember-forgot a:hover {
		text-decoration: underline;
	}
	.wrapper .button{
		width: 100%;
		height: 2.813rem;
		background: white;
		border: none;
		outline: none;
		border-radius: 2.5rem;
		box-shadow: 0 0 0.625rem rgba(0, 0, 0, -1);
		cursor: pointer;
		font-size: 0.8rem;
		color: #409afd;
		font-weight: 600;
	}
	.wrapper .button:hover{
		background-color:#ecebed;
	}
</style>

</head>

<body>
	<div class="wrapper">
		<form action="LoginServlet" method="Post">
			<h1>Login</h1>
			<div class="input-box">
				<input type="email" name="User_name" placeholder="User_name" required>
				<i class='bx bxs-user'></i>
			</div>
			<div class="input-box">
				<input type="password" name="Password" placeholder="Password" required>
				<i class='bx bxs-lock' ></i>
			</div>
			<button type="submit" class="button">LOGIN</button>
		</form>
	</div>
</body>
</html>