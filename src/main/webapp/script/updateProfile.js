function toggleUpdateProfileOverlay(){
	const updateProfileElement = document.querySelector(".update-profile-overlay");
	const container = document.querySelector(".update-profile-container");
	const mobileNavOverlayElement = document.querySelector(".mobile-nav-overlay");
	//mobileNavOverlayElement.style.display = "none"; // Always hide mobile nav when profile appears

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