<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Register</title>
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/css/register.css?v=${System.currentTimeMillis()}" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	</head>

	<body>
		<main class="main">
			<div class="register-popover">
				<h1 class="register-title">Occasio</h1>

				<div class="register-headers">
					<h2 class="register-text">Sign up</h2>
					<span style="font-size: 16px; padding: 2px">Lets get you in!</span>
				</div>
				<div class="step-progress">
					<div class="step active">
						<div class="circle" id="circle1">1</div>
						<label class="basic-label">Basic Info</label>
					</div>
					<div class=line></div>
					<div class=step>
						<div class="circle">2</div>
						<label class="setup-label"> Account Setup</label>
					</div>
				</div>
				<form class="register-form" name="register-form">
					<div>
						<div class="form-section">
							<label class="register-label">Full name</label>
							<input type="text" name=" name-field" class="form-input">
						</div>
						<div class="form-section">
							<label class="org-id-label">Organization ID</label>
							<input type="number" id="form-org" class="form-input">
						</div>
						<div class="form-section">
							<label class="form-reg-email">Email</label>
							<input type="email" class="form-input" placeholder="example@gmail.com">
						</div>
						<div class="form-section">
							<label class="form-reg-num">Phone number</label>
							<input type="number" class="form-input">
						</div>
					</div>
					<div>
						<div class= "profile-circle">
							<div class = "circle3"> <svg width="44" height="40" viewBox="0 0 44 40" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M21.8643 11.8706C27.5423 11.8706 32.0847 16.4129 32.0847 22.0909C32.0847 27.7689 27.5423 32.3112 21.8643 32.3112C16.1864 32.3112 11.644 27.7689 11.644 22.0909C11.644 16.4129 16.1864 11.8706 21.8643 11.8706ZM21.8643 14.1418C19.7561 14.1418 17.7342 14.9793 16.2434 16.47C14.7527 17.9608 13.9152 19.9827 13.9152 22.0909C13.9152 24.1992 14.7527 26.221 16.2434 27.7118C17.7342 29.2026 19.7561 30.0401 21.8643 30.0401C23.9726 30.0401 25.9945 29.2026 27.4852 27.7118C28.976 26.221 29.8135 24.1992 29.8135 22.0909C29.8135 19.9827 28.976 17.9608 27.4852 16.47C25.9945 14.9793 23.9726 14.1418 21.8643 14.1418ZM7.10164 5.05702H11.644L16.1864 0.514648H27.5423L32.0847 5.05702H36.627C38.4341 5.05702 40.1672 5.77487 41.445 7.05266C42.7227 8.33045 43.4406 10.0635 43.4406 11.8706V32.3112C43.4406 34.1183 42.7227 35.8514 41.445 37.1292C40.1672 38.4069 38.4341 39.1248 36.627 39.1248H7.10164C5.29457 39.1248 3.56152 38.4069 2.28373 37.1292C1.00594 35.8514 0.288086 34.1183 0.288086 32.3112V11.8706C0.288086 10.0635 1.00594 8.33045 2.28373 7.05266C3.56152 5.77487 5.29457 5.05702 7.10164 5.05702ZM17.1176 2.78583L12.5752 7.3282H7.10164C5.89693 7.3282 4.74156 7.80677 3.8897 8.65863C3.03784 9.51049 2.55927 10.6659 2.55927 11.8706V32.3112C2.55927 33.5159 3.03784 34.6713 3.8897 35.5232C4.74156 36.375 5.89693 36.8536 7.10164 36.8536H36.627C37.8318 36.8536 38.9871 36.375 39.839 35.5232C40.6908 34.6713 41.1694 33.5159 41.1694 32.3112V11.8706C41.1694 10.6659 40.6908 9.51049 39.839 8.65863C38.9871 7.80677 37.8318 7.3282 36.627 7.3282H31.1535L26.6111 2.78583H17.1176Z" fill="black"/></svg>
							</div>
								<label class = "add-label">Add Profile Picture</label>	
						</div>
						<div>
						<div class="form-section">
							<label class="form-label"> Create Password</label>
						<div style="position: relative; width: 100%">
							<input type="password" id="register-password-field" class="form-input password">
							<button class='password-eye' type='button' id="show-password-button" onclick="toggleViewPassword()">
								<svg  width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-eye-icon lucide-eye"><path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"/><circle cx="12" cy="12" r="3"/></svg>
							</button>
						</div>
						
						
						<div class="form-section">
								<label class="form-label"> Confirm Password</label>
						<div style="position: relative; width: 100%">
							<input type="password" id="register-password-field" class="form-input password">
							<button class='password-eye' type='button' id="show-password-button" onclick="toggleViewPassword()">
								<svg  width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-eye-icon lucide-eye"><path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"/><circle cx="12" cy="12" r="3"/></svg>
							</button>
						</div>
						</div>
					</div>
					</div>
					<button type="submit"
						style="height: 48px; font-size: 20px; color: white; background: #F65E2C; border-radius: 6px; border: none; margin-bottom: 32px; cursor:pointer; width:100%; ">
						Continue
					</button>
					<p style="text-align: center">Already a user? <span
							style="color: rgba(37, 81, 227, 1); cursor: pointer">Sign in</span></p>
				</form>
			</div>

		</main>

	</body>
	<script>
		function toggleViewPassword(){
			passwordField = document.getElementById('register-password-field');
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