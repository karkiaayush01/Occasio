package com.occasio.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

//import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;  
import java.nio.file.Paths; 
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.occasio.model.UserModel;
import com.occasio.service.RegisterService;
import com.occasio.util.ImageUtil;

/**
 * Servlet implementation class RegisterController
 */
@WebServlet("/register")
@MultipartConfig
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	RegisterService registerService = new RegisterService();
	private final ImageUtil imageUtil = new ImageUtil();
	
	private static final String PROFILE_PIC_SUBFOLDER = "profile_pics";
	
	private static final String IMAGE_BASE_WEB_PATH = "resources/images";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/register.jsp");
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Hello");
		String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        LocalDate dateJoined = LocalDate.now();
        String phoneNumber = request.getParameter("phoneNumber");
        String profilePictureDbPath = null;
        String uploadedImageName = null;
        String orgIdStr = request.getParameter("orgId");

        Map<String, String> errors = new HashMap<>();
        
        ServletContext context = request.getServletContext();
        
        String realUploadPathBase = getServletContext().getRealPath(PROFILE_PIC_SUBFOLDER);
        System.out.println("***** ABSOLUTE IMAGE SAVE PATH on Server: " + realUploadPathBase + " *****");
        if (realUploadPathBase == null) {
            System.err.println("FATAL ERROR: Could not get real path for " + PROFILE_PIC_SUBFOLDER + ". Is the WAR deployed exploded? Check server configuration.");
            errors.put("config", "Server configuration error determining image upload path.");
            
            request.setAttribute("errors", errors);
            
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("orgId", orgIdStr);
            request.setAttribute("phoneNumber", phoneNumber);
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }
        System.out.println("Attempting to save images to real path: " + realUploadPathBase);

        
     // --- Handle Image Upload ---
     		try {
     			Part filePart = request.getPart("profilePicture");
                 // Use the new ImageUtil to get the filename
                 uploadedImageName = imageUtil.getImageNameFromPart(filePart);

                 // Check if a file was actually uploaded (size > 0) and has a valid name
                 if (filePart != null && filePart.getSize() > 0 && uploadedImageName != null && !uploadedImageName.isEmpty() && !uploadedImageName.equals("")) {

                     // Use the new ImageUtil to upload the file
                     // The rootPath argument isn't used by the provided uploadImage, pass null or empty
                     boolean uploaded = imageUtil.uploadImage(filePart, context, PROFILE_PIC_SUBFOLDER);

                     if (uploaded) {
                         // Construct the relative path for DB storage and web access
                         // Assumes files are served from webapp/resources/images/
                         profilePictureDbPath = IMAGE_BASE_WEB_PATH + "/" + PROFILE_PIC_SUBFOLDER + "/" + uploadedImageName;
                         profilePictureDbPath = profilePictureDbPath.replace("\\", "/"); // Ensure forward slashes

                         System.out.println("Profile picture upload successful. DB path: " + profilePictureDbPath);
                     } else {
                         errors.put("profilePicture", "Could not save profile picture.");
                         System.err.println("ImageUtil.uploadImage failed for: " + uploadedImageName);
                         uploadedImageName = null; // Nullify name if upload failed
                     }
                 } else {
                     System.out.println("No profile picture uploaded or file was empty/default name.");
                     uploadedImageName = null; // No valid image uploaded
                 }

     		} catch (IOException | ServletException e) {
     			System.err.println("Error processing uploaded file part: " + e.getMessage());
     			errors.put("profilePicture", "Error processing uploaded file.");
     			e.printStackTrace();
                 uploadedImageName = null; // Nullify name on exception
     		}
     		// --- End Image Upload Handling ---
        
        
        

        // --- Validation Checks ---
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.put("fullName", "Full Name is required.");
            System.out.println("fullname");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email is required.");
            System.out.println("email 1");
        } else if (!isValidEmail(email)) {
            errors.put("email", "Invalid email format.");
            System.out.println("email 2");
        }

        if (password == null || password.isEmpty()) {
            errors.put("password", "Password is required.");
            System.out.println("p 1");
        } else if (password.length() < 8) {
            errors.put("password", "Password must be at least 8 characters long.");
            System.out.println("p 2");
        }

        if (confirmPassword == null || confirmPassword.isEmpty()) {
            errors.put("confirmPassword", "Confirm Password is required.");
            System.out.println("cp 1");
        } else if (password == null || !password.equals(confirmPassword)) {
            errors.put("confirmPassword", "Passwords do not match.");
            System.out.println("cp 2");
        }

        if (role == null || role.trim().isEmpty()) {
            errors.put("role", "Role is required.");
            System.out.println("r");
        }

        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            errors.put("phoneNumber", "Phone Number is required.");
            System.out.println("ph 1");
        } else if (!isValidPhoneNumber(phoneNumber)) {
            errors.put("phoneNumber", "Invalid phone number format.");
            System.out.println("ph 2");
        }

        if (orgIdStr == null || orgIdStr.trim().isEmpty()) {
            errors.put("orgId", "Organization ID is required.");
            System.out.println("o 1");
        } else if (!orgIdStr.matches("\\d+")) {
            errors.put("orgId", "Organization ID must be a number.");
            System.out.println("o 2");
        }

        // If there are validation errors, forward back to the registration page
        if (!errors.isEmpty()) {
        	System.out.println("Validation Errors found, forwarding back to register page.");
        	deleteUploadedFileOnError(context, uploadedImageName);
        	
            request.setAttribute("errors", errors);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("role", role);
            request.setAttribute("dateJoined", dateJoined);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("orgId", orgIdStr);
            System.out.println("ERROR!!!");
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/register.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // If validation passes, create a UserModel and call the service
        UserModel user = new UserModel();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);
        user.setDateJoined(dateJoined);
        user.setPhoneNumber(phoneNumber);
        user.setProfilePicturePath(profilePictureDbPath);
        user.setOrgId(Integer.parseInt(orgIdStr));
        
        System.out.println("Entering register service: ");
        String registrationResult = registerService.addUser(user);

        if (registrationResult.startsWith("Successfully ")) {
            // Registration successful, redirect to a success page
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Registration failed, go back to the registration page with an error message
        	System.out.println("Registration failed via service: " + registrationResult);
            deleteUploadedFileOnError(context, uploadedImageName);
        
            request.setAttribute("registrationError", registrationResult);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("role", role);
            request.setAttribute("dateJoined", dateJoined);
            request.setAttribute("phoneNumber", phoneNumber);
//            request.setAttribute("profilePicturePath", profilePicturePath);
            request.setAttribute("orgId", orgIdStr);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/register.jsp");
            dispatcher.forward(request, response);
        }
    }
	
	/**
     * Attempts to delete an uploaded file if an error occurred after upload.
     * Uses the new ImageUtil to determine the path.
     * @param uploadedFileName The name of the file that was potentially uploaded.
     */
    private void deleteUploadedFileOnError(ServletContext context, String uploadedFileName) {
        if (uploadedFileName != null && !uploadedFileName.isEmpty()) {
            try {
                // Use the ImageUtil's path logic to find the file
                String savePath = imageUtil.getSavePath(context, PROFILE_PIC_SUBFOLDER);
                Path orphanPath = Paths.get(savePath, uploadedFileName);

                System.out.println("Error occurred after upload. Attempting to delete orphaned file: " + orphanPath);
                boolean deleted = Files.deleteIfExists(orphanPath);
                if (deleted) {
                    System.out.println("Successfully deleted orphaned file: " + orphanPath);
                } else {
                     System.out.println("Orphaned file not found or could not be deleted: " + orphanPath);
                }
            } catch (IOException ex) {
                System.err.println("IOException occurred while trying to delete orphaned file: " + uploadedFileName + " - " + ex.getMessage());
                ex.printStackTrace();
            } catch (Exception e) {
                 System.err.println("Unexpected error occurred while trying to delete orphaned file: " + uploadedFileName + " - " + e.getMessage());
                 e.printStackTrace();
            }
        }
    }

    private boolean isValidEmail(String email) {
        // Basic email validation regex
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    private boolean isValidPhoneNumber(String phoneNumber) {
        // Basic phone number validation regex (allows digits, spaces, hyphens, parentheses)
        String phoneRegex = "^[\\d\\s\\-\\(\\)]+$";
        Pattern pattern = Pattern.compile(phoneRegex);
        Matcher matcher = pattern.matcher(phoneNumber);
        return matcher.matches();
    }
}
