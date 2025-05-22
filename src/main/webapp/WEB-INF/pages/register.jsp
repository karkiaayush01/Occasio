<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- Make sure JSTL core taglib is declared --%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>Register</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
		<!-- Set contextpath variable for reuse -->
		<c:set var="contextPath" value="${pageContext.request.contextPath}" />
		<link rel="stylesheet" href="${contextPath}/css/register.css?v=${System.currentTimeMillis()}" />
	
		<%-- Add some basic styling for error messages --%>
		<style>
			.error-message {
				color: red;
				font-size: 0.8em;
				margin-top: 2px;
				margin-bottom: 5px; /* Add some space below the error */
				display: block; /* Make span behave like a block for spacing */
			}
			.general-error { /* Style for the overall registration error */
			    color: red;
			    font-weight: bold;
			    text-align: center;
			    margin-bottom: 15px;
			}
		</style>
	</head>
	
	<body>
		<jsp:include page="popup.jsp"></jsp:include>
		<div id="particles-js"></div>
		<main class="main">
			<div class="register-popover">
	
				<div class="register-headers">
					<h2 class="register-text">Sign up</h2>
					<span style="font-size: 16px; padding: 2px; color: rgba(0, 0, 0, 0.75); font-family: 'Poppins-Regular'">Lets get you in!</span>
				</div>
	
				<div class="step-progress">
					<div class="step active" id="step-1">
						<div class="circle">1</div>
						<label class="basic-label">Basic Info</label>
					</div>
					<div class=line></div>
					<div class=step id="step-2">
						<div class="circle">2</div>
						<label class="setup-label"> Account Setup</label>
					</div>
				</div>
	
				<form class="register-form" name="register-form" action="${contextPath}/register" method="post" enctype="multipart/form-data">
	
	                <%-- Display General Registration Error (e.g., Email exists, DB error) --%>
	                <c:if test="${not empty registrationError}">
	                    <p class="general-error">${registrationError}</p>
	                </c:if>
	
					<%-- =========== REGISTER=========== --%>
					<div class="register-part-1">
						<div class="form-section">
							<label class="register-label">Full name</label>
							<%-- Use requestScope to explicitly get attributes set in servlet --%>
							<%-- Display the previously entered value if validation failed --%>
							<input type="text" name="fullName" class="form-input" value="${requestScope.fullName}">
							<%-- Display error message for fullName if it exists in the errors map --%>
							<c:if test="${not empty errors.fullName}">
								<span class="error-message">${errors.fullName}</span>
							</c:if>
						</div>
	
						<%-- Hidden role input --%>
						<input type="hidden" value="user" name="role">
	
						<div class="form-section">
							<label class="org-id-label">Organization ID</label>
							<input type="text" name="orgId" id="form-org" class="form-input" value="${requestScope.orgId}">
							<c:if test="${not empty errors.orgId}">
								<span class="error-message">${errors.orgId}</span>
							</c:if>
						</div>
	
						<div class="form-section">
							<label class="form-reg-email">Email</label>
							<input type="email" name="email" class="form-input" placeholder="example@gmail.com" value="${requestScope.email}">
							<c:if test="${not empty errors.email}">
								<span class="error-message">${errors.email}</span>
							</c:if>
						</div>
	
						<div class="form-section">
							<label class="form-reg-num">Phone number</label>
							<input type="text" name="phoneNumber" class="form-input" value="${requestScope.phoneNumber}">
							<c:if test="${not empty errors.phoneNumber}">
								<span class="error-message">${errors.phoneNumber}</span>
							</c:if>
						</div>
					</div> 
	
					<div class="register-part-2" style="display: none;"> <%-- Initially hidden --%>
						<div class= "profile-circle">
							<%-- Note: File inputs cannot be repopulated for security reasons --%>
							<input type="file" id="image" name="profilePicture" style="display: none" onChange="handlePictureChange(event)">
							<div class = "circle3">
								<img src = "" class = "register-profile-picture">
								<svg class = "camera-icon" width="44" height="40" viewBox="0 0 44 40" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M21.8643 11.8706C27.5423 11.8706 32.0847 16.4129 32.0847 22.0909C32.0847 27.7689 27.5423 32.3112 21.8643 32.3112C16.1864 32.3112 11.644 27.7689 11.644 22.0909C11.644 16.4129 16.1864 11.8706 21.8643 11.8706ZM21.8643 14.1418C19.7561 14.1418 17.7342 14.9793 16.2434 16.47C14.7527 17.9608 13.9152 19.9827 13.9152 22.0909C13.9152 24.1992 14.7527 26.221 16.2434 27.7118C17.7342 29.2026 19.7561 30.0401 21.8643 30.0401C23.9726 30.0401 25.9945 29.2026 27.4852 27.7118C28.976 26.221 29.8135 24.1992 29.8135 22.0909C29.8135 19.9827 28.976 17.9608 27.4852 16.47C25.9945 14.9793 23.9726 14.1418 21.8643 14.1418ZM7.10164 5.05702H11.644L16.1864 0.514648H27.5423L32.0847 5.05702H36.627C38.4341 5.05702 40.1672 5.77487 41.445 7.05266C42.7227 8.33045 43.4406 10.0635 43.4406 11.8706V32.3112C43.4406 34.1183 42.7227 35.8514 41.445 37.1292C40.1672 38.4069 38.4341 39.1248 36.627 39.1248H7.10164C5.29457 39.1248 3.56152 38.4069 2.28373 37.1292C1.00594 35.8514 0.288086 34.1183 0.288086 32.3112V11.8706C0.288086 10.0635 1.00594 8.33045 2.28373 7.05266C3.56152 5.77487 5.29457 5.05702 7.10164 5.05702ZM17.1176 2.78583L12.5752 7.3282H7.10164C5.89693 7.3282 4.74156 7.80677 3.8897 8.65863C3.03784 9.51049 2.55927 10.6659 2.55927 11.8706V32.3112C2.55927 33.5159 3.03784 34.6713 3.8897 35.5232C4.74156 36.375 5.89693 36.8536 7.10164 36.8536H36.627C37.8318 36.8536 38.9871 36.375 39.839 35.5232C40.6908 34.6713 41.1694 33.5159 41.1694 32.3112V11.8706C41.1694 10.6659 40.6908 9.51049 39.839 8.65863C38.9871 7.80677 37.8318 7.3282 36.627 7.3282H31.1535L26.6111 2.78583H17.1176Z" fill="black"/></svg>
								<button type="button" class = "remove-profile-picture" onclick="removeProfilePicture(event)">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="rgba(246, 94, 44, 1)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash2-icon lucide-trash-2"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
								</button>
							</div>
	
							<label class = "add-label" for="image">Add Profile Picture</label>
							<%-- Error for profile picture (if you add validation later) --%>
							<%--
							<c:if test="${not empty errors.profilePicture}">
								<span class="error-message">${errors.profilePicture}</span>
							</c:if>
							--%>
						</div>
	
						<div>
							<div class="form-section" style="margin-bottom: 4px;">
								<label class="form-label" style="padding: 8px 0px"> Create Password</label>
								<div style="position: relative; width: 100%">
									<%-- Password fields should not be repopulated for security --%>
									<input type="password" id="create-password-field" name="password" class="form-input password">
									<button class='password-eye' type='button' id="create-password-button" onclick="toggleViewPassword('create-password-field','create-password-button')">
										<svg  width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-eye-icon lucide-eye"><path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"/><circle cx="12" cy="12" r="3"/></svg>
									</button>
								</div>
								<%-- Display error for password --%>
								<c:if test="${not empty errors.password}">
									<span class="error-message">${errors.password}</span>
								</c:if>
							</div>
	
							<div class="form-section" style="margin-bottom: 32px;">
								<label class="form-label" style="padding: 8px 0px"> Confirm Password</label>
								<div style="position: relative; width: 100%">
									<input type="password" id="confirm-password-field" name="confirmPassword" class="form-input password">
									<button class='password-eye' type='button' id="confirm-password-button" onclick="toggleViewPassword('confirm-password-field', 'confirm-password-button')">
										<svg  width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-eye-icon lucide-eye"><path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"/><circle cx="12" cy="12" r="3"/></svg>
									</button>
								</div>
								<%-- Display error for confirmPassword --%>
								<c:if test="${not empty errors.confirmPassword}">
									<span class="error-message">${errors.confirmPassword}</span>
								</c:if>
							</div>
						</div>
					</div> <%-- End register- --%>
	
					<button type="button" class="register-continue" onclick="proceedRegistration()">
						Continue
					</button>
	
					<button type="submit" class="register-confirm" style="display: none;"> <%-- Initially hidden --%>
						Confirm
					</button>
	
					<p style="text-align: center;">Already have an account?
						<a href="${contextPath}/login" class="signin-text" style="color: rgba(37, 81, 227, 1); cursor: pointer; text-decoration: none;">Sign In</a>
					</p>
				</form>
			</div>
	
		</main>
	
	</body>
	<script>
	        function toggleViewPassword(elementId, iconId) {
	            passwordField = document.getElementById(elementId);
	            iconButton = document.getElementById(iconId);
	            // Check If Field Type Is Password
	            if (passwordField.type === "password") {
	                passwordField.type = "text";
	                iconButton.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-eye-off-icon lucide-eye-off"><path d="M10.733 5.076a10.744 10.744 0 0 1 11.205 6.575 1 1 0 0 1 0 .696 10.747 10.747 0 0 1-1.444 2.49"/><path d="M14.084 14.158a3 3 0 0 1-4.242-4.242"/><path d="M17.479 17.499a10.75 10.75 0 0 1-15.417-5.151 1 1 0 0 1 0-.696 10.75 10.75 0 0 1 4.446-5.143"/><path d="m2 2 20 20"/></svg>';
	            } else {
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