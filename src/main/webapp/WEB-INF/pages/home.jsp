<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Occasio</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css?v=${System.currentTimeMillis()}" />
	</head>

	<body>
		<main class="main">
			<section class="home-nav">
				<h2 class="nav-title">Occasio</h2>
				<div class="nav-buttonbar">
					<button class="nav-button">
						Home
					</button>
					<button class="nav-button">
						Home
					</button>
					<button class="nav-button">
						Home
					</button>
					<button class="nav-button">
						About Us
					</button>
				</div>
				<div class="nav-user-section">
					<div class="nav-user-profile-picture">
						<img src="">
					</div>
					<div class="nav-user-details">
						<h3 class="nav-user-details-name" style="font-size: 20px">Srijan Shrestha</h3>
						<p class="nav-user-details-email" style="font-size: 14px; color: rgba(0, 0, 0, 0.51); font-family: 'Poppins';">srijanshrestha999@gmail.com</p>
						<span class="nav-user-details-view-prof-button" style="font-size: 13px; color: rgba(37, 81, 227, 1); font-family: 'Poppins'">View Profile</span>
					</div>
				</div>
			</section>
			<form class="event-search-bar-form">
				<div class="event-search-bar">
					<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-search-icon lucide-search"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
					<input class="search-bar-input" type="text" placeholder="Search for college events"/>
				</div>	
			</form>
			
			<section class="user-events">
				<h3 class="event-section-title">My Events</h3>
				<div class="events-actions">
					<button class="events-actions-add">
						<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-plus-icon lucide-plus"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
						<span class="events-actions-add-text">Add New Event</span>
					</button>
				</div>
				
				<div class="events-card-container">
					<div class="user-events-card">
						<img src="${pageContext.request.contextPath}/images/event-default.png" class="user-events-cover"/>
						<div class="user-events-card-details">
							<div class="user-events-card-details-title">
								<h4 style="font-size: 16px;">Aspire 2025</h4>
								<span class="view-event-details-link">View Details</span>
							</div>
							<div class="user-event-card-details-info">
								<p class="user-event-card-details-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-clock-icon lucide-clock"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
									<span>9:00 AM - 2:00 PM</span>
								</p>
								<p class="user-event-card-details-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
									<span>Kumari Hall</span>
								</p>
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
								<div class="">
									<button class="edit-event-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-square-pen-icon lucide-square-pen"><path d="M12 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.375 2.625a1 1 0 0 1 3 3l-9.013 9.014a2 2 0 0 1-.853.505l-2.873.84a.5.5 0 0 1-.62-.62l.84-2.873a2 2 0 0 1 .506-.852z"/></svg>
										<span>Edit Event</span>
									</button>
								</div>
							</div>
						</div>
						<!-- Add user event card here -->
					</div>
					
					<div class="user-events-card">
						<img src="${pageContext.request.contextPath}/images/event-default.png" class="user-events-cover"/>
						<div class="user-events-card-details">
							<div class="user-events-card-details-title">
								<h4 style="font-size: 16px;">Aspire 2025</h4>
								<span class="view-event-details-link">View Details</span>
							</div>
							<div class="user-event-card-details-info">
								<p class="user-event-card-details-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-clock-icon lucide-clock"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
									<span>9:00 AM - 2:00 PM</span>
								</p>
								<p class="user-event-card-details-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
									<span>Kumari Hall</span>
								</p>
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
								<div class="">
									<button class="edit-event-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-square-pen-icon lucide-square-pen"><path d="M12 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.375 2.625a1 1 0 0 1 3 3l-9.013 9.014a2 2 0 0 1-.853.505l-2.873.84a.5.5 0 0 1-.62-.62l.84-2.873a2 2 0 0 1 .506-.852z"/></svg>
										<span>Edit Event</span>
									</button>
								</div>
							</div>
						</div>
						<!-- Add user event card here -->
					</div>
					
					<div class="user-events-card">
						<img src="${pageContext.request.contextPath}/images/event-default.png" class="user-events-cover"/>
						<div class="user-events-card-details">
							<div class="user-events-card-details-title">
								<h4 style="font-size: 16px;">Aspire 2025</h4>
								<span class="view-event-details-link">View Details</span>
							</div>
							<div class="user-event-card-details-info">
								<p class="user-event-card-details-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-clock-icon lucide-clock"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
									<span>9:00 AM - 2:00 PM</span>
								</p>
								<p class="user-event-card-details-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
									<span>Kumari Hall</span>
								</p>
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
								<div class="">
									<button class="edit-event-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-square-pen-icon lucide-square-pen"><path d="M12 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.375 2.625a1 1 0 0 1 3 3l-9.013 9.014a2 2 0 0 1-.853.505l-2.873.84a.5.5 0 0 1-.62-.62l.84-2.873a2 2 0 0 1 .506-.852z"/></svg>
										<span>Edit Event</span>
									</button>
								</div>
							</div>
						</div>
						<!-- Add user event card here -->
					</div>
				</div>
			</section>
			
			<section class="ongoing-events">
				<h3 class="event-section-title">Ongoing Events</h3>
				
				<div class="events-card-container">
					<div class = "ongoing-events-card">
						<img src="${pageContext.request.contextPath}/images/event-default.png" class="ongoing-events-cover"/>
						<div class="ongoing-events-card-details">
							<div class="ongoing-events-card-details-title">
								<h4 class="event-card-title" style="font-size: 16px">Aspire 2025</h4>
								<span class="view-event-details-link">View Details</span>
							</div>
							
							<div class="ongoing-events-card-info">
								<div class="ongoing-events-card-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-clock-icon lucide-clock"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
									<span class="event-card-time-label">9:00 AM - 2:00 PM</span>
								</div>
								<div class="ongoing-events-card-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
									<span class="event-card-location-label">Kumari Hall</span>
								</div>
							</div>
							
							<div class="event-card-interested">
								<div class="interested-counts" >
									<div class = "interested-user-images">
										<img src="" class="interested-user-1">
										<img src="" class="interested-user-2">
										<img src="" class="interested-user-3">
									</div>
									<div class="total-interests">+20 others are interested</div>
								</div>
								<div class="">
									<button class="show-interest-button">Confirm Interest</button>
								</div>
							</div>
						</div>
					</div>
					
					<div class = "ongoing-events-card">
						<img src="${pageContext.request.contextPath}/images/event-default.png" class="ongoing-events-cover"/>
						<div class="ongoing-events-card-details">
							<div class="ongoing-events-card-details-title">
								<h4 class="event-card-title" style="font-size: 16px">Aspire 2025</h4>
								<span class="view-event-details-link">View Details</span>
							</div>
							
							<div class="ongoing-events-card-info">
								<div class="ongoing-events-card-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-clock-icon lucide-clock"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
									<span class="event-card-time-label">9:00 AM - 2:00 PM</span>
								</div>
								<div class="ongoing-events-card-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
									<span class="event-card-location-label">Kumari Hall</span>
								</div>
							</div>
							
							<div class="event-card-interested">
								<div class="interested-counts" >
									<div class = "interested-user-images">
										<img src="" class="interested-user-1">
										<img src="" class="interested-user-2">
										<img src="" class="interested-user-3">
									</div>
									<div class="total-interests">+20 others are interested</div>
								</div>
								<div class="">
									<button class="interested-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-check-icon lucide-check"><path d="M20 6 9 17l-5-5"/></svg>
										Interested
									</button>
								</div>
							</div>
						</div>
					</div>
					
					<div class = "ongoing-events-card">
						<img src="${pageContext.request.contextPath}/images/event-default.png" class="ongoing-events-cover"/>
						<div class="ongoing-events-card-details">
							<div class="ongoing-events-card-details-title">
								<h4 class="event-card-title" style="font-size: 16px">Aspire 2025</h4>
								<span class="view-event-details-link">View Details</span>
							</div>
							
							<div class="ongoing-events-card-info">
								<div class="ongoing-events-card-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-clock-icon lucide-clock"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
									<span class="event-card-time-label">9:00 AM - 2:00 PM</span>
								</div>
								<div class="ongoing-events-card-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
									<span class="event-card-location-label">Kumari Hall</span>
								</div>
							</div>
							
							<div class="event-card-interested">
								<div class="interested-counts" >
									<div class = "interested-user-images">
										<img src="" class="interested-user-1">
										<img src="" class="interested-user-2">
										<img src="" class="interested-user-3">
									</div>
									<div class="total-interests">+20 others are interested</div>
								</div>
								<div class="">
									<button class="show-interest-button">Confirm Interest</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			
			<section class="upcoming-events">
				<h3 class="event-section-title">Upcoming Events</h3>
				
				<div class="events-card-container">
					<div class="upcoming-events-card">
						<img class="upcoming-events-card-cover" src="${pageContext.request.contextPath}/images/event-default.png">
						<div class = "upcoming-events-card-details">
							<h3 class="upcoming-events-card-details-title">Holi 2025</h3>
							<div class="upcoming-events-card-info">
								<div class="upcoming-events-card-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-clock-icon lucide-clock"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
									<span class="event-card-time-label">9:00 AM - 2:00 PM</span>
								</div>
								<div class="upcoming-events-card-info-child">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
									<span class="event-card-location-label">Kumari Hall</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</main>
	</body>
</html>