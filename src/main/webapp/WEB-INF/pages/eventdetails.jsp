<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Event Details</title>
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/css/eventdetails.css?v=${System.currentTimeMillis()}" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	</head>

	<body>
		<main>
			<header>
				<section class="event-nav">
					<div class="nav-buttonbar">
						<button class="back-button">
							<svg width="13" height="24" viewBox="0 0 13 24" fill="none"
								xmlns="http://www.w3.org/2000/svg">
								<path fill-rule="evenodd" clip-rule="evenodd"
									d="M3.4574 11.9999L12.8854 21.4279L11.0001 23.3132L0.629396 12.9425C0.379434 12.6925 0.239014 12.3534 0.239014 11.9999C0.239014 11.6463 0.379434 11.3072 0.629396 11.0572L11.0001 0.686523L12.8854 2.57186L3.4574 11.9999Z"
									fill="black" />
							</svg>
							<span>Back</span>
						</button>
					</div>
					<div class="nav-user-section">
						<div class="nav-user-profile-picture">
							<img src="">
						</div>
						<div class="nav-user-details">
							<h3 class="nav-user-details-name">Srijan Shrestha</h3>
							<p class="nav-user-details-email"
								style="font-size: 14px; color: rgba(0, 0, 0, 0.51); font-family: 'Poppins';">
								srijanshrestha999@gmail.com</p>
							<div class="nav-user-profile-actions">
								<span class="nav-user-details-view-prof-button"
									style="font-size: 13px; color: rgba(37, 81, 227, 1); font-family: 'Poppins'">View
									Profile</span>
								<button class="logout-button" onclick="toggleLogoutOverlay()">
									<svg width="17" height="16" viewBox="0 0 17 16" fill="none"xmlns="http://www.w3.org/2000/svg">
										<path d="M2.08963 16C1.62897 16 1.24463 15.846 0.936633 15.538C0.628633 15.23 0.474299 14.8453 0.473633 14.384V1.616C0.473633 1.15533 0.627966 0.771 0.936633 0.463C1.2453 0.155 1.62963 0.000666667 2.08963 0H8.49263V1H2.08963C1.93563 1 1.7943 1.064 1.66563 1.192C1.53697 1.32 1.47297 1.46133 1.47363 1.616V14.385C1.47363 14.5383 1.53763 14.6793 1.66563 14.808C1.79363 14.9367 1.93463 15.0007 2.08863 15H8.49263V16H2.08963ZM12.9356 11.539L12.2336 10.819L14.5526 8.5H5.66563V7.5H14.5526L12.2326 5.18L12.9346 4.462L16.4736 8L12.9356 11.539Z"fill="black" />
									</svg>
									<span class="logout-button-text"style="font-size: 13px; color: rgba(239, 51, 51, 1); font-family: 'Poppins'">Logout</span>
								</button>
							</div>
						</div>
					</div>
				</section>
			</header>

			<section class="event-interest">
				<div class="event-picture">
					<img src="${pageContext.request.contextPath}/images/event-default.png" class="events-cover" />
				</div>
				<div class="event-details-text">
					<div class="event-title-div">
						<h1 class="event-title">Aspire 2025</h1>
					</div>
					<div class="event-card-interested">
						<div class="interested-counts">
							<div class="interested-user-images">
								<img src="" class="interested-user-1">
								<img src="" class="interested-user-2">
								<img src="" class="interested-user-3">
							</div>
							<div class="total-interests">+20 others are interested</div>
						</div>
						<div class="confirm">
							<button class="show-interest-button">Confirm Interest</button>
						</div>
					</div>
				</div>
			</section>
				<section>
					<div>
					</div>
				</section>
		</main>
		<div class="logout-overlay">
				<div class="logout-container">
					<svg width="24" height="24" viewBox="0 0 24 24" fill="none" class="logout-warning-icon" xmlns="http://www.w3.org/2000/svg">
						<path d="M12 17C12.2833 17 12.521 16.904 12.713 16.712C12.905 16.52 13.0007 16.2827 13 16C12.9993 15.7173 12.9033 15.48 12.712 15.288C12.5207 15.096 12.2833 15 12 15C11.7167 15 11.4793 15.096 11.288 15.288C11.0967 15.48 11.0007 15.7173 11 16C10.9993 16.2827 11.0953 16.5203 11.288 16.713C11.4807 16.9057 11.718 17.0013 12 17ZM11 13H13V7H11V13ZM12 22C10.6167 22 9.31667 21.7373 8.1 21.212C6.88334 20.6867 5.825 19.9743 4.925 19.075C4.025 18.1757 3.31267 17.1173 2.788 15.9C2.26333 14.6827 2.00067 13.3827 2 12C1.99933 10.6173 2.262 9.31733 2.788 8.1C3.314 6.88267 4.02633 5.82433 4.925 4.925C5.82367 4.02567 6.882 3.31333 8.1 2.788C9.318 2.26267 10.618 2 12 2C13.382 2 14.682 2.26267 15.9 2.788C17.118 3.31333 18.1763 4.02567 19.075 4.925C19.9737 5.82433 20.6863 6.88267 21.213 8.1C21.7397 9.31733 22.002 10.6173 22 12C21.998 13.3827 21.7353 14.6827 21.212 15.9C20.6887 17.1173 19.9763 18.1757 19.075 19.075C18.1737 19.9743 17.1153 20.687 15.9 21.213C14.6847 21.739 13.3847 22.0013 12 22ZM12 20C14.2333 20 16.125 19.225 17.675 17.675C19.225 16.125 20 14.2333 20 12C20 9.76667 19.225 7.875 17.675 6.325C16.125 4.775 14.2333 4 12 4C9.76667 4 7.875 4.775 6.325 6.325C4.775 7.875 4 9.76667 4 12C4 14.2333 4.775 16.125 6.325 17.675C7.875 19.225 9.76667 20 12 20Z" fill="#EF3333"/>
					</svg>
					
					<div class="logout-items">
						<img class="logout-image" src="${pageContext.request.contextPath}/images/logout-image.png">
						
						<div class="logout-confirm">
							<p class="logout-confirm-text">Are you sure you want to logout?</p>
							<div class="logout-actions">
								<button class="logout-action-cancel" onclick="toggleLogoutOverlay()">Cancel</button>
								<button class="logout-action-confirm">Confirm</button>
							</div>
						</div>
					</div>
				</div>
			</div>
	</body>
	<script>
		function toggleLogoutOverlay(){
			const logoutElement = document.querySelector(".logout-overlay");
			if(logoutElement.style.visibility == "visible"){
				logoutElement.style.visibility = "hidden";
			} else {
				logoutElement.style.visibility = "visible";
			}
		}
	</script>

	</html>