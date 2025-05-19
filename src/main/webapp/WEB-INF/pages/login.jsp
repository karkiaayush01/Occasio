<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- Add JSTL taglib --%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Occasio - Login</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css?v=${System.currentTimeMillis()}"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<%-- Add some basic styling for error messages --%>
        <style>
            .error-message {
                color: red;
                font-size: 0.9em;
                text-align: center;
                margin-bottom: 15px;
                display: block;
            }
        </style>
	</head>
	<body>
	 	<div id="particles-js"></div>
	 	
		<main class="main">
			
			<div class="login-popover">
				<h1 class="login-title">Occasio</h1>

				<div class = "sign-in-headers">
					<h2 class="login-sign-in-text">Sign in</h2>
					<span style="font-size: 16px; padding: 2px">Lets get you in!</span>
				</div>

                <%-- Form Tag Changes: method="post" and action --%>
				<form class="login-form" name="login-form" method="post" action="${pageContext.request.contextPath}/login">
				
					<input type="hidden" name="action" value="login" />
                    <%-- Display Login Error Message --%>
                    <c:if test="${not empty loginError}">
                        <span class="error-message">${loginError}</span>
                    </c:if>

					<div class="form-section">
						<label class="form-label">Email</label>
						<%-- Add value attribute to repopulate email on error --%>
						<input type="text" class="form-input" placeholder="example@gmail.com" name="email" value="${param.email}">
					</div>
					<div class="form-section">
						<label class="form-label">Password</label>
						<div style="position: relative; width: 100%">
                            <%-- Add name="password" attribute --%>
							<input type="password" id="login-password-field" class="form-input password" name="password">
							<button class='password-eye' type='button' id="show-password-button" onclick="toggleViewPassword()">
								<svg  width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-eye-icon lucide-eye"><path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"/><circle cx="12" cy="12" r="3"/></svg>
							</button>
						</div>
					</div>
					<span style="align-self: flex-end; color: #2551E3; cursor: pointer; margin-bottom:20px;">Forgot Password ?</span>
					<button type="submit" style="height: 48px; font-size: 20px; color: white; background: #F65E2C; border-radius: 6px; border: none; margin-bottom: 20px">
						Sign In
					</button>
					<span style="text-align: center;">New to Occasio?
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
	
	<script src="http://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script> 
	<script src="http://threejs.org/examples/js/libs/stats.min.js"></script>
	
	<script>
		particlesJS("particles-js", 
			{
			  "particles": {
			    "number": {
			      "value":115,
			      "density": {
			        "enable":true,"value_area":639.7441023590567
			      }
			    },
			    "color": {
			      "value":"#ffffff"
			    },
			    "shape":{
			      "type":"circle",
			      "stroke": {
			        "width":0,"color":"#000000"
			      },
			      "polygon": {
			        "nb_sides":5
			      },
			      "image": {
			        "src":"img/github.svg","width":100,"height":100
			      }
			    },
			    "opacity": {
			      "value":0.5,
			      "random":false,
			      "anim": {
			        "enable":false,"speed":1,"opacity_min":0.1,"sync":false
			      }
			    },
			    "size":{
			      "value":3,
			      "random":true,
			      "anim":{
			        "enable":false,
			        "speed":40,
			        "size_min":0.1,
			        "sync":false
			      }
			    },
			    "line_linked":{
			      "enable":true,
			      "distance":255.89764094362266,
			      "color":"#ffffff",
			      "opacity":0.2958816473410637,
			      "width":1
			    },
			    "move":{
			      "enable":true,
			      "speed":2,
			      "direction":"none",
			      "random":true,
			      "straight":false,
			      "out_mode":"out",
			      "bounce":false,
			      "attract":{
			        "enable":true,
			        "rotateX":1599.3602558976415,
			        "rotateY":2798.880447820873
			      }
			    }
			  },
			  "interactivity":{
			    "detect_on":"canvas",
			    "events":{
			      "onhover":{
			        "enable":true,"mode":"repulse"
			      },
			      "onclick":{
			        "enable":true,
			        "mode":"push"
			      },
			      "resize":true
			    },
			    "modes":{
			      "grab":{
			        "distance":400,
			        "line_linked":{
			          "opacity":1
			        }
			      },
			      "bubble":{
			        "distance":400,
			        "size":40,
			        "duration":2,
			        "opacity":8,
			        "speed":3
			      },
			      "repulse":{
			        "distance":200,
			        "duration":0.4
			      },
			      "push":{
			        "particles_nb":4
			      },
			      "remove":{
			        "particles_nb":2
			      }
			    }
			  },
			  "retina_detect":true
			}
		)
		var count_particles, stats, update; 
		stats = new Stats; 
		stats.setMode(0); 
		stats.domElement.style.position = 'absolute'; 
		stats.domElement.style.left = '0px'; 
		stats.domElement.style.top = '0px'; 
		document.body.appendChild(stats.domElement); 
		count_particles = document.querySelector('.js-count-particles'); 
		update = function() { 
			stats.begin(); 
			stats.end(); 
			if (window.pJSDom[0].pJS.particles && window.pJSDom[0].pJS.particles.array) { 
				count_particles.innerText = window.pJSDom[0].pJS.particles.array.length; 
			} 
			requestAnimationFrame(update); 
		}; 
		requestAnimationFrame(update);
	</script>
</html>