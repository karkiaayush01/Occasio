<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Occasio - Admin Dashboard</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<!-- Set contextpath variable for reuse -->
		<c:set var="contextPath" value="${pageContext.request.contextPath}" />
		<link rel="stylesheet" href="${contextPath}/css/dashboard.css?v=${System.currentTimeMillis()}" />
		<link rel="stylesheet" href="${contextPath}/css/logout.css?v=${System.currentTimeMillis()}" />
		<link rel="stylesheet" href="${contextPath}/css/updateProfile.css?v=${System.currentTimeMillis()}" />
	</head>
	<body>
		<main class = "main">
			<div class = "side-bar">
				<h2 class="side-bar-title">Occasio</h2>
				
				<div class="side-bar-sub-menu">
					<div class="side-bar-sub-menu-items">
						<button id="statisticTabButton" class = "side-bar-sub-menu-items-item" onClick="window.location.href='${contextPath}/dashboard'">Dashboard</button>
						<button id="userManagementTabButton" class = "side-bar-sub-menu-items-item" onClick="window.location.href='${contextPath}/userManagement'">User Management</button>
						<button id="eventRequestsTabButton" class = "side-bar-sub-menu-items-item active" onClick="window.location.href='${contextPath}/eventRequest'">Event Requests</button>
					</div>
				</div>
			</div>
			
			<div class = "main-content">
				<div class="user-nav">
					<div class="nav-user-section">
						<div class="nav-user-profile-picture">
							<img class="nav-user-profile-picture-img" src="${contextPath}/${userProfileImgUrl}">
						</div>
						<div class="nav-user-details">
							<h3 class="nav-user-details-name">
								${fullName}
							</h3>
							<p class="nav-user-details-email" style="font-size: 14px; color: rgba(0, 0, 0, 0.51); font-family: 'Poppins';">
								${userEmail}
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
				</div>
				
				<!-- Event requests for admin to manage -->
				<div class="user-management-tab" style="flex-grow: 1">
                    <h2 style="margin-bottom: 16px;">Event Requests</h2>
                     <c:if test="${not empty message}">
                        <p class="message">${message}</p>
                    </c:if>
                    <div class = "table-scroll-wrapper">
                        <table class="users-table">
                            <thead>
                                <tr class="users-table-headers">
                                    <th style="min-width: 280px; max-width: 280px">Event Name</th>
                                    <th style="min-width: 100px; max-width: 100px">EventId</th>
                                    <th style="min-width: 250px; max-width: 250px">Posted By</th>
                                    <th style="min-width: 280px; max-width: 280px">Event-Duration</th>
                                    <th style="min-width: 100px; max-width: 100px">Actions</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="event" items="${allEvents}">
                                    <tr class="users-table-data">
                                        <td style="width: 280px; display: flex; align-items: center; gap: 12px;">
                                            <img class="user-table-data-image" src="${contextPath}/resources/images/event-default.png"/>
                                            <p style="text-overflow: ellipsis; overflow: hidden;"><c:out value="${event.name}" /></p>
                                        </td>
                                        <td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;"><c:out value="${event.id}" /></td>
                                        <td style="min-width: 250px; max-width: 250px; text-overflow: ellipsis; overflow: hidden;"><c:out value="${event.posterUserId}" /></td>
                                        <td style="min-width: 280px; max-width: 280px; text-overflow: ellipsis; overflow: hidden;"><c:out value="${event.startDate} - ${event.endDate}" /></td>
                                        <td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">
                                            <div class="user-actions">
											   <form action="${contextPath}/eventRequest" method="post">
											       <input type="hidden" name="action" value="approveEvent" />
											       <input type="hidden" name="eventId" value="${event.id}" />
											       <button class="approve-event-table-button" type="submit">
											          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-check-icon lucide-check">
											             <path d="M20 6 9 17l-5-5"/>
											           </svg>
											        </button>
											    </form>
											
											    <button class="reject-event-table-button" onClick="toggleRejectEvent('${event.id}')">
											       <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-x-icon lucide-x"><path d="M18 6 6 18"/>
											          <path d="m6 6 12 12"/>
											          </svg>
											     </button>
											</div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
			</div>
			
			<!-- update profile overlay -->
			<div class="update-profile-overlay">
                <div class="update-profile-container">
                    <button class="update-profile-back" onclick="toggleUpdateProfileOverlay()">
                        <svg width="13" height="24" viewBox="0 0 13 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M3.4574 11.9999L12.8854 21.4279L11.0001 23.3132L0.629396 12.9425C0.379434 12.6925 0.239014 12.3534 0.239014 11.9999C0.239014 11.6463 0.379434 11.3072 0.629396 11.0572L11.0001 0.686523L12.8854 2.57186L3.4574 11.9999Z" fill="black"/>
                        </svg>
                        <span>Back</span>
                    </button>

                    <form class="update-profile-form"
                          action="${contextPath}/userProfile"
                          method="post"
                          enctype="multipart/form-data">

                        <div class="update-profile-user-info">\
                            <img src="${contextPath}/${not empty userProfileImgUrl ? userProfileImgUrl : 'resources/images/default-profile.png'}"
                                 class="user-profile" alt="Current User Profile Picture" data-original-src="${contextPath}/${not empty userProfileImgUrl ? userProfileImgUrl : 'resources/images/default-profile.png'}">

                            <input type="file" name="profilePictureFile" id="profilePictureUpload" style="display: none;" accept="image/*" onchange="previewProfilePicture(event)">

                            <button type="button" class="change-profile-picture-button" onclick="document.getElementById('profilePictureUpload').click();">Change Profile</button>

                            <p class="update-profile-display-name"><c:out value="${fullName}"/></p>
                        </div>

                        <div class="update-profile-input-forms">
                            <div class="update-profile-form-section">
                                <label class="update-profile-input-label">Full Name</label>
                                <input name="fullName" type="text" class="update-profile-input-field" value="<c:out value='${fullName}'/>"/>
                            </div>

                            <div class="update-profile-form-section">
                                <label class="update-profile-input-label">Email</label>
                                <input name="email" type="email" class="update-profile-input-field" value="<c:out value='${userEmail}'/>"/>
                            </div>

                            <div class="update-profile-form-section">
                                <label class="update-profile-input-label">Phone Number</label>
                                <input name="phoneNumber" type="tel" class="update-profile-input-field" value="<c:out value='${userPhoneNumber}'/>"/>
                            </div>

                            <div class="update-profile-form-section">
                                <label class="update-profile-input-label">Organization ID (Cannot Be Changed)</label>
                                <input name="organizationId" type="text" class="update-profile-input-field" value="<c:out value='${organizationId}'/>" readonly/>
                            </div>

                            <div class="update-profile-form-section">
                                <label class="update-profile-input-label">New Password</label> 
                                <input name="password" type="password" class="update-profile-input-field" placeholder="Leave blank to keep current password"/>
                            </div>
                        </div>

                        <button type="submit" class="update-profile-submit">Save Edit</button>
                    </form>
                </div>
            </div>
            <!-- logout overlay -->
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
			
			<div class="event-management-overlay" id="reject-event-overlay">
				<form class="reject-event-container" action="${contextPath}/eventRequest" method="post">
					<input type="hidden" name="action" value="rejectEvent" />
					<input type="hidden" name="eventId" id="rejectEventIdField" value="" />
					<div class="reject-event-container-info">
						<h2 class="reject-event-container-info-heading">Reject Event Request</h2>
						<textarea class="reject-event-container-info-textarea" name="rejectionReason" placeholder="Enter your reason for rejection"></textarea>
					</div>
					<div class="reject-event-controls">
						<button class="reject-event-button cancel" type="button" onClick="toggleRejectEvent()">Cancel</button>
						<button class="reject-event-button confirm" type="submit">Confirm</button>
					</div>
				</form>
			</div>
			
			<div class="event-management-overlay" id="approve-event-overlay">
				<form class="approve-event-container" action="${contextPath}/eventRequest" method="post">
					<input type="hidden" name="eventId" id="approveEventIdField" value="" />
					<div class="approve-event-container-info">
						<h2 class="approve-event-container-info-heading" style="margin-bottom: 16px;">Approve Event</h2>
						<p class="approve-event-container-info-text">Are you sure you want to approve this event? This will be visible to all the users within the organization.</p>
					</div>
					<div class="approve-event-controls">
						<button class="approve-event-button cancel" type="button" onClick="toggleApproveEvent()">Cancel</button>
						<button class="approve-event-button confirm" type="submit">Confirm</button>
					</div>
				</form>
			</div>
		</main>
		<script src="${contextPath}/script/updateProfile.js"></script>
	</body>

	<script>
	
		function switchActiveTab(activeTab){
	        const statisticTab = document.querySelector(".statistics-tab");
	        const userManagementTab = document.querySelector(".user-management-tab");
	
	        const statisticTabButton = document.getElementById("statisticTabButton");
	        const userManagementTabButton = document.getElementById("userManagementTabButton");
	
	        // Check If Active Tab Is Statistic And Statistic Tab Button Is Not Active
	        if (activeTab === "statistic" && !statisticTabButton.classList.contains("active")){
	            statisticTabButton.classList.add("active");
	            userManagementTabButton.classList.remove("active");
	            statisticTab.style.display = "block";
	            userManagementTab.style.display = "none";
	        }
	         // Check If Active Tab Is User Management And User Management Tab Button Is Not Active
	        else if (activeTab == "userManagement" && !userManagementTabButton.classList.contains("active")){
	            statisticTabButton.classList.remove("active");
	            userManagementTabButton.classList.add("active");
	            statisticTab.style.display = "none";
	            userManagementTab.style.display = "block";
	        }
	    }
		
		function toggleLogoutOverlay(){
			const logoutElement = document.querySelector(".logout-overlay");
			const mobileNavOverlayElement = document.querySelector(".mobile-nav-overlay");
			//mobileNavOverlayElement.style.display = "none"; //Hide the mobile nav if it was visible
			// Check If LogOut Overlay Is Visible
			if(logoutElement.style.visibility == "visible"){
				logoutElement.style.visibility = "hidden";
			} else {
				logoutElement.style.visibility = "visible";
			}
		}
		
		/**
		 * Handles clicks outside the logout container to close the logout overlay.
		 * @param {Event} e The click event.
		 */
		function handleLogoutOverlayClick(e){
			// Check If Click Occured Close To Logout Container
			if(!e.target.closest('.logout-container')){
				toggleLogoutOverlay();
			}
		}
		
		/**
		 * Toggles the visibility of the reject event overlay.
		 * @param {number} eventId The ID of the event to reject (optional, defaults to 0).
		 */
		function toggleRejectEvent(eventId = 0){
			const rejectOverlay = document.getElementById("reject-event-overlay");
			const eventIdInputField = document.getElementById("rejectEventIdField");
			const rejectTextArea = document.querySelector(".reject-event-container-info-textarea");
			// Check If Reject Overlay Is Hidden
			if(rejectOverlay.style.visibility == "hidden" || rejectOverlay.style.visibility == ""){
				rejectOverlay.style.visibility = "visible";
				eventIdInputField.value = eventId.toString();
			} 
			else{
				rejectOverlay.style.visibility = "hidden";
				eventIdInputField.value="";
				rejectTextArea.value="";
			}
		}
		
		/**
		 * Toggles the visibility of the approve event overlay.
		 * @param {number} eventId The ID of the event to approve (optional, defaults to 0).
		 */
		function toggleApproveEvent(eventId = 0){
			const approveOverlay = document.getElementById("approve-event-overlay");
			const eventIdInputField = document.getElementById("approveEventIdField");
			// Check If Approve Overlay Is Hidden
			if(approveOverlay.style.visibility == "hidden" || approveOverlay.style.visibility == ""){
				approveOverlay.style.visibility = "visible";
				eventIdInputField.value = eventId.toString();
			} 
			else{
				approveOverlay.style.visibility = "hidden";
				eventIdInputField.value="";
			}
		}
	</script>
</html>