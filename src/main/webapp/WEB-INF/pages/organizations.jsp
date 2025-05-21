<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Occasio - Super Admin Dashboard</title>
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
						<button id="statisticTabButton" class = "side-bar-sub-menu-items-item" onClick="window.location.href='${contextPath}/superDashboard'">Super Dashboard</button>
						<button id="userManagementTabButton" class = "side-bar-sub-menu-items-item active" onClick="window.location.href='${contextPath}/organizations'">Organizations</button>
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
				
				<div class="user-management-tab" style="flex-grow: 1">
					<div style="display: flex; gap: 12px; align-items: center; margin-bottom: 8px;">
						<h2>Organizations</h2>
						<button class="add-organization-button" onclick="toggleCreateOrganizationForm()">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-plus-icon lucide-plus"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
							<span class="events-actions-add-text">Add Organization</span>
						</button>
					</div>	
					
					<div class = "table-scroll-wrapper">
						<table class="users-table">
							<thead>
								<tr class="users-table-headers">
									<th style="min-width: 100px; max-width: 100px; padding-left: 8px;">Org Id</th>
									<th style="min-width: 250px; max-width: 250px">Org Name</th>
									<th style="min-width: 200px; max-width: 200px">Onboarded Date</th>
									<th style="min-width: 150px; max-width: 150px">Status</th>
									<th style="min-width: 200px; max-width: 200px">Admin Name</th>
									<th style="min-width: 100px; max-width: 100px">Actions</th>
								</tr>
							</thead>
							
							<tbody>
								<tr class="users-table-data">
									<td style="width: 100px; display: flex; align-items: center; gap: 12px;">
										<p style="text-overflow: ellipsis; overflow: hidden;">1</p>
									</td>
									<td style="min-width: 250px; max-width: 250px; text-overflow: ellipsis; overflow: hidden;">Islington College</td>
									<td style="min-width: 200px; max-width: 200px; text-overflow: ellipsis; overflow: hidden;">2025-5-26</td>
									<td style="min-width: 150px; max-width: 150px; text-overflow: ellipsis; overflow: hidden;">Active</td>
									<td style="min-width: 200px; max-width: 200px; text-overflow: ellipsis; overflow: hidden;">Admin</td>
									<td style="min-width: 100px; max-width: 100px; text-overflow: ellipsis; overflow: hidden;">
										<div class="user-actions">
											<button class="delete-user-button" onClick="toggleDeleteOrgModal(0)">
												<svg width="18" height="19" viewBox="0 0 18 19" fill="none" xmlns="http://www.w3.org/2000/svg">
													<path d="M1.5 4.43294H3.16667M3.16667 4.43294H16.5M3.16667 4.43294V16.0996C3.16667 16.5416 3.34226 16.9656 3.65482 17.2781C3.96738 17.5907 4.39131 17.7663 4.83333 17.7663H13.1667C13.6087 17.7663 14.0326 17.5907 14.3452 17.2781C14.6577 16.9656 14.8333 16.5416 14.8333 16.0996V4.43294H3.16667ZM5.66667 4.43294V2.76628C5.66667 2.32425 5.84226 1.90033 6.15482 1.58776C6.46738 1.2752 6.89131 1.09961 7.33333 1.09961H10.6667C11.1087 1.09961 11.5326 1.2752 11.8452 1.58776C12.1577 1.90033 12.3333 2.32425 12.3333 2.76628V4.43294M7.33333 8.59961V13.5996M10.6667 8.59961V13.5996" stroke="black" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
												</svg>
											</button>
											
											<button class="edit-user-button" onClick="toggleUpdateUserModal(0)">
												<svg width="20" height="19" viewBox="0 0 20 19" fill="none" xmlns="http://www.w3.org/2000/svg">
													<path d="M14.166 1.9345C14.3849 1.71563 14.6447 1.54201 14.9307 1.42356C15.2167 1.30511 15.5232 1.24414 15.8327 1.24414C16.1422 1.24414 16.4487 1.30511 16.7347 1.42356C17.0206 1.54201 17.2805 1.71563 17.4993 1.9345C17.7182 2.15337 17.8918 2.4132 18.0103 2.69917C18.1287 2.98514 18.1897 3.29163 18.1897 3.60116C18.1897 3.91069 18.1287 4.21719 18.0103 4.50316C17.8918 4.78912 17.7182 5.04896 17.4993 5.26783L6.24935 16.5178L1.66602 17.7678L2.91602 13.1845L14.166 1.9345Z" stroke="black" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
												</svg>
											</button>
										</div>
									</td>
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
			
			<div class="user-management-overlay" id="user-delete-overlay">
				<form class="user-delete-container">
					<input type="hidden" name="orgId" id="deleteOrgIdField" value="" />
					<div class="user-delete-container-info">
						<h2 class="user-delete-container-info-heading">Delete Organization</h2>
						<p class="user-delete-container-info-text">Are you sure you want to delete this organization? This action cannot be undone.</p>
					</div>
					<div class="user-delete-controls">
						<button class="user-delete-button cancel" type="button" onClick="toggleDeleteOrgModal()">Cancel</button>
						<button class="user-delete-button confirm" type="submit">Confirm</button>
					</div>
				</form>
			</div>
			
			<div class="user-management-overlay" id="user-edit-overlay">
				<div class="user-edit-container" style="height: 400px">
					<button class="user-edit-container-back" onclick="toggleUpdateUserModal()">
                        <svg width="13" height="24" viewBox="0 0 13 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M3.4574 11.9999L12.8854 21.4279L11.0001 23.3132L0.629396 12.9425C0.379434 12.6925 0.239014 12.3534 0.239014 11.9999C0.239014 11.6463 0.379434 11.3072 0.629396 11.0572L11.0001 0.686523L12.8854 2.57186L3.4574 11.9999Z" fill="black"/>
                        </svg>
                        <span>Back</span>
                    </button>
                    <div class="user-edit-container-content">
						<h2 class="user-edit-container-title">Edit Organization</h2>
						<form class="user-edit-form">
							<input type="hidden" name="orgId" id="updateOrgIdField" value="" />
							<div class="user-edit-form-section">
								<label for="fullName" class="user-edit-form-section-label">Organization Name</label>
								<input type="text" name="fullName" class="user-edit-form-section-input" placeholder="Occasio"/>
							</div>
							<div class="user-edit-form-section">
								<label for="email" class="user-edit-form-section-label">Admin Name</label>
								<input type="text" name="email" class="user-edit-form-section-input" placeholder="John Doe"/>
							</div>
							<button type="submit" class="user-edit-form-submit">Save Edit</button>
						</form>
					</div>
				</div>
			</div>
			
			<div class="user-management-overlay" id="org-edit-overlay">
				<div class="user-edit-container">
					<button class="user-edit-container-back" onclick="toggleCreateOrganizationForm()">
                        <svg width="13" height="24" viewBox="0 0 13 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M3.4574 11.9999L12.8854 21.4279L11.0001 23.3132L0.629396 12.9425C0.379434 12.6925 0.239014 12.3534 0.239014 11.9999C0.239014 11.6463 0.379434 11.3072 0.629396 11.0572L11.0001 0.686523L12.8854 2.57186L3.4574 11.9999Z" fill="black"/>
                        </svg>
                        <span>Back</span>
                    </button>
                    <div class="user-edit-container-content">
						<h2 class="user-edit-container-title">Create Organization</h2>
						<form class="user-edit-form">
							<div class="user-edit-form-section">
								<label for="orgName" class="user-edit-form-section-label">Organizaton Name</label>
								<input type="text" name="orgName" class="user-edit-form-section-input" placeholder="Occasio"/>
							</div>
							<div class="user-edit-form-section">
								<label for="adminName" class="user-edit-form-section-label">Admin Name</label>
								<input type="text" name="adminName" class="user-edit-form-section-input" placeholder="John Doe"/>
							</div>
							<div class="user-edit-form-section">
								<label for="adminEmail" class="user-edit-form-section-label">Admin Email</label>
								<input type="text" name="adminEmail" class="user-edit-form-section-input" placeholder="example@gmail.com"/>
							</div>
							<div class="user-edit-form-section">
								<label for="adminPassword" class="user-edit-form-section-label">Admin Password</label>
								<input type="text" name="adminPassword" class="user-edit-form-section-input"/>
							</div>
							<button type="submit" class="user-edit-form-submit">Create</button>
						</form>
					</div>
				</div>
			</div>
		</main>
		<script src="${contextPath}/script/updateProfile.js"></script>
	</body>

	<script>
		function toggleLogoutOverlay(){
			const logoutElement = document.querySelector(".logout-overlay");
			const mobileNavOverlayElement = document.querySelector(".mobile-nav-overlay");
			//mobileNavOverlayElement.style.display = "none"; //Hide the mobile nav if it was visible
			if(logoutElement.style.visibility == "visible"){
				logoutElement.style.visibility = "hidden";
			} else {
				logoutElement.style.visibility = "visible";
			}
		}
		
		function handleLogoutOverlayClick(e){
			if(!e.target.closest('.logout-container')){
				toggleLogoutOverlay();
			}
		}
		
		function toggleDeleteOrgModal(userId = 0){
			const deleteOverlay = document.getElementById("user-delete-overlay");
			const orgIdInputField = document.getElementById("deleteOrgIdField");
			if(deleteOverlay.style.visibility == "hidden" || deleteOverlay.style.visibility == ""){
				deleteOverlay.style.visibility = "visible";
				orgIdInputField.value = userId.toString();
			} 
			else{
				deleteOverlay.style.visibility = "hidden";
				orgIdInputField.value="";
			}
		}
		
		//populate the fields based on userId from here 
		function toggleUpdateUserModal(orgId = 0){
			const updateOverlay = document.getElementById("user-edit-overlay");
			const orgIdInputField = document.getElementById("updateOrgIdField");
			if(updateOverlay.style.visibility == "hidden" || updateOverlay.style.visibility == ""){
				updateOverlay.style.visibility = "visible";
				orgIdInputField.value = userId.toString();
			} 
			else{
				updateOverlay.style.visibility = "hidden";
				orgIdInputField.value="";
			}
		}
		
		function toggleCreateOrganizationForm() {
			const updateOverlay = document.getElementById("org-edit-overlay");
			if(updateOverlay.style.visibility == "hidden" || updateOverlay.style.visibility == ""){
				updateOverlay.style.visibility = "visible";
			} 
			else{
				updateOverlay.style.visibility = "hidden";
			}
		}
	</script>
</html>