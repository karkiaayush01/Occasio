package com.occasio.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

// Import your specific classes
import com.occasio.model.UserModel;
import com.occasio.service.UserService;
import com.occasio.util.ImageUtil;
import com.occasio.util.SessionUtil;

@WebServlet("/userProfile")
@MultipartConfig // Crucial for file uploads
public class UserProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Instantiate your utility and service classes
    private final ImageUtil imageUtil = new ImageUtil();
    private final UserService userService = new UserService(); // Create this service class

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Get current user from session
        UserModel currentUser = (UserModel) SessionUtil.getAttribute(request, "user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=sessionExpired");
            return;
        }

        // 2. Retrieve standard form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String newPassword = request.getParameter("password"); // New password field

        // 3. Retrieve the file part
        Part profilePicturePart = request.getPart("profilePictureFile");

        // 4. Prepare user data object for update
        UserModel updatedUserData = new UserModel();
        updatedUserData.setUserId(currentUser.getUserId()); // Set ID to update correct user
        updatedUserData.setFullName(fullName);
        updatedUserData.setEmail(email);
        updatedUserData.setPhoneNumber(phoneNumber);
        updatedUserData.setOrgId(currentUser.getOrgId()); // Org ID doesn't change
        // Default to the current picture path initially
        updatedUserData.setProfilePicturePath(currentUser.getProfilePicturePath());

        // --- Image Upload Handling (Using your ImageUtil) ---
        String newRelativePath = null; // Store the path if upload is successful

        // Check if a file was actually uploaded
        if (profilePicturePart != null && profilePicturePart.getSize() > 0) {
            String originalFileName = imageUtil.getImageNameFromPart(profilePicturePart);

            // Check if a valid filename was extracted
            if (originalFileName != null && !originalFileName.isEmpty()) {
                String saveFolder = "profile_pics"; // Subfolder for profile pictures

                // Attempt to upload using your utility
                boolean uploadSuccess = imageUtil.uploadImage(profilePicturePart, getServletContext(), saveFolder);

                if (uploadSuccess) {
                	newRelativePath = "resources/images/profile_pics/" + originalFileName;
                    updatedUserData.setProfilePicturePath(newRelativePath); // Update path in the model
                    System.out.println("Profile picture uploaded successfully. Relative path: " + newRelativePath);

                    // IMPORTANT::     ##### need to implement file name generation ##########

                } else {
                    // Upload failed according to ImageUtil
                    System.err.println("ImageUtil reported upload failure for file: " + originalFileName);
                    // Redirect with an error message
                    response.sendRedirect(request.getContextPath() + "/home?profileUpdate=uploadError");
                    return; // Stop further processing
                }
            } else {
                 System.out.println("Profile picture Part received, but no filename found.");
                 // Decide if this is an error or just means no file was selected
            }
        } else {
             System.out.println("No new profile picture uploaded or Part is empty.");
        }
        // --- End Image Upload Handling ---


        // 5. Call Service Layer to update user data in the database
        try {
            // The service layer should handle password hashing if newPassword is provided
            boolean updateSuccess = userService.updateUserProfile(updatedUserData, newPassword);

            if (updateSuccess) {
                // 6. IMPORTANT: Update the user object in the session!
                currentUser.setFullName(updatedUserData.getFullName());
                currentUser.setEmail(updatedUserData.getEmail());
                currentUser.setPhoneNumber(updatedUserData.getPhoneNumber());
                // Only update the session path if a *new* relative path was determined
                if (newRelativePath != null) {
                    currentUser.setProfilePicturePath(newRelativePath);
                }
                SessionUtil.setAttribute(request, "user", currentUser); // Put updated user back in session

                // 7. Redirect back to home with success feedback
                response.sendRedirect(request.getContextPath() + "/home?profileUpdate=success");
            } else {
                System.out.println("Update failed.");
                response.sendRedirect(request.getContextPath() + "/home?profileUpdate=dbError");
            }
        } catch (Exception e) {
            // Log the exception for debugging
            e.printStackTrace();
            // Redirect with a generic error
            response.sendRedirect(request.getContextPath() + "/home?profileUpdate=error");
        }
    }
}