<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Occasio - Admin Dashboard</title>
		
		<!-- Set contextpath variable for reuse -->
		<c:set var="contextPath" value="${pageContext.request.contextPath}" />
		<link rel="stylesheet" href="${contextPath}/css/dashboard.css?v=${System.currentTimeMillis()}" />
	</head>
	<body>
		<main class = "main">
			<div class = "side-bar">
				<h2 class="side-bar-title">Occasio</h2>
				
				<div class="side-bar-sub-menu">
					<p class="side-bar-sub-menu-title">Dashboard</p>
					<div class="side-bar-sub-menu-items">
						<button id="statisticTabButton" class = "side-bar-sub-menu-items-item active" onClick='switchActiveTab("statistic")'>Statistics</button>
						<button id="userManagementTabButton" class = "side-bar-sub-menu-items-item" onClick='switchActiveTab("userManagement")'>User Management</button>
						<button id="eventRequestsTabButton" class = "side-bar-sub-menu-items-item" onClick='switchActiveTab("userManagement")'>Event Requests</button>
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
				
				<div class = "statistics-tab">
					<h2 style="margin-bottom: 16px;">Dashboard / User Management</h2>
					<div class = "stats-list">
						<div class="stat-card">
						</div>
						<div class="stat-card">
						</div>
						<div class="stat-card">
						</div>
						<div class="stat-card">
						</div>
					</div>
				</div>
				
				<div class="user-management-tab" style="display: none; flex-grow: 1">
					<h3 style="margin-bottom: 16px; font-family: Poppins-Regular; font-weight: 200;">User Information</h3>
					
					<div class = "table-scroll-wrapper">
						<table class="users-table">
							<thead>
								<tr class="users-table-headers">
									<th style="min-width: 200px; max-width: 200px">Name</th>
									<th style="min-width: 200px; max-width: 200px">Organization Name</th>
									<th style="min-width: 100px; max-width: 100px">Role</th>
									<th style="min-width: 120px; max-width: 120px">Phone</th>
									<th style="min-width: 280px; max-width: 280px">Email Address</th>
									<th style="min-width: 100px; max-width: 100px">Edit User</th>
								</tr>
							</thead>
							
							<tbody>
								<tr class="users-table-data">
									<td style="width: 200px; display: flex; align-items: center; gap: 12px;">
										<img class="user-table-data-image" src="${contextPath}/resources/images/profile_pics/queen.webp"/>
										<p style="text-overflow: ellipsis; overflow: hidden;">Srijan Shrestha</p>
									</td>
									<td style="min-width: 200px; max-width: 200px; text-overflow: ellipsis; overflow: hidden;">Islington College</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">User</td>
									<td style="min-width: 120px; max-width: 120px; text-overflow: ellipsis; overflow: hidden;">98293200102</td>
									<td style="min-width: 280px; max-width: 280px; text-overflow: ellipsis; overflow: hidden;">srijanshrestha@gmail.com</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">Edit</td>
								</tr>
								
								<tr class="users-table-data">
									<td style="width: 200px; display: flex; align-items: center; gap: 12px;">
										<img class="user-table-data-image" src="${contextPath}/resources/images/profile_pics/queen.webp"/>
										<p style="text-overflow: ellipsis; overflow: hidden;">Srijan Shrestha</p>
									</td>
									<td style="min-width: 200px; max-width: 200px; text-overflow: ellipsis; overflow: hidden;">Islington College</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">User</td>
									<td style="min-width: 120px; max-width: 120px; text-overflow: ellipsis; overflow: hidden;">98293200102</td>
									<td style="min-width: 280px; max-width: 280px; text-overflow: ellipsis; overflow: hidden;">srijanshrestha@gmail.com</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">Edit</td>
								</tr>
								
								<tr class="users-table-data">
									<td style="width: 200px; display: flex; align-items: center; gap: 12px;">
										<img class="user-table-data-image" src="${contextPath}/resources/images/profile_pics/queen.webp"/>
										<p style="text-overflow: ellipsis; overflow: hidden;">Srijan Shrestha</p>
									</td>
									<td style="min-width: 200px; max-width: 200px; text-overflow: ellipsis; overflow: hidden;">Islington College</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">User</td>
									<td style="min-width: 120px; max-width: 120px; text-overflow: ellipsis; overflow: hidden;">98293200102</td>
									<td style="min-width: 280px; max-width: 280px; text-overflow: ellipsis; overflow: hidden;">srijanshrestha@gmail.com</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">Edit</td>
								</tr>
								
								<tr class="users-table-data">
									<td style="width: 200px; display: flex; align-items: center; gap: 12px;">
										<img class="user-table-data-image" src="${contextPath}/resources/images/profile_pics/queen.webp"/>
										<p style="text-overflow: ellipsis; overflow: hidden;">Srijan Shrestha</p>
									</td>
									<td style="min-width: 200px; max-width: 200px; text-overflow: ellipsis; overflow: hidden;">Islington College</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">User</td>
									<td style="min-width: 120px; max-width: 120px; text-overflow: ellipsis; overflow: hidden;">98293200102</td>
									<td style="min-width: 280px; max-width: 280px; text-overflow: ellipsis; overflow: hidden;">srijanshrestha@gmail.com</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">Edit</td>
								</tr>
								
								<tr class="users-table-data">
									<td style="width: 200px; display: flex; align-items: center; gap: 12px;">
										<img class="user-table-data-image" src="${contextPath}/resources/images/profile_pics/queen.webp"/>
										<p style="text-overflow: ellipsis; overflow: hidden;">Srijan Shrestha</p>
									</td>
									<td style="min-width: 200px; max-width: 200px; text-overflow: ellipsis; overflow: hidden;">Islington College</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">User</td>
									<td style="min-width: 120px; max-width: 120px; text-overflow: ellipsis; overflow: hidden;">98293200102</td>
									<td style="min-width: 280px; max-width: 280px; text-overflow: ellipsis; overflow: hidden;">srijanshrestha@gmail.com</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">Edit</td>
								</tr>
								
								<tr class="users-table-data">
									<td style="width: 200px; display: flex; align-items: center; gap: 12px;">
										<img class="user-table-data-image" src="${contextPath}/resources/images/profile_pics/queen.webp"/>
										<p style="text-overflow: ellipsis; overflow: hidden;">Srijan Shrestha</p>
									</td>
									<td style="min-width: 200px; max-width: 200px; text-overflow: ellipsis; overflow: hidden;">Islington College</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">User</td>
									<td style="min-width: 120px; max-width: 120px; text-overflow: ellipsis; overflow: hidden;">98293200102</td>
									<td style="min-width: 280px; max-width: 280px; text-overflow: ellipsis; overflow: hidden;">srijanshrestha@gmail.com</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">Edit</td>
								</tr>
								
								<tr class="users-table-data">
									<td style="width: 200px; display: flex; align-items: center; gap: 12px;">
										<img class="user-table-data-image" src="${contextPath}/resources/images/profile_pics/queen.webp"/>
										<p style="text-overflow: ellipsis; overflow: hidden;">Srijan Shrestha</p>
									</td>
									<td style="min-width: 200px; max-width: 200px; text-overflow: ellipsis; overflow: hidden;">Islington College</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">User</td>
									<td style="min-width: 120px; max-width: 120px; text-overflow: ellipsis; overflow: hidden;">98293200102</td>
									<td style="min-width: 280px; max-width: 280px; text-overflow: ellipsis; overflow: hidden;">srijanshrestha@gmail.com</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">Edit</td>
								</tr>
							</tbody>
						</table>
						
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

                    <%-- CHANGE 1: Modify the <form> tag --%>
                    <form class="update-profile-form"
                          action="${contextPath}/userProfile"
                          method="post"
                          enctype="multipart/form-data">

                        <div class="update-profile-user-info">
                            <%-- CHANGE 2: Modify the <img> tag src for dynamic display + fallback --%>
                            <img src="${contextPath}/${not empty userProfileImgUrl ? userProfileImgUrl : 'resources/images/default-profile.png'}"
                                 class="user-profile" alt="Current User Profile Picture" data-original-src="${contextPath}/${not empty userProfileImgUrl ? userProfileImgUrl : 'resources/images/default-profile.png'}">

                            <%-- CHANGE 3: Add the hidden file input --%>
                            <input type="file" name="profilePictureFile" id="profilePictureUpload" style="display: none;" accept="image/*" onchange="previewProfilePicture(event)">

                            <%-- CHANGE 4: Modify the "Change Profile" button type and add onclick --%>
                            <button type="button" class="change-profile-picture-button" onclick="document.getElementById('profilePictureUpload').click();">Change Profile</button>

                             <%-- CHANGE 5: Make the display name dynamic --%>
                            <p class="update-profile-display-name"><c:out value="${fullName}"/></p>
                        </div>

                        <div class="update-profile-input-forms">
                            <div class="update-profile-form-section">
                                <label class="update-profile-input-label">Full Name</label>
                                <%-- CHANGE 6a: Add value attribute --%>
                                <input name="fullName" type="text" class="update-profile-input-field" value="<c:out value='${fullName}'/>"/>
                            </div>

                            <div class="update-profile-form-section">
                                <label class="update-profile-input-label">Email</label>
                                <%-- CHANGE 6b: Add value attribute, change type --%>
                                <input name="email" type="email" class="update-profile-input-field" value="<c:out value='${userEmail}'/>"/>
                            </div>

                            <div class="update-profile-form-section">
                                <label class="update-profile-input-label">Phone Number</label>
                                <%-- CHANGE 6c: Add value attribute, change type --%>
                                <input name="phoneNumber" type="tel" class="update-profile-input-field" value="<c:out value='${userPhoneNumber}'/>"/>
                            </div>

                            <div class="update-profile-form-section">
                                <label class="update-profile-input-label">Organization ID (Cannot Be Changed)</label>
                                <%-- CHANGE 6d: Correct name, add value, add readonly --%>
                                <input name="organizationId" type="text" class="update-profile-input-field" value="<c:out value='${organizationId}'/>" readonly/>
                            </div>

                            <div class="update-profile-form-section">
                                <label class="update-profile-input-label">New Password</label> <%-- Changed label --%>
                                <%-- CHANGE 6e: Correct name, change type, add placeholder --%>
                                <input name="password" type="password" class="update-profile-input-field" placeholder="Leave blank to keep current password"/>
                            </div>
                        </div>

                        <button type="submit" class="update-profile-submit">Save Edit</button>
                    </form>
                </div>
            </div>
		</main>
	</body>
	
	<script>
		function switchActiveTab(activeTab){
			const statisticTab = document.querySelector(".statistics-tab");
			const userManagementTab = document.querySelector(".user-management-tab");
			
			const statisticTabButton = document.getElementById("statisticTabButton");
			const userManagementTabButton = document.getElementById("userManagementTabButton");
			
			if (activeTab === "statistic" && !statisticTabButton.classList.contains("active")){
				statisticTabButton.classList.add("active");
				userManagementTabButton.classList.remove("active");
				statisticTab.style.display = "block";
				userManagementTab.style.display = "none";
			}
			else if (activeTab == "userManagement" && !userManagementTabButton.classList.contains("active")){
				statisticTabButton.classList.remove("active");
				userManagementTabButton.classList.add("active");
				statisticTab.style.display = "none";
				userManagementTab.style.display = "block";
			}
		}
	</script>
</html>