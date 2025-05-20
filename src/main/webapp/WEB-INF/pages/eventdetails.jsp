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
			<div class= "main-event">
			<section class="event-interest">
				<div class="event-picture">
					<img src="${pageContext.request.contextPath}/resources/images/event-default.png" class="events-cover" />
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
				<section class = "details-section">
					<div class= "detail-event-div">
						<p class = "details-event"> Event Details</p>
					</div>
					 <div class="detail-item">
       					 <div class="detail-label">
          					<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12.0757 20.82C11.9124 20.9372 11.7166 21.0003 11.5156 21.0003C11.3147 21.0003 11.1189 20.9372 10.9556 20.82C6.12665 17.378 1.00165 10.298 6.18265 5.182C7.60499 3.78285 9.52049 2.99912 11.5156 3C13.5156 3 15.4346 3.785 16.8486 5.181C22.0297 10.297 16.9047 17.376 12.0757 20.82Z" stroke="black" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M11.5156 12C12.0461 12 12.5548 11.7893 12.9298 11.4142C13.3049 11.0391 13.5156 10.5304 13.5156 10C13.5156 9.46957 13.3049 8.96086 12.9298 8.58579C12.5548 8.21071 12.0461 8 11.5156 8C10.9852 8 10.4765 8.21071 10.1014 8.58579C9.72634 8.96086 9.51562 9.46957 9.51562 10C9.51562 10.5304 9.72634 11.0391 10.1014 11.4142C10.4765 11.7893 10.9852 12 11.5156 12Z" stroke="black" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
							</svg>

         					 <span class = "venue-text">Venue</span>
         					 <address class="detail-value">Kumari Hall</address>
       					 </div>
        				
     				 </div>
     				 
     				 <div class="event-date">
       					 <div class="calender-label">
          					<svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg"><g clip-path="url(#clip0_331_209)"><path d="M19.2656 2.46821H16.4219V1.15571C16.422 0.981663 16.353 0.814697 16.23 0.691544C16.107 0.568391 15.9401 0.49914 15.7661 0.499024C15.592 0.498908 15.425 0.567937 15.3019 0.690925C15.1787 0.813914 15.1095 0.980788 15.1094 1.15484V2.46821H11.1719V1.15571C11.1719 1.06953 11.155 0.984184 11.1221 0.904542C11.0892 0.8249 11.0409 0.752523 10.98 0.691544C10.9191 0.630565 10.8468 0.582178 10.7672 0.549145C10.6876 0.516112 10.6022 0.499081 10.5161 0.499024C10.342 0.498908 10.175 0.567937 10.0519 0.690925C9.92874 0.813914 9.85949 0.980788 9.85938 1.15484V2.46821H5.92188V1.15571C5.92193 1.06953 5.90501 0.984184 5.87209 0.904542C5.83916 0.8249 5.79087 0.752523 5.72997 0.691544C5.66908 0.630565 5.59676 0.582178 5.51717 0.549145C5.43757 0.516112 5.35224 0.499081 5.26606 0.499024C5.09201 0.498908 4.92505 0.567937 4.8019 0.690925C4.67874 0.813914 4.60949 0.980788 4.60938 1.15484V2.46821H1.76562C1.30165 2.46821 0.856661 2.65247 0.528497 2.98046C0.200334 3.30846 0.015857 3.75336 0.015625 4.21734V19.7486C0.015625 20.2127 0.199999 20.6578 0.528188 20.986C0.856377 21.3142 1.3015 21.4986 1.76562 21.4986H19.2656C19.7298 21.4986 20.1749 21.3142 20.5031 20.986C20.8312 20.6578 21.0156 20.2127 21.0156 19.7486V4.21734C21.0154 3.75336 20.8309 3.30846 20.5028 2.98046C20.1746 2.65247 19.7296 2.46821 19.2656 2.46821ZM19.7031 19.7495C19.7031 19.8653 19.6572 19.9765 19.5753 20.0585C19.4934 20.1405 19.3824 20.1867 19.2665 20.187H1.76562C1.64959 20.187 1.53831 20.1409 1.45627 20.0588C1.37422 19.9768 1.32812 19.8655 1.32812 19.7495V4.21821C1.32836 4.10233 1.37455 3.99128 1.45657 3.90942C1.5386 3.82756 1.64974 3.78159 1.76562 3.78159H4.60938V5.09409C4.60926 5.26813 4.67829 5.4351 4.80128 5.55825C4.92427 5.68141 5.09114 5.75066 5.26519 5.75077C5.43924 5.75089 5.6062 5.68186 5.72935 5.55887C5.85251 5.43588 5.92176 5.26901 5.92188 5.09496V3.78159H9.85938V5.09409C9.85926 5.26813 9.92829 5.4351 10.0513 5.55825C10.1743 5.68141 10.3411 5.75066 10.5152 5.75077C10.6892 5.75089 10.8562 5.68186 10.9794 5.55887C11.1025 5.43588 11.1718 5.26901 11.1719 5.09496V3.78159H15.1094V5.09409C15.1093 5.26813 15.1783 5.4351 15.3013 5.55825C15.4243 5.68141 15.5911 5.75066 15.7652 5.75077C15.9392 5.75089 16.1062 5.68186 16.2294 5.55887C16.3525 5.43588 16.4218 5.26901 16.4219 5.09496V3.78159H19.2656C19.3814 3.78182 19.4923 3.82789 19.5741 3.90973C19.6559 3.99156 19.702 4.10248 19.7023 4.21821L19.7031 19.7495Z" fill="black"/><path d="M4.60938 8.375H7.23438V10.3438H4.60938V8.375ZM4.60938 11.6562H7.23438V13.625H4.60938V11.6562ZM4.60938 14.9375H7.23438V16.9062H4.60938V14.9375ZM9.20312 14.9375H11.8281V16.9062H9.20312V14.9375ZM9.20312 11.6562H11.8281V13.625H9.20312V11.6562ZM9.20312 8.375H11.8281V10.3438H9.20312V8.375ZM13.7969 14.9375H16.4219V16.9062H13.7969V14.9375ZM13.7969 11.6562H16.4219V13.625H13.7969V11.6562ZM13.7969 8.375H16.4219V10.3438H13.7969V8.375Z" fill="black"/></g><defs><clipPath id="clip0_331_209"><rect width="21" height="21" fill="white" transform="translate(0.5 0.5)"/></clipPath></defs>
							</svg>
         					 <span class = "date-text">Date</span>
         					 <time class="date-num" datetime= "2025-05-12"> 2025/05/12 - 2025/05/14 </time>
       					 </div>
        				
     				 </div>
     				 <div class="event-time">
       					 <div class="time-label">
          					<svg width="20" height="22" viewBox="0 0 20 22" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10.0157 0.416992C15.3086 0.416992 19.599 4.70745 19.599 10.0003C19.599 15.2932 15.3086 19.5837 10.0157 19.5837C4.72283 19.5837 0.432373 15.2932 0.432373 10.0003C0.432373 4.70745 4.72283 0.416992 10.0157 0.416992ZM10.0157 2.33366C7.98238 2.33366 6.03233 3.14139 4.59455 4.57917C3.15678 6.01695 2.34904 7.967 2.34904 10.0003C2.34904 12.0337 3.15678 13.9837 4.59455 15.4215C6.03233 16.8593 7.98238 17.667 10.0157 17.667C12.049 17.667 13.9991 16.8593 15.4369 15.4215C16.8746 13.9837 17.6824 12.0337 17.6824 10.0003C17.6824 7.967 16.8746 6.01695 15.4369 4.57917C13.9991 3.14139 12.049 2.33366 10.0157 2.33366ZM10.0157 4.25033C10.2504 4.25036 10.477 4.33653 10.6524 4.49251C10.8278 4.64849 10.9399 4.86342 10.9673 5.09653L10.974 5.20866V9.60358L13.5682 12.1978C13.7401 12.3702 13.8399 12.6017 13.8473 12.845C13.8548 13.0884 13.7693 13.3255 13.6083 13.5081C13.4472 13.6907 13.2227 13.8052 12.9803 13.8283C12.738 13.8514 12.4959 13.7813 12.3032 13.6324L12.2132 13.5529L9.33816 10.6779C9.18922 10.5288 9.09356 10.3348 9.066 10.1259L9.05737 10.0003V5.20866C9.05737 4.95449 9.15834 4.71074 9.33806 4.53101C9.51779 4.35129 9.76154 4.25033 10.0157 4.25033Z" fill="black"/>
							</svg>
          					
         					 <span class = "time-text">Time</span>
         					 <time class="time-num" > 4:00pm - 6:00pm </time>
       					 </div>
        				
     				 </div>
				</section>
				<section class= "description-section">
					<div class= "desc-event-div">
						<p class = "desc-event"> Event Description</p>
					</div>
					<div class= event-desc>
						<p class = "event-desc-para">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non justo ac ante vestibulum hendrerit. Vivamus vel eros vitae nibh hendrerit lacinia. Nullam vitae velit eget odio tincidunt tristique. Proin tincidunt leo ac velit vulputate, at tincidunt risus viverra. Suspendisse potenti. Cras dapibus era </p>
					</div>
				
				</section>
				<section class = "organized-section">
					<div class= "org-event">
						<p> Organized by </p>
						<p class = "Org-name"> Shreejesh Pathak </p>
					</div>
					<div class= "org-event-sponsor">
						<p> Sponsored by </p>
						<p class = "org-sponsor"> Islington College </p>
					</div>
					<div class= "org-event-email">
						<p> Sponsor's Email </p>
						<p> islingtoncollege@gmail.com </p>
					</div>
					<div class= "org-event-contact">
						<p> Sponsor contact </p>
						<p> 9812345678 </p>
					</div>
				</section>
			</div>
		</main>
		<div class="logout-overlay">
				<div class="logout-container">
					<svg width="24" height="24" viewBox="0 0 24 24" fill="none" class="logout-warning-icon" xmlns="http://www.w3.org/2000/svg">
						<path d="M12 17C12.2833 17 12.521 16.904 12.713 16.712C12.905 16.52 13.0007 16.2827 13 16C12.9993 15.7173 12.9033 15.48 12.712 15.288C12.5207 15.096 12.2833 15 12 15C11.7167 15 11.4793 15.096 11.288 15.288C11.0967 15.48 11.0007 15.7173 11 16C10.9993 16.2827 11.0953 16.5203 11.288 16.713C11.4807 16.9057 11.718 17.0013 12 17ZM11 13H13V7H11V13ZM12 22C10.6167 22 9.31667 21.7373 8.1 21.212C6.88334 20.6867 5.825 19.9743 4.925 19.075C4.025 18.1757 3.31267 17.1173 2.788 15.9C2.26333 14.6827 2.00067 13.3827 2 12C1.99933 10.6173 2.262 9.31733 2.788 8.1C3.314 6.88267 4.02633 5.82433 4.925 4.925C5.82367 4.02567 6.882 3.31333 8.1 2.788C9.318 2.26267 10.618 2 12 2C13.382 2 14.682 2.26267 15.9 2.788C17.118 3.31333 18.1763 4.02567 19.075 4.925C19.9737 5.82433 20.6863 6.88267 21.213 8.1C21.7397 9.31733 22.002 10.6173 22 12C21.998 13.3827 21.7353 14.6827 21.212 15.9C20.6887 17.1173 19.9763 18.1757 19.075 19.075C18.1737 19.9743 17.1153 20.687 15.9 21.213C14.6847 21.739 13.3847 22.0013 12 22ZM12 20C14.2333 20 16.125 19.225 17.675 17.675C19.225 16.125 20 14.2333 20 12C20 9.76667 19.225 7.875 17.675 6.325C16.125 4.775 14.2333 4 12 4C9.76667 4 7.875 4.775 6.325 6.325C4.775 7.875 4 9.76667 4 12C4 14.2333 4.775 16.125 6.325 17.675C7.875 19.225 9.76667 20 12 20Z" fill="#EF3333"/>
					</svg>
					
					<div class="logout-items">
						<img class="logout-image" src="${pageContext.request.contextPath}/resources/images/logout-image.png">
						
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