<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Occasio</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<!-- Set contextpath variable for reuse -->
		<c:set var="contextPath" value="${pageContext.request.contextPath}" />
		<link rel="stylesheet" href="${contextPath}/css/home.css?v=${System.currentTimeMillis()}" />
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
						<img class="nav-user-profile-picture-img" src="${contextPath}/${userProfileImgUrl}">
					</div>
					<div class="nav-user-details">
						<h3 class="nav-user-details-name">
							<c:if test="${not empty fullName}">
		                        ${fullName}
		                    </c:if>
						</h3>
						<p class="nav-user-details-email" style="font-size: 14px; color: rgba(0, 0, 0, 0.51); font-family: 'Poppins';">
							<c:if test="${not empty userEmail}">
		                        ${userEmail}
		                    </c:if>
						</p>
						<div class = "nav-user-profile-actions">
							<span class="nav-user-details-view-prof-button" style="font-size: 13px; color: rgba(37, 81, 227, 1); font-family: 'Poppins'" onclick="toggleUpdateProfileOverlay()">View Profile</span>
							<button class="logout-button" onclick="toggleLogoutOverlay()">
								<svg width="17" height="16" viewBox="0 0 17 16" fill="none" xmlns="http://www.w3.org/2000/svg">
									<path d="M2.08963 16C1.62897 16 1.24463 15.846 0.936633 15.538C0.628633 15.23 0.474299 14.8453 0.473633 14.384V1.616C0.473633 1.15533 0.627966 0.771 0.936633 0.463C1.2453 0.155 1.62963 0.000666667 2.08963 0H8.49263V1H2.08963C1.93563 1 1.7943 1.064 1.66563 1.192C1.53697 1.32 1.47297 1.46133 1.47363 1.616V14.385C1.47363 14.5383 1.53763 14.6793 1.66563 14.808C1.79363 14.9367 1.93463 15.0007 2.08863 15H8.49263V16H2.08963ZM12.9356 11.539L12.2336 10.819L14.5526 8.5H5.66563V7.5H14.5526L12.2326 5.18L12.9346 4.462L16.4736 8L12.9356 11.539Z" fill="black"/>
								</svg>
								<span class="logout-button-text" style="font-size: 13px; color: rgba(239, 51, 51, 1); font-family: 'Poppins'">Log out</span>
							</button>
						</div>
					</div>
				</div>
				<div class = "mobile-nav">
					<button class="mobile-nav-button" onclick="toggleMobileMenu()">
						<svg width="36" height="24" viewBox="0 0 36 24" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M0 24V20H36V24H0ZM0 14V10H36V14H0ZM0 4V0H36V4H0Z" fill="black"/>
						</svg>
					</button>
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
					<button class="events-actions-add" onclick="toggleAddEventsForm()">
						<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-plus-icon lucide-plus"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
						<span class="events-actions-add-text">Add New Event</span>
					</button>
				</div>
				
				<div class="events-card-container">
					<c:forEach var="event" items="${userEvents}">
						<div class="user-events-card">
							<img src="${contextPath}/${event.imagePath}" class="user-events-cover"/>
							<div class="user-events-card-details">
								<div class="user-events-card-details-title">
									<h4 class="user-events-card-details-title-name" style="font-size: 16px;">${event.name}</h4>
									<span class="view-event-details-link">View Details</span>
								</div>
								<div class="user-event-card-details-info">
									<p class="user-event-card-details-info-child">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-clock-icon lucide-clock"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
										<span>${event.startDate} - ${event.endDate}</span>
									</p>
									<p class="user-event-card-details-info-child">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
										<span style="max-width: 180px; overflow: hidden; text-overflow: ellipsis;">${event.location}</span>
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
										<button class="edit-event-button" onclick="toggleEditEventsForm()">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-square-pen-icon lucide-square-pen"><path d="M12 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.375 2.625a1 1 0 0 1 3 3l-9.013 9.014a2 2 0 0 1-.853.505l-2.873.84a.5.5 0 0 1-.62-.62l.84-2.873a2 2 0 0 1 .506-.852z"/></svg>
											<span>Edit Event</span>
										</button>
									</div>
								</div>
							</div>
							<!-- Add user event card here -->
						</div>
					</c:forEach>
					
					
				</div>
			</section>
			
			<section class="ongoing-events">
				<h3 class="event-section-title">Ongoing Events</h3>
				
				<div class="events-card-container">
					<div class = "ongoing-events-card">
						<img src="${contextPath}/resources/images/event-default.png" class="ongoing-events-cover"/>
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
						<img src="${contextPath}/resources/images/event-default.png" class="ongoing-events-cover"/>
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
						<img src="${contextPath}/resources/images/event-default.png" class="ongoing-events-cover"/>
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
						<img class="upcoming-events-card-cover" src="${contextPath}/resources/images/event-default.png">
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
			
			<div class = "mobile-nav-overlay">
				<div class="mobile-nav-menu">
					<button class = "mobile-nav-close-button" onclick="toggleMobileMenu()">
						<svg width="32" height="33" viewBox="0 0 32 33" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M28.7204 32.0599L16.0004 19.3199L3.28043 32.0599L0.44043 29.2199L13.1804 16.4999L0.44043 3.77994L3.28043 0.939941L16.0004 13.6799L28.7204 0.959942L31.5404 3.77994L18.8204 16.4999L31.5404 29.2199L28.7204 32.0599Z" fill="black"/>
						</svg>
					</button>
					
					<div class="mobile-nav-menu-lists">
						<button class="mobile-nav-menu-button">Home</button>
						<button class="mobile-nav-menu-button">Home</button>
						<button class="mobile-nav-menu-button">Home</button>
						<button class="mobile-nav-menu-button">About Us</button>
					</div>
					
					<div class="mobile-nav-user-section">
						<div class="nav-user-profile-picture">
							<img src="">
						</div>
						<div class="nav-user-details">
							<h3 class="mobile-nav-user-details-name">Srijan Shrestha</h3>
							<p class="mobile-nav-user-details-email" style="font-size: 12px; color: rgba(0, 0, 0, 0.51); font-family: 'Poppins-Regular';">srijanshrestha999@gmail.com</p>
							<div class = "nav-user-profile-actions">
								<span class="nav-user-details-view-prof-button" style="font-size: 13px; color: rgba(37, 81, 227, 1); font-family: 'Poppins'" onclick="toggleUpdateProfileOverlay()">View Profile</span>
								<button class="logout-button" onclick="toggleLogoutOverlay()">
									<svg width="17" height="16" viewBox="0 0 17 16" fill="none" xmlns="http://www.w3.org/2000/svg">
										<path d="M2.08963 16C1.62897 16 1.24463 15.846 0.936633 15.538C0.628633 15.23 0.474299 14.8453 0.473633 14.384V1.616C0.473633 1.15533 0.627966 0.771 0.936633 0.463C1.2453 0.155 1.62963 0.000666667 2.08963 0H8.49263V1H2.08963C1.93563 1 1.7943 1.064 1.66563 1.192C1.53697 1.32 1.47297 1.46133 1.47363 1.616V14.385C1.47363 14.5383 1.53763 14.6793 1.66563 14.808C1.79363 14.9367 1.93463 15.0007 2.08863 15H8.49263V16H2.08963ZM12.9356 11.539L12.2336 10.819L14.5526 8.5H5.66563V7.5H14.5526L12.2326 5.18L12.9346 4.462L16.4736 8L12.9356 11.539Z" fill="black"/>
									</svg>
									<span class="logout-button-text" style="font-size: 13px; color: rgba(239, 51, 51, 1); font-family: 'Poppins'">Log out</span>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="add-event-overlay">
				<div class="add-event-overlay-menu">
					<button class="exit-add-event-overlay-button" onclick="toggleAddEventsForm()">
						<svg width="14" height="24" viewBox="0 0 14 24" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd" clip-rule="evenodd" d="M4.2074 12.0001L13.6354 21.4281L11.7501 23.3134L1.3794 12.9428C1.12943 12.6927 0.989014 12.3537 0.989014 12.0001C0.989014 11.6465 1.12943 11.3075 1.3794 11.0574L11.7501 0.686768L13.6354 2.5721L4.2074 12.0001Z" fill="black"/>
						</svg>
						<span class="exit-add-event-overlay-button-text">Back</span>
					</button>
					
					<h2 class="add-event-header">Make a new Event</h2>
					<form class="add-event-form" action="${contextPath}/event" method="post" enctype="multipart/form-data">	
						<input type="hidden" name="method" value="ADD" />
						
						<input type = "hidden" name="image-change" id="add-image-changed-flag" value="false" />
						<input name="event-cover" type="file" style="display: none" id="add-event-image-uploader" onchange="handleFileChange(event, 'add')" accept="image/*"/>
						<div class="add-event-cover-image-area" onclick="triggerAddImageUploader()">
							<div class="add-event-upload-image-controls">
								<svg class="add-event-upload-icon" viewBox="0 0 55 50" fill="none" xmlns="http://www.w3.org/2000/svg">
									<path d="M27.5625 15C34.75 15 40.5 20.75 40.5 27.9375C40.5 35.125 34.75 40.875 27.5625 40.875C20.375 40.875 14.625 35.125 14.625 27.9375C14.625 20.75 20.375 15 27.5625 15ZM27.5625 17.875C24.8938 17.875 22.3343 18.9352 20.4472 20.8222C18.5602 22.7093 17.5 25.2688 17.5 27.9375C17.5 30.6062 18.5602 33.1657 20.4472 35.0528C22.3343 36.9398 24.8938 38 27.5625 38C30.2312 38 32.7907 36.9398 34.6778 35.0528C36.5648 33.1657 37.625 30.6062 37.625 27.9375C37.625 25.2688 36.5648 22.7093 34.6778 20.8222C32.7907 18.9352 30.2312 17.875 27.5625 17.875ZM8.875 6.375H14.625L20.375 0.625H34.75L40.5 6.375H46.25C48.5375 6.375 50.7313 7.2837 52.3488 8.9012C53.9663 10.5187 54.875 12.7125 54.875 15V40.875C54.875 43.1625 53.9663 45.3563 52.3488 46.9738C50.7313 48.5913 48.5375 49.5 46.25 49.5H8.875C6.58751 49.5 4.39371 48.5913 2.7762 46.9738C1.1587 45.3563 0.25 43.1625 0.25 40.875V15C0.25 12.7125 1.1587 10.5187 2.7762 8.9012C4.39371 7.2837 6.58751 6.375 8.875 6.375ZM21.5538 3.5L15.8038 9.25H8.875C7.35001 9.25 5.88747 9.8558 4.80914 10.9341C3.7308 12.0125 3.125 13.475 3.125 15V40.875C3.125 42.4 3.7308 43.8625 4.80914 44.9409C5.88747 46.0192 7.35001 46.625 8.875 46.625H46.25C47.775 46.625 49.2375 46.0192 50.3159 44.9409C51.3942 43.8625 52 42.4 52 40.875V15C52 13.475 51.3942 12.0125 50.3159 10.9341C49.2375 9.8558 47.775 9.25 46.25 9.25H39.3213L33.5713 3.5H21.5538Z" fill="#F65E2C"/>
								</svg>
								<p>Upload a cover image</p>
							</div>
							<button type="button" class="add-event-image-remove" onclick="removeAddedImage(event)">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="rgba(246, 94, 44, 1)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash2-icon lucide-trash-2"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
							</button>
							<img class="add-event-cover-image" src="${contextPath}/resources/images/event-default.png"/>
						</div>
						
						<div class="add-event-fields">
							<div class="add-event-field">
								<label for="event-title" class="add-event-field-title">Event Title</label>
								<input type="text" name="event-title" class="add-event-field-input" placeholder="e.g. Aspire 2025"/>
							</div>
							
							<div class="add-event-field">
								<label class="add-event-field-title">Event Duration</label>
								<div class="add-event-date-input-fields">
									<div class="date-input-field">
										<label for="start-date" class="date-input-label">From:</label>
										<input type="date" name="start-date" class="add-event-date-field-input"/>
									</div>
									<div class="date-input-field">
										<label for="end-date" class="date-input-label">To:</label>
										<input name="end-date" type="date" class="add-event-date-field-input"/>
									</div>
								</div>
							</div>
							
							<div class="add-event-field">
								<label for="event-location" class="add-event-field-title">Event Location</label>
								<input name="event-location" type="text" class="add-event-field-input" placeholder="e.g. Brit Cafe"/>
							</div>
							
							<div class="add-event-field">
								<label for="sponsor-name" class="add-event-field-title">Sponsors Name (if any)</label>
								<input name="sponsor-name" type="text" class="add-event-field-input" placeholder="e.g. Restaurant"/>
							</div>
							
							<div class="add-event-field">
								<label for="sponsor-contact" class="add-event-field-title">Sponsors Contact (if any)</label>
								<input name="sponsor-contact" type="text" class="add-event-field-input" placeholder="e.g. Restaurant Contact"/>
							</div>
							
							<div class="add-event-field">
								<label for="sponsor-email" class="add-event-field-title">Sponsors Email (if any)</label>
								<input name="sponsor-email" type="text" class="add-event-field-input" placeholder="e.g. Restaurant@gmail.com"/>
							</div>
							
							<div class="add-event-description-field">
								<label for="event-description" class="add-event-field-title">Event Description</label>
								<textarea name="event-description" class="add-event-description-field-input" placeholder="Maximum 100 words"></textarea>
							</div>
						</div>
						
						<p class="add-event-notice">*This event must be accepted by the admin to be seen in the home page.</p>
						
						<button type="submit" class="confirm-event-submission">Add New Event</button>
					</form>
				</div>
			</div>
			
			<div class="edit-event-overlay">
				<div class="edit-event-overlay-menu">
					<button class="exit-edit-event-overlay-button" onclick="toggleEditEventsForm()">
						<svg width="14" height="24" viewBox="0 0 14 24" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd" clip-rule="evenodd" d="M4.2074 12.0001L13.6354 21.4281L11.7501 23.3134L1.3794 12.9428C1.12943 12.6927 0.989014 12.3537 0.989014 12.0001C0.989014 11.6465 1.12943 11.3075 1.3794 11.0574L11.7501 0.686768L13.6354 2.5721L4.2074 12.0001Z" fill="black"/>
						</svg>
						<span class="exit-edit-event-overlay-button-text">Back</span>
					</button>
					
					<h2 class="edit-event-header">Edit Event</h2>
					<form class="edit-event-form" action="${contextPath}/event">
						<input type="hidden" name="method" value="EDIT" />
						
						<input type="file" style="display: none" id="edit-event-image-uploader" onchange="handleFileChange(event, 'edit')" accept="image/*"/>
						<div class="edit-event-cover-image-area" onclick="triggerEditImageUploader()">
							<div class="edit-event-upload-image-controls">
								<svg class="edit-event-upload-icon" viewBox="0 0 55 50" fill="none" xmlns="http://www.w3.org/2000/svg">
									<path d="M27.5625 15C34.75 15 40.5 20.75 40.5 27.9375C40.5 35.125 34.75 40.875 27.5625 40.875C20.375 40.875 14.625 35.125 14.625 27.9375C14.625 20.75 20.375 15 27.5625 15ZM27.5625 17.875C24.8938 17.875 22.3343 18.9352 20.4472 20.8222C18.5602 22.7093 17.5 25.2688 17.5 27.9375C17.5 30.6062 18.5602 33.1657 20.4472 35.0528C22.3343 36.9398 24.8938 38 27.5625 38C30.2312 38 32.7907 36.9398 34.6778 35.0528C36.5648 33.1657 37.625 30.6062 37.625 27.9375C37.625 25.2688 36.5648 22.7093 34.6778 20.8222C32.7907 18.9352 30.2312 17.875 27.5625 17.875ZM8.875 6.375H14.625L20.375 0.625H34.75L40.5 6.375H46.25C48.5375 6.375 50.7313 7.2837 52.3488 8.9012C53.9663 10.5187 54.875 12.7125 54.875 15V40.875C54.875 43.1625 53.9663 45.3563 52.3488 46.9738C50.7313 48.5913 48.5375 49.5 46.25 49.5H8.875C6.58751 49.5 4.39371 48.5913 2.7762 46.9738C1.1587 45.3563 0.25 43.1625 0.25 40.875V15C0.25 12.7125 1.1587 10.5187 2.7762 8.9012C4.39371 7.2837 6.58751 6.375 8.875 6.375ZM21.5538 3.5L15.8038 9.25H8.875C7.35001 9.25 5.88747 9.8558 4.80914 10.9341C3.7308 12.0125 3.125 13.475 3.125 15V40.875C3.125 42.4 3.7308 43.8625 4.80914 44.9409C5.88747 46.0192 7.35001 46.625 8.875 46.625H46.25C47.775 46.625 49.2375 46.0192 50.3159 44.9409C51.3942 43.8625 52 42.4 52 40.875V15C52 13.475 51.3942 12.0125 50.3159 10.9341C49.2375 9.8558 47.775 9.25 46.25 9.25H39.3213L33.5713 3.5H21.5538Z" fill="#F65E2C"/>
								</svg>
								<p>Upload a cover image</p>
							</div>
							<button type="button" class="edit-event-image-remove" onclick="removeEditedImage(event)">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="rgba(246, 94, 44, 1)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash2-icon lucide-trash-2"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
							</button>
							<img class="edit-event-cover-image" src=""/>
						</div>
						
						<div class="edit-event-fields">
							<div class="edit-event-field">
								<label class="edit-event-field-title">Event Title</label>
								<input type="text" class="edit-event-field-input" placeholder="e.g. Aspire 2025"/>
							</div>
							
							<div class="edit-event-field">
								<label class="edit-event-field-title">Event Duration</label>
								<div class="edit-event-date-input-fields">
									<div class="edit-date-input-field">
										<label class="edit-date-input-label">From:</label>
										<input type="date" class="edit-event-date-field-input"/>
									</div>
									<div class="edit-date-input-field">
										<label class="edit-date-input-label">To:</label>
										<input type="date" class="edit-event-date-field-input"/>
									</div>
								</div>
							</div>
							
							<div class="edit-event-field">
								<label class="edit-event-field-title">Event Location</label>
								<input type="text" class="edit-event-field-input" placeholder="e.g. Brit Cafe"/>
							</div>
							
							<div class="edit-event-field">
								<label class="edit-event-field-title">Sponsors Name (if any)</label>
								<input type="text" class="edit-event-field-input" placeholder="e.g. Restaurant"/>
							</div>
							
							<div class="edit-event-field">
								<label class="edit-event-field-title">Sponsors Contact (if any)</label>
								<input type="text" class="edit-event-field-input" placeholder="e.g. Restaurant Contact"/>
							</div>
							
							<div class="edit-event-field">
								<label class="edit-event-field-title">Sponsors Email (if any)</label>
								<input type="text" class="edit-event-field-input" placeholder="e.g. Restaurant@gmail.com"/>
							</div>
							
							<div class="edit-event-description-field">
								<label class="edit-event-field-title">Event Description</label>
								<textarea class="edit-event-description-field-input" placeholder="Maximum 100 words"></textarea>
							</div>
						</div>
						
						<p class="edit-event-notice">*This information will be modified for everyone after the edit.</p>
						
						<button type="submit" class="confirm-edit-event-submission">Save Edit</button>
					</form>
				</div>
			</div>
			
			<div class="logout-overlay" onclick="handleLogoutOverlayClick(event)">
				<div class="logout-container">
					<svg width="24" height="24" viewBox="0 0 24 24" fill="none" class="logout-warning-icon" xmlns="http://www.w3.org/2000/svg">
						<path d="M12 17C12.2833 17 12.521 16.904 12.713 16.712C12.905 16.52 13.0007 16.2827 13 16C12.9993 15.7173 12.9033 15.48 12.712 15.288C12.5207 15.096 12.2833 15 12 15C11.7167 15 11.4793 15.096 11.288 15.288C11.0967 15.48 11.0007 15.7173 11 16C10.9993 16.2827 11.0953 16.5203 11.288 16.713C11.4807 16.9057 11.718 17.0013 12 17ZM11 13H13V7H11V13ZM12 22C10.6167 22 9.31667 21.7373 8.1 21.212C6.88334 20.6867 5.825 19.9743 4.925 19.075C4.025 18.1757 3.31267 17.1173 2.788 15.9C2.26333 14.6827 2.00067 13.3827 2 12C1.99933 10.6173 2.262 9.31733 2.788 8.1C3.314 6.88267 4.02633 5.82433 4.925 4.925C5.82367 4.02567 6.882 3.31333 8.1 2.788C9.318 2.26267 10.618 2 12 2C13.382 2 14.682 2.26267 15.9 2.788C17.118 3.31333 18.1763 4.02567 19.075 4.925C19.9737 5.82433 20.6863 6.88267 21.213 8.1C21.7397 9.31733 22.002 10.6173 22 12C21.998 13.3827 21.7353 14.6827 21.212 15.9C20.6887 17.1173 19.9763 18.1757 19.075 19.075C18.1737 19.9743 17.1153 20.687 15.9 21.213C14.6847 21.739 13.3847 22.0013 12 22ZM12 20C14.2333 20 16.125 19.225 17.675 17.675C19.225 16.125 20 14.2333 20 12C20 9.76667 19.225 7.875 17.675 6.325C16.125 4.775 14.2333 4 12 4C9.76667 4 7.875 4.775 6.325 6.325C4.775 7.875 4 9.76667 4 12C4 14.2333 4.775 16.125 6.325 17.675C7.875 19.225 9.76667 20 12 20Z" fill="#EF3333"/>
					</svg>
					
					<div class="logout-items">
						<img class="logout-image" src="${contextPath}/resources/images/logout-image.png">
						
						<div class="logout-confirm">
							<p class="logout-confirm-text">Are you sure you want to logout?</p>
							<form class="logout-actions" action="${pageContext.request.contextPath}/login" method="post">
								<input type="hidden" name="action" value="logout" />
								<button class="logout-action-cancel" type="button" onclick="toggleLogoutOverlay()">Cancel</button>
								<button class="logout-action-confirm" type="submit">Confirm</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<div class="update-profile-overlay">
				<div class="update-profile-container">
					<button class="update-profile-back" onclick="toggleUpdateProfileOverlay()">
						<svg width="13" height="24" viewBox="0 0 13 24" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd" clip-rule="evenodd" d="M3.4574 11.9999L12.8854 21.4279L11.0001 23.3132L0.629396 12.9425C0.379434 12.6925 0.239014 12.3534 0.239014 11.9999C0.239014 11.6463 0.379434 11.3072 0.629396 11.0572L11.0001 0.686523L12.8854 2.57186L3.4574 11.9999Z" fill="black"/>
						</svg>
						<span>Back</span>
					</button>
					
					<form class="update-profile-form">
						<div class="update-profile-user-info">
							<img src="${contextPath}/reosources/images/event-default.png" class="user-profile">
							<button class="change-profile-picture-button">Change Profile</button>
							<p class="update-profile-display-name">Srijan Shrestha</p>
						</div>
						
						<div class="update-profile-input-forms">
							<div class="update-profile-form-section">
								<label class="update-profile-input-label">Full Name</label>
								<input name="fullName" type="text" class="update-profile-input-field"/>
							</div>
							
							<div class="update-profile-form-section">
								<label class="update-profile-input-label">Email</label>
								<input name="email" type="text" class="update-profile-input-field"/>
							</div>
							
							<div class="update-profile-form-section">
								<label class="update-profile-input-label">Phone Number</label>
								<input name="phoneNumber" type="text" class="update-profile-input-field"/>
							</div>
							
							<div class="update-profile-form-section">
								<label class="update-profile-input-label">Organization ID (Cannot Be Changed)</label>
								<input name="fullName" type="text" class="update-profile-input-field"/>
							</div>
							
							<div class="update-profile-form-section">
								<label class="update-profile-input-label">Password</label>
								<input name="fullName" type="text" class="update-profile-input-field"/>
							</div>
						</div>
						
						<button type="submit" class="update-profile-submit">Save Edit</button>
					</form>
				</div>
			</div>
		</main>
	</body>
	
	<script>
		function toggleMobileMenu(){
			const navElement = document.querySelector(".mobile-nav-overlay");
			if(navElement.style.display == "block"){
				navElement.style.display = "none";
			}
			else {
				navElement.style.display = "block";
			}
		}
		
		function toggleAddEventsForm(){
			const addEventFormElement = document.querySelector(".add-event-overlay");
			if(addEventFormElement.style.visibility == "visible"){
				addEventFormElement.style.visibility = "hidden";
			} else {
				addEventFormElement.style.visibility = "visible";
			}
		}
		
		function toggleEditEventsForm(){
			const editEventFormElement = document.querySelector(".edit-event-overlay");
			if(editEventFormElement.style.visibility == "visible"){
				editEventFormElement.style.visibility = "hidden";
			} else {
				editEventFormElement.style.visibility = "visible";
			}
		}
		
		function toggleLogoutOverlay(){
			const logoutElement = document.querySelector(".logout-overlay");
			const mobileNavOverlayElement = document.querySelector(".mobile-nav-overlay");
			mobileNavOverlayElement.style.display = "none"; //Hide the mobile nav if it was visible
			if(logoutElement.style.visibility == "visible"){
				logoutElement.style.visibility = "hidden";
			} else {
				logoutElement.style.visibility = "visible";
			}
		}
		
		function toggleUpdateProfileOverlay(){
			const updateProfileElement = document.querySelector(".update-profile-overlay");
			const container = document.querySelector(".update-profile-container");
			const mobileNavOverlayElement = document.querySelector(".mobile-nav-overlay");
			mobileNavOverlayElement.style.display = "none"; //Hide the mobile nav if it was visible
			
			if(updateProfileElement.style.visibility == "visible"){
				container.classList.toggle('active');
				setTimeout(function(){
					updateProfileElement.style.visibility = "hidden";
				}, 400);
			} else {
				updateProfileElement.style.visibility = "visible";
				container.classList.toggle('active');
			}
		}
		
		function handleLogoutOverlayClick(e){
			if(!e.target.closest('.logout-container')){
				toggleLogoutOverlay();
			}
		}
		
		function triggerAddImageUploader(){
			const actualUploader = document.getElementById('add-event-image-uploader');
			actualUploader.click();
		}
		
		function triggerEditImageUploader(){
			const actualUploader = document.getElementById('edit-event-image-uploader');
			actualUploader.click();
		}
		
		function handleFileChange(event, type) {
		    const file = event.target.files[0];
		    if (file) {
		      const reader = new FileReader();

		      reader.onload = function(e) {
		   	  	if(type == "add"){
			        addImageChange(e); // e.target.result is now valid
		   	  	}
		   	  	else {
		   	  		editImageChange(e);
		   	  	}
		      };

		      reader.readAsDataURL(file); // this triggers the onload
		    }
		 }
		
		function addImageChange(e){
			const imageElement = document.querySelector(".add-event-cover-image");
			const addedFlag = document.getElementById("add-image-changed-flag");
			const uploadControls = document.querySelector(".add-event-upload-image-controls");
			const deleteImageButton = document.querySelector(".add-event-image-remove");
			uploadControls.style.display="none";
			imageElement.style.display="block";
			deleteImageButton.style.display = "block";
			imageElement.src = e.target.result;
			addedFlag.value = "true";
		}
		
		function editImageChange(e){
			const imageElement = document.querySelector(".edit-event-cover-image");
			const uploadControls = document.querySelector(".edit-event-upload-image-controls");
			const deleteImageButton = document.querySelector(".edit-event-image-remove");
			uploadControls.style.display="none";
			imageElement.style.display="block";
			deleteImageButton.style.display = "block";
			imageElement.src = e.target.result;
		}
		
		function removeAddedImage(e){
			e.stopPropagation();
			const addedFlag = document.getElementById("add-image-changed-flag");
			const imageElement = document.querySelector(".add-event-cover-image");
			const uploadControls = document.querySelector(".add-event-upload-image-controls");
			const deleteImageButton = document.querySelector(".add-event-image-remove");
			const imageUploader = document.getElementById('add-event-image-uploader')
			imageElement.src="";
			uploadControls.style.display="flex";
			imageElement.style.display="none";
			deleteImageButton.style.display = "none";
			imageUploader.value = "";
			addedFlag.value = "false";
		}
		
		function removeEditedImage(e){
			e.stopPropagation();
			const imageElement = document.querySelector(".edit-event-cover-image");
			const uploadControls = document.querySelector(".edit-event-upload-image-controls");
			const deleteImageButton = document.querySelector(".edit-event-image-remove");
			const imageUploader = document.getElementById('edit-event-image-uploader')
			imageElement.src="";
			uploadControls.style.display="flex";
			imageElement.style.display="none";
			deleteImageButton.style.display = "none";
			imageUploader.value = "";
		}
	</script>
</html>