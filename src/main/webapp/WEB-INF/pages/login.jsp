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
						<div style="position: relative; width: 100%">
							<input type="password" id="login-password-field" class="form-input password">
							<button class='password-eye' type='button' id="show-password-button" onclick="toggleViewPassword()">
								<svg  width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-eye-icon lucide-eye"><path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"/><circle cx="12" cy="12" r="3"/></svg>
							</button>
						</div>
					</div>
					<span style="align-self: flex-end; color: #2551E3; cursor: pointer; margin-bottom:32px;">Forgot Password ?</span>
					<button type="submit" style="height: 48px; font-size: 20px; color: white; background: #F65E2C; border-radius: 6px; border: none; margin-bottom: 32px">
						Sign In
					</button>
					<span style="text-align: center">New to Occasio?
						<a href="${pageContext.request.contextPath}/register" class="signup-text" style="color: rgba(37, 81, 227, 1); cursor: pointer; text-decoration: none;">Sign Up</a>
					</span>
				</form>
			</div>
		</main>
	</body>
	
	<script>
		function toggleViewPassword(){
			passwordField = document.getElementById('login-password-field');
			iconButton = document.getElementById('show-password-button');
			if(passwordField.type == "password"){
				passwordField.type = "text";
				iconButton.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-eye-off-icon lucide-eye-off"><path d="M10.733 5.076a10.744 10.744 0 0 1 11.205 6.575 1 1 0 0 1 0 .696 10.747 10.747 0 0 1-1.444 2.49"/><path d="M14.084 14.158a3 3 0 0 1-4.242-4.242"/><path d="M17.479 17.499a10.75 10.75 0 0 1-15.417-5.151 1 1 0 0 1 0-.696 10.75 10.75 0 0 1 4.446-5.143"/><path d="m2 2 20 20"/></svg>';
			}
			else{
				passwordField.type = "password";
				iconButton.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-eye-icon lucide-eye"><path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"/><circle cx="12" cy="12" r="3"/></svg>';
			}
		}
	</script>
</html>