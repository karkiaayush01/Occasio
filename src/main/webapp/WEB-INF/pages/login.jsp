<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Occasio</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css?v=${System.currentTimeMillis()}"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	</head>
	<body>
		<main class="main">
			<div class="login-popover">
				<h1 class="login-title">Occasio</h1>
				
				<div class = "sign-in-headers">
					<h2 class="login-sign-in-text">Sign in</h2>
					<span style="font-size: 16px; padding: 2px">Lets get you in!</span>
				</div>
				
				<form class="login-form" name="login-form">
					<div class="form-section">
						<label class="form-label">Email</label>
						<input type="text" class="form-input" placeholder="example.gmail.com" name="email">
					</div>
					<div class="form-section">
						<label class="form-label">Password</label>
						<input type="password" class="form-input">
					</div>
					<span style="align-self: flex-end; color: #2551E3; cursor: pointer; margin-bottom:32px;">Forgot Password ?</span>
					<button type="submit" style="height: 48px; font-size: 20px; color: white; background: #F65E2C; border-radius: 6px; border: none; margin-bottom: 32px">
						Sign In
					</button>
					<span style="text-align: center">New to Occasio? <span style="color: rgba(37, 81, 227, 1); cursor: pointer">Sign Up</span></span>
				</form>
			</div>
		</main>
	</body>
</html>