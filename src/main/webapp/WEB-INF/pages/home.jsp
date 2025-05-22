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
		<link rel="stylesheet" href="${contextPath}/css/logout.css?v=${System.currentTimeMillis()}" />
		<link rel="stylesheet" href="${contextPath}/css/footer.css?v=${System.currentTimeMillis()}" />
		<link rel="stylesheet" href="${contextPath}/css/updateProfile.css?v=${System.currentTimeMillis()}" />
	</head>

	<body>
		<c:if test="${not empty searchFilter}">
		    <script>
		        window.addEventListener('DOMContentLoaded', function() {
		        	const OFFSET_TOP = 100;
		        	const marker = document.querySelector('.scroll-marker');

		        	if (marker) {
		        	  const markerTop = marker.getBoundingClientRect().top + window.scrollY;
		        	  window.scrollTo({
		        	    top: markerTop - OFFSET_TOP,
		        	    behavior: 'smooth'
		        	  });
		        	}
		        });
		    </script>
		</c:if>
		<main class="main">
			<section class="home-nav">
				<h2 class="nav-title">Occasio</h2>
				<div class="nav-buttonbar">
					<a class="nav-button" style="color: rgba(246, 94, 44, 1)" href="${contextPath}/home">
						Home
					</a>
					<a class="nav-button" href="${contextPath}/myEvents">
						My Events
					</a>
					<a class="nav-button" href="${contextPath}/aboutUs">
						About Us
					</a>
				</div>
				<div class="nav-user-section">
					<div class="nav-user-profile-picture">
						<img class="nav-user-profile-picture-img" src="${contextPath}/${not empty userProfileImgUrl ? userProfileImgUrl : 'resources/images/default-profile.png'}" alt="User Pfp">
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
			
			
			<div class = "my-events-landing">
				<div style="display: flex; flex-direction: column; align-items: center; justify-content: center;">
					<h1 class="my-events-landing-header">Organize. Engage. Enjoy.</h1>
					<svg style="margin-top: -50px; margin-bottom: 20px; z-index: 10;" width="580" height="69" viewBox="0 0 580 69" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M247.986 40.2221C252.343 40.5474 256.654 40.9976 260.957 41.4915C265.799 42.0471 270.632 42.6578 275.502 43.2034C280.338 43.7451 285.209 44.2222 290.158 44.516C291.08 44.5707 292.005 44.6192 292.932 44.6604C296.905 44.8372 300.913 44.9313 304.925 44.9882C309.058 45.047 313.211 45.0692 317.349 45.0852C321.484 45.1012 325.617 45.1114 329.738 45.1471C333.865 45.1828 337.98 45.2439 342.078 45.3622C344.933 45.4446 347.779 45.5547 350.615 45.7033C351.865 45.7689 353.114 45.8332 354.363 45.896C358.447 46.1013 362.53 46.29 366.611 46.4537C370.7 46.6173 374.73 46.7556 378.829 46.8607C384.558 47.0047 390.347 47.2491 396.015 47.5199C399.947 47.7074 403.86 47.908 407.755 48.0997C409.498 48.1854 411.238 48.2694 412.975 48.3497C418.597 48.6095 424.189 48.8306 429.755 48.9482C435.322 49.0656 440.863 49.0797 446.379 48.9239C451.892 48.7683 457.38 48.4428 462.831 47.8804C463.166 47.8458 463.502 47.8103 463.837 47.7738C468.991 47.209 473.899 46.4786 479.029 45.4246C483.974 44.4023 488.754 43.273 493.606 41.9618C498.433 40.6577 503.224 39.2013 507.969 37.5884C511.295 36.458 514.597 35.2507 517.872 33.9661C519.271 33.4174 520.665 32.8545 522.055 32.2772C526.695 30.349 531.28 28.2609 535.794 26.0144C540.31 23.7673 544.755 21.3623 549.119 18.8028C550.183 18.1787 551.239 17.5471 552.294 16.9044C555.573 14.9053 558.775 12.8402 561.962 10.6623C561.962 10.6623 561.962 10.6621 561.962 10.6622C562.886 10.0318 563.786 9.38119 564.702 8.70967C565.257 8.30225 565.813 7.8902 566.372 7.47789C566.731 7.21305 567.091 6.94758 567.452 6.68329C568.375 6.00728 569.309 5.33547 570.26 4.68307C571.211 4.03065 572.18 3.39711 573.176 2.80152C574.172 2.20571 575.193 1.64789 576.25 1.15388C576.616 0.983172 576.988 0.819069 577.362 0.665214C577.923 0.434494 578.511 0.324602 578.975 0.358824C579.442 0.392281 579.743 0.559806 579.827 0.806607C579.911 1.05482 579.777 1.36535 579.48 1.68927C579.183 2.01237 578.746 2.32685 578.26 2.58879C577.936 2.76216 577.615 2.94508 577.299 3.13428C576.379 3.68453 575.486 4.29639 574.611 4.94842C573.736 5.60021 572.88 6.29202 572.033 7.00787C571.186 7.72373 570.35 8.46404 569.512 9.21701C569.156 9.53668 568.8 9.85904 568.442 10.1829C567.958 10.6213 567.472 11.0625 566.981 11.5045C566.134 12.2674 565.244 13.0557 564.353 13.8037C562.071 15.7228 559.724 17.6163 557.338 19.4619C556.1 19.0186 554.792 18.9425 552.99 19.7268C552.275 20.0383 551.37 20.5484 550.635 21.1101C550.425 21.271 550.229 21.436 550.056 21.6019C549.358 22.2707 548.928 22.9261 548.515 23.5497C548.084 24.2015 547.672 24.8193 546.986 25.3727C545.822 26.3113 544.854 27.4339 543.82 28.6076C543.444 29.0345 543.059 29.468 542.653 29.9013C541.513 30.6435 540.367 31.3751 539.214 32.0969C536.444 33.8294 533.635 35.5022 530.787 37.1142C529.14 37.8209 527.625 38.4605 526.387 39.1035C526.09 39.2582 525.804 39.4211 525.528 39.5908C524.775 40.0541 524.091 40.5689 523.418 41.1064C522.78 41.437 522.141 41.7646 521.499 42.0893C518.244 43.7368 514.944 45.307 511.606 46.7996C510.701 47.2047 509.791 47.6045 508.88 47.9981C505.389 49.0163 501.728 50.0412 497.008 51.4411C496.899 51.4732 496.791 51.5049 496.682 51.5362C494.754 52.0928 492.821 52.5342 490.958 52.9374C488.046 53.5683 485.283 54.1111 482.974 54.8698C482.503 55.0246 482.019 55.1569 481.526 55.2731C480.392 55.5401 479.205 55.7189 478.011 55.8849C475.708 56.2062 473.386 56.4767 471.404 57.2668C470.158 57.7641 469.02 58.2832 467.959 58.7561C466.762 59.2897 465.664 59.7642 464.626 60.0757C464.201 60.2032 463.786 60.3034 463.379 60.3689C460.749 60.7913 458.502 61.3981 456.511 61.912C454.119 62.5289 452.097 63.0108 450.278 62.8307C450.003 62.8033 449.686 62.7624 449.331 62.7148C448.762 62.6385 448.089 62.5463 447.311 62.4704C445.532 62.2968 443.209 62.2089 440.292 62.5792C438.799 62.7686 437.404 63.1402 436.034 63.4972C434.041 64.0167 432.097 64.5053 430.007 64.3415C430.004 64.3414 430.002 64.3412 430 64.341C429.69 64.3153 429.365 64.1974 429.07 64.0893C428.692 63.9509 428.362 63.8295 428.169 63.9409C427.602 64.2675 426.699 64.6303 425.717 65.0214C424.996 65.3088 424.23 65.6118 423.524 65.9281C419.919 66.0552 416.326 66.1434 412.745 66.2087C410.961 66.2413 409.18 66.2682 407.403 66.2914C404.954 66.3235 402.51 66.3487 400.074 66.3721C398.837 65.8668 397.574 65.4086 396.237 65.0555C396.062 65.0092 395.881 64.9658 395.696 64.925C394.029 64.5593 391.93 64.3996 389.305 64.2087C387.156 64.053 384.677 63.876 381.773 63.561C380.794 63.4549 379.808 63.3737 378.829 63.3146C374.375 63.0501 370.045 63.1257 367.1 63.3201C366.839 63.3373 366.578 63.3549 366.315 63.3729C365.806 63.4075 365.289 63.4436 364.748 63.4814C362.156 63.6608 359.027 63.8739 353.802 64.0221C352.75 64.0516 351.612 64.0782 350.377 64.1006C347.11 64.1598 344.077 64.1548 341.32 64.1207C338.196 64.082 335.427 64.0059 333.074 63.9388C331.479 63.8933 330.075 63.8514 328.881 63.8271C328.382 63.817 327.92 63.81 327.496 63.807C325.032 63.7899 322.01 63.7335 318.981 63.6758C318.141 63.6598 317.3 63.6438 316.47 63.6285C312.616 63.5576 309.003 63.5059 306.784 63.5526C305.931 63.5704 305.039 63.5987 304.087 63.6299C303.967 63.6339 303.847 63.6378 303.725 63.6418C300.703 63.7405 297.062 63.8653 292.026 63.8066C291.052 63.7951 290.146 63.7766 289.296 63.7515C285.528 63.6399 282.836 63.3982 280.063 63.0558C278.681 62.885 277.477 62.4159 276.237 61.9297C275.689 61.7148 275.134 61.4966 274.553 61.2995C273.268 60.8639 271.856 60.5316 270.108 60.5619C269.516 60.5722 268.881 60.6335 268.216 60.6972C266.995 60.8142 265.672 60.9389 264.335 60.7664C263.869 60.7062 263.464 60.5695 263.067 60.4352C262.63 60.2875 262.201 60.1428 261.708 60.104C261.031 60.0508 260.36 60.0042 259.703 59.962C258.571 59.8892 257.48 59.8295 256.468 59.7721C254.407 59.6554 252.676 59.5474 251.612 59.3654C249.714 59.0411 247.612 59.0201 245.478 58.9865C245.242 58.9828 245.006 58.9789 244.769 58.9745C243.373 58.9485 241.972 58.9024 240.618 58.7488C237.618 58.4085 233.854 58.1239 229.761 57.8494C227.685 57.7104 225.525 57.5743 223.337 57.4381C220.869 57.2825 218.809 56.7227 216.246 55.9879C215.787 55.8561 215.311 55.7183 214.813 55.5755C213.579 55.2217 212.197 54.8359 210.571 54.4295C209.278 54.1062 208.128 54.129 207.071 54.1487C206.097 54.1666 205.197 54.1806 204.325 53.9146C203.556 53.6797 203.132 53.2118 202.73 52.7675C202.5 52.5133 202.277 52.2667 202.001 52.0755C201.741 51.8946 201.433 51.7632 201.028 51.7213C200.584 51.6754 200.017 51.7592 199.343 51.8577C199.077 51.8967 198.792 51.9374 198.493 51.9741C198.522 51.9012 198.539 51.8342 198.549 51.783C198.621 51.4211 197.824 51.0667 197.043 50.718C196.731 50.5789 196.421 50.4408 196.171 50.3038C195.25 49.7999 193.406 49.379 191.988 49.1096C191.388 48.9956 190.869 48.7748 190.263 48.5171C190.016 48.4119 189.754 48.3004 189.467 48.1877C189.129 48.0554 188.757 47.9213 188.33 47.7931C187.879 47.6577 187.548 47.4824 187.274 47.3367C187.076 47.2312 186.907 47.1413 186.743 47.0939C186.602 47.0529 186.465 47.1334 186.311 47.2242C186.2 47.2896 186.079 47.3603 185.942 47.3948C185.613 47.4772 185.219 47.4435 184.958 47.3443C184.837 47.2984 184.747 47.2385 184.657 47.179C184.552 47.1096 184.448 47.04 184.294 46.9926C183.592 46.7752 182.87 46.7564 182.122 46.7379C181.3 46.7177 180.443 46.6972 179.541 46.4154C179.257 46.3267 178.962 46.1919 178.677 46.0614C178.378 45.9248 178.088 45.7929 177.832 45.7242C177.495 45.6335 177.158 45.5804 176.824 45.5524C176.131 45.4945 175.451 45.5451 174.81 45.5942C174.178 45.6426 173.582 45.6893 173.049 45.6291C172.071 45.5189 171.497 45.7406 171.076 45.9043C170.857 45.9892 170.679 46.0593 170.504 46.0597C170.351 46.0243 170.195 45.9869 170.044 45.9493C169.906 45.9021 169.764 45.8535 169.626 45.8377C169.616 45.8365 169.605 45.8361 169.595 45.835C168.746 45.6128 167.918 45.3646 167.095 45.121C166.095 44.8251 165.101 44.5357 164.084 44.3094C163.22 44.1172 162.339 43.9704 161.426 43.9041C160.998 43.8731 160.547 43.9424 160.09 44.0141C159.53 44.1021 158.959 44.194 158.401 44.1097C157.071 43.9089 155.751 43.5324 154.448 43.1741C153.486 42.9097 152.534 42.6552 151.596 42.4876C150.621 42.3134 149.666 42.2335 148.737 42.3332C148.136 42.3979 147.546 42.5417 146.955 42.6898C146.626 42.7724 146.295 42.8566 145.967 42.9284C146.046 42.7601 146.094 42.6003 146.138 42.4512C146.229 42.1441 146.307 41.881 146.638 41.676C147.419 41.1912 148.324 40.5205 148.272 39.9757C148.258 39.8279 148.291 39.667 148.327 39.5051C148.416 39.0994 148.508 38.6838 147.818 38.4412C147.355 38.2771 146.151 37.8984 145.361 38.1671C145.189 38.2254 145.078 38.3551 144.956 38.4993C144.737 38.7587 144.476 39.0648 143.747 39.1016C143.624 39.1079 143.49 39.1125 143.352 39.1163C142.802 39.1312 142.183 39.1513 141.944 39.3602C141.669 39.6007 141.716 39.8908 141.77 40.229C141.841 40.6697 141.922 41.1921 141.336 41.796C141.22 41.9154 141.004 41.95 140.842 41.9765C140.727 41.9952 140.639 42.0105 140.629 42.0474C140.618 42.0898 140.652 42.18 140.695 42.2941C140.846 42.6975 141.11 43.3985 139.924 43.3912C139.659 43.39 139.362 43.3607 139.079 43.3296C139.018 43.323 138.958 43.3163 138.9 43.3097C138.405 43.2543 137.996 43.21 137.938 43.3225C137.917 43.3652 137.901 43.4116 137.888 43.4597C137.495 43.4384 137.103 43.418 136.712 43.3984C136.212 43.2554 135.508 43.2576 134.635 43.2658C134.423 43.2678 134.198 43.2697 133.966 43.2704C133.198 43.2382 132.433 43.2094 131.671 43.1831C131.067 43.1275 130.428 43.0378 129.748 42.896C128.387 42.6121 127.199 42.1425 126.027 41.6898C125.534 41.4991 125.039 41.3112 124.538 41.1424C124.731 41.1143 124.904 41.083 125.037 41.0427C125.95 40.7679 126.302 40.2678 126.633 39.8066C126.852 39.5001 127.059 39.2111 127.409 39.021C128.051 38.6731 127.981 38.2812 127.929 37.9909C127.902 37.8404 127.882 37.7171 127.967 37.6423C128.036 37.5823 128.197 37.5521 128.364 37.521C128.509 37.4939 128.658 37.4657 128.754 37.417C129.915 36.8268 129.565 36.4969 129.047 36.016C128.761 35.751 128.427 35.4407 128.269 35.0157C128.132 34.5653 128.174 34.4317 128.792 34.2432C128.306 34.026 127.82 33.81 127.333 33.5953C127.143 33.6133 127.001 33.7557 126.804 33.9919C126.451 34.4131 125.286 34.5904 124.372 34.7357C123.95 34.8027 123.583 34.8622 123.377 34.9324C122.282 35.3071 122.622 35.7674 122.918 36.1715C123.081 36.3941 123.23 36.6003 123.124 36.7662C123.079 36.8372 123.149 36.9037 123.22 36.9717C123.274 37.0242 123.33 37.0777 123.334 37.1344C123.362 37.5462 122.724 37.8733 122.135 38.1799C121.798 38.3553 121.478 38.5243 121.304 38.6961C121.251 38.7484 121.209 38.8013 121.17 38.8526C121.114 38.9275 121.058 38.9989 120.969 39.0619C120.766 39.2053 120.341 39.3143 119.876 39.4347C119.637 39.4965 119.389 39.5613 119.154 39.6351C118.851 39.7308 118.748 39.8994 118.64 40.0754C118.564 40.1999 118.484 40.3281 118.33 40.4384C118.053 40.6376 117.477 40.7348 116.944 40.8271C116.712 40.8672 116.486 40.9072 116.297 40.9529C116.221 40.9715 116.185 41.0018 116.179 41.0407C115.984 41.0811 115.791 41.1217 115.6 41.1626C114.934 41.3049 114.291 41.4493 113.663 41.5932C109.605 42.5301 106.141 43.389 100.838 43.5954C99.8355 43.636 98.7691 43.7831 97.6996 43.9843C95.9105 44.1327 94.1209 44.2981 92.3322 44.4806C90.658 44.6512 88.98 44.8376 87.3076 45.0384C86.5668 44.7875 85.6805 44.6243 84.6518 44.5606C82.7197 44.4418 80.795 44.7065 78.5305 45.049C76.8559 45.3029 74.9944 45.5997 72.7943 45.832C71.4387 45.9754 70.0716 46.1408 68.6768 46.3389C66.2689 46.6809 63.7771 47.1196 61.1211 47.7165C56.9447 48.6487 52.207 49.9279 48.8918 50.9464C47.8053 51.2781 46.6565 51.5217 45.5091 51.7312C44.7442 51.8709 43.9799 51.9954 43.2368 52.1196C40.6307 52.553 38.2788 52.9891 37.1338 54.0135C36.7672 54.341 36.4621 54.7888 36.1665 55.2244C35.956 55.5347 35.7484 55.839 35.528 56.0907C34.7753 56.3216 34.0266 56.5548 33.2757 56.7911C31.8385 56.9399 29.6635 57.3596 27.877 58.5418C27.1056 58.7996 26.3332 59.0617 25.591 59.3138C24.7926 59.5875 24.0024 59.8612 23.2147 60.1371C22.4024 60.4217 21.5981 60.7064 20.7891 60.9967C20.2684 61.183 19.7427 61.373 19.2157 61.565C19.2107 61.5668 19.2056 61.5685 19.2006 61.5703C18.1376 61.9578 17.075 62.3512 16.0271 62.7439C15.5785 62.9121 15.1299 63.0815 14.6813 63.252C13.5382 63.6869 12.4002 64.1268 11.2744 64.5673C10.6791 64.7999 10.0785 65.0375 9.47662 65.277C8.50411 65.6637 7.52492 66.0587 6.55006 66.4565C4.96853 67.1024 3.414 67.7475 1.84578 68.4123C1.58956 68.5206 1.32353 68.5864 1.10553 68.5914C0.887577 68.5961 0.734308 68.5407 0.678524 68.431C0.622302 68.3215 0.667069 68.1638 0.799131 67.9893C0.931267 67.8152 1.14126 67.6388 1.3801 67.495C2.84544 66.615 4.30203 65.7546 5.78926 64.8944C6.70528 64.3643 7.62628 63.8366 8.54325 63.3181C9.11106 62.9971 9.67785 62.6796 10.2402 62.3659C11.3038 61.7729 12.3836 61.1798 13.4691 60.593C13.8949 60.3626 14.3209 60.1332 14.7473 59.9048C15.7457 59.37 16.7613 58.8348 17.7788 58.3057C17.7849 58.3025 17.7911 58.2993 17.7972 58.2962C18.2968 58.0364 18.7958 57.7783 19.29 57.5244C20.0603 57.1293 20.8271 56.7398 21.603 56.3505C22.3628 55.9693 23.1261 55.5905 23.899 55.2119C24.7026 54.8154 25.5495 54.4065 26.3885 54.005C26.8559 53.7812 27.3227 53.559 27.7813 53.3418C28.0321 53.2235 28.2867 53.1042 28.5427 52.9848C33.5378 50.6431 38.5847 48.4503 43.7264 46.401C44.6352 46.0388 45.5441 45.6821 46.461 45.3284C52.5344 42.9828 58.7135 40.8487 64.9585 38.9474C65.5569 38.7653 66.1558 38.5853 66.7554 38.4074C72.4292 36.7245 78.1609 35.2318 83.9505 33.933C86.1359 33.4426 88.3326 32.9789 90.5327 32.5432C98.5563 30.9546 106.672 29.7336 114.843 28.8849C122.961 28.0368 131.323 27.5596 139.455 27.4439C143.889 27.3782 148.56 27.5123 153.014 27.7861C157.509 28.0617 161.976 28.4853 166.406 29.01C170.834 29.5345 175.224 30.1596 179.575 30.8365C183.925 31.5133 188.237 32.2417 192.515 32.9748C196.793 33.708 201.037 34.4457 205.253 35.1443C206.275 35.3137 207.293 35.4805 208.313 35.6449C211.487 36.1563 214.593 36.6322 217.822 37.0858C220.395 37.4468 222.91 37.7706 225.404 38.0685C227.639 38.3361 229.868 38.5843 232.095 38.8158C235.562 39.1761 239.033 39.4978 242.561 39.7931C243.845 39.8999 245.154 40.0051 246.489 40.1082C246.984 40.1464 247.483 40.1844 247.986 40.2221Z" fill="#F65E2C"/>
					</svg>
					<p style="text-align: center; max-width: 580px; font-family: Poppins-Regular;">Ready to host your own event?</p>
					<p style="text-align: center; max-width: 580px; font-family: Poppins-Regular; margin-bottom: 30px;">Create and manage your events with ease. Invite others, track participation, and stay organized all with Occasio</p>
					<a class="my-events-landing-redirect-button" href="${contextPath}/myEvents">
						My Events
					</a>
				</div>
			</div>
			
			<div class="scroll-indicator">
				<svg class="scroll-icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-down-icon lucide-chevron-down"><path d="m6 9 6 6 6-6"/></svg>
			</div>
			
			<div class="scroll-marker" id="#ongoing-events" style="height: 1px; margin: 0;"></div>
			<form class="event-search-bar-form" action="${contextPath}/home?action=search" method="post">
				<div class="event-search-bar">
					<input class="search-bar-input" type="text" name="searchText" placeholder="Search for college events" value="${searchFilter}"/>
					<button class="search-button" type="submit">
						<svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M19.5 19L15.15 14.65M17.5 9C17.5 13.4183 13.9183 17 9.5 17C5.08172 17 1.5 13.4183 1.5 9C1.5 4.58172 5.08172 1 9.5 1C13.9183 1 17.5 4.58172 17.5 9Z" stroke="#F65E2C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
						</svg>
					</button>
				</div>	
			</form>
			
			<section class="ongoing-events">
				<h3 class="event-section-title">Ongoing Events</h3>
				
				<c:if test="${not empty ongoingEvents}">
					<div class="events-card-container">
						<c:forEach var="event" items="${ongoingEvents}">
							<div class = "ongoing-events-card">
								<img src="${contextPath}/${not empty event.imagePath ? event.imagePath : '/resources/images/event-default.png'}" class="ongoing-events-cover"/>
								<div class="ongoing-events-card-details">
									<div class="ongoing-events-card-details-title">
										<h4 class="event-card-title" style="font-size: 16px">${event.name}</h4>
										<span class="view-event-details-link" onClick="window.location.href='${contextPath}/event?action=fetchEventData&eventId=${event.id}&userId=${userId}'">
											View Details
										</span>
									</div>
									
									<div class="ongoing-events-card-info">
										<div class="ongoing-events-card-info-child">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-calendar-days-icon lucide-calendar-days"><path d="M8 2v4"/><path d="M16 2v4"/><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M3 10h18"/><path d="M8 14h.01"/><path d="M12 14h.01"/><path d="M16 14h.01"/><path d="M8 18h.01"/><path d="M12 18h.01"/><path d="M16 18h.01"/></svg>
											<span class="event-card-time-label">${event.startDate} - ${event.endDate}</span>
										</div>
										<div class="ongoing-events-card-info-child">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
											<span class="event-card-location-label">${event.location}</span>
										</div>
									</div>
									
									<div class="event-card-interested">
										<div class="interested-counts" >
											<c:if test="${not empty event.interestedUsers.interestedUsersPicturePaths}">
												<div class = "interested-user-images">
													<c:forEach var="imagePath" items="${event.interestedUsers.interestedUsersPicturePaths}" varStatus="status">
													    <c:if test="${status.index < 3}">
													        <img src="${contextPath}/${not empty imagePath ? imagePath : 'resources/images/default-profile.png'}" class="interested-user-${status.index + 1}">
													    </c:if>
													</c:forEach>
												</div>
											</c:if>
											
											<c:choose>
												<c:when test="${event.interestedUsers.totalInterestedCount > 3}">
													<div class="total-interests">+ ${event.interestedUsers.totalInterestedCount - 3} others are interested</div>
												</c:when>
												
												<c:when test="${event.interestedUsers.totalInterestedCount == 0}">
													<div class="total-interests">No one interested so far</div>
												</c:when>
												
												<c:when test="${event.interestedUsers.totalInterestedCount <= 3}">
													<div class="total-interests"> are interested</div>
												</c:when>
											</c:choose>								
										</div>
										<div class="">
											<c:choose>
												<c:when test="${event.interested}">
													<button class="interested-button">
														<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-check-icon lucide-check"><path d="M20 6 9 17l-5-5"/></svg>
														Interested
													</button>
												</c:when>
												<c:otherwise>
													<button class="show-interest-button">
														Confirm Interest
													</button>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>
				
				<c:if test="${empty ongoingEvents}">
					<section class="empty-user-events">
						<div class="empty-user-events-search-icon-container">
							<svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path d="M19.5 19L15.15 14.65M17.5 9C17.5 13.4183 13.9183 17 9.5 17C5.08172 17 1.5 13.4183 1.5 9C1.5 4.58172 5.08172 1 9.5 1C13.9183 1 17.5 4.58172 17.5 9Z" stroke="#F65E2C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
							</svg>
						</div>
						
						<div class="empty-user-events-text-details">
							<h4 class="empty-user-events-text-details-title">No Events Found</h4>
							<p class="empty-user-events-text-details-desc">No Ongoing Events Currently!</p>
						</div>
					</section>
				</c:if>		
			</section>
			
			<section class="upcoming-events">
				<h3 class="event-section-title">Upcoming Events</h3>
				
				<c:if test="${not empty upcomingEvents}">
					<div class="events-card-container">
						<c:forEach var="event" items="${upcomingEvents}">
							<div class="upcoming-events-card">
								<img src="${contextPath}/${not empty event.imagePath ? event.imagePath : '/resources/images/event-default.png'}" class="upcoming-events-card-cover">
								<div class = "upcoming-events-card-details">
									<h3 class="upcoming-events-card-details-title">${event.name}</h3>
									<div class="upcoming-events-card-info">
										<div class="upcoming-events-card-info-child">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-calendar-days-icon lucide-calendar-days"><path d="M8 2v4"/><path d="M16 2v4"/><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M3 10h18"/><path d="M8 14h.01"/><path d="M12 14h.01"/><path d="M16 14h.01"/><path d="M8 18h.01"/><path d="M12 18h.01"/><path d="M16 18h.01"/></svg>
											<span class="event-card-time-label">${event.startDate} - ${event.endDate}</span>
										</div>
										<div class="upcoming-events-card-info-child">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
											<span class="event-card-location-label">${event.location}</span>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>
				
				<c:if test="${empty upcomingEvents}">
					<section class="empty-user-events">
						<div class="empty-user-events-search-icon-container">
							<svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path d="M19.5 19L15.15 14.65M17.5 9C17.5 13.4183 13.9183 17 9.5 17C5.08172 17 1.5 13.4183 1.5 9C1.5 4.58172 5.08172 1 9.5 1C13.9183 1 17.5 4.58172 17.5 9Z" stroke="#F65E2C" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
							</svg>
						</div>
						
						<div class="empty-user-events-text-details">
							<h4 class="empty-user-events-text-details-title">No Events Found</h4>
							<p class="empty-user-events-text-details-desc">No Upcoming Events for the future!</p>
						</div>
					</section>
				</c:if>
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
		
		<footer class = " footer-main">
           <div class = footer-content>
               <div class = "footer-heading">
                   <span class = " footer-occasio"> Occasio</span>
                   <p class= footer-text>Organize.</p>
                   <p class= footer-text>Engage. Enjoy.</p>
                   <p class = footer-text>With Occasio.</p>
                   <div class = footer-mail>
                       <p class = footer-mail-content>Occasio@gmail.com</p>
                       <p class = footer-mail-content>Islington,Nepal</p>
                   </div>
               </div>
               <div class = "footer-nav-main">
                   <div class = "footer-nav">
                       <a class= "nav-button1" href="${contextPath}/home">Home</a>
                       <a class = "nav-button1" href="${contextPath}/myEvents">My Events</a>
                       <a class = "nav-button1" href="${contextPath}/aboutUs">About Us</a>
                       <p class= " copyright"> @Copyright2025. All Rights Reserved</p>
                   </div>
               </div>
               <div class = footer-student-name-main>
                   <div class = footer-student-name>
                       <p class = "name-of-student">Shreejesh Pathak</p>
                       <p class = "name-of-student">Srijan Shrestha</p>
                       <p class = "name-of-student">Aayush Karki</p>
                       <p class = "name-of-student">Arpit Neupane</p>
                       <p class = "name-of-student">Paras Kumar Yadav</p>
                   </div>
               </div>
           </div>
		</footer>
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
			mobileNavOverlayElement.style.display = "none"; // Always hide mobile nav when profile appears

			if(updateProfileElement.style.visibility == "visible"){
				container.classList.remove('active');
				setTimeout(() => {
					updateProfileElement.style.visibility = "hidden";
				}, 400);
			} else {
				// Added logic to reset image on open
				const profileImage = updateProfileElement.querySelector('.user-profile');
                const fileInput = document.getElementById('profilePictureUpload');
				if (profileImage) {
					const originalSrc = profileImage.getAttribute('data-original-src');
					if (originalSrc) {
						profileImage.src = originalSrc;
					}
				}
                if(fileInput) {
                    fileInput.value = "";
                }

				updateProfileElement.style.visibility = "visible";
                setTimeout(() => {
                    container.classList.add('active');
                }, 10);
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
		
		function previewProfilePicture(event) {
            const file = event.target.files[0];
            const imagePreview = document.querySelector('.update-profile-overlay .user-profile');

            if (file && imagePreview) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    imagePreview.src = e.target.result;
                }

                reader.readAsDataURL(file);
            }
        }
		
		const OFFSET_TOP = 100;
		let hasUserScrolled = false;

		window.addEventListener('scroll', () => {
		  hasUserScrolled = true;
		}, { once: true }); // only need to detect first scroll

		const markers = document.querySelectorAll('.scroll-marker');

		const observer = new IntersectionObserver((entries) => {
		  if (!hasUserScrolled) return; // skip auto scroll on page load

		  entries.forEach(entry => {
		    if (entry.isIntersecting) {
		      const markerTop = entry.target.getBoundingClientRect().top + window.scrollY;
		      window.scrollTo({
		        top: markerTop - OFFSET_TOP,
		        behavior: 'smooth'
		      });
		    }
		  });
		}, {
		  threshold: 0.01
		});

		markers.forEach(marker => observer.observe(marker));

		
	</script>
</html>