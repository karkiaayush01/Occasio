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
					<button type="submit"
						style="height: 48px; font-size: 20px; color: white; background: #F65E2C; border-radius: 6px; border: none; margin-bottom: 32px; cursor:pointer;">
						Continue
					</button>
					<span style="text-align: center">Already a user? <span
							style="color: rgba(37, 81, 227, 1); cursor: pointer">Sign in</span></span>
				</form>
			</div>

		</main>

	</body>

	</html>