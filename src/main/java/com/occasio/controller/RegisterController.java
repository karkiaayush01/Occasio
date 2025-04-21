package com.occasio.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.occasio.model.UserModel;
import com.occasio.service.RegisterService;

/**
 * Servlet implementation class RegisterController
 */
@WebServlet("/register")
@MultipartConfig
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	RegisterService registerService = new RegisterService();
       
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
//        String profilePicturePath = request.getParameter("profilePicturePath");
        String orgIdStr = request.getParameter("orgId");

        Map<String, String> errors = new HashMap<>();

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
        } else if (!password.equals(confirmPassword)) {
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
            request.setAttribute("errors", errors);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("role", role);
            request.setAttribute("dateJoined", dateJoined);
            request.setAttribute("phoneNumber", phoneNumber);
//            request.setAttribute("profilePicturePath", profilePicturePath);
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
//        user.setProfilePicturePath(profilePicturePath);
        user.setOrgId(Integer.parseInt(orgIdStr));
        
        System.out.println("Entering register service: ");
        String registrationResult = registerService.addUser(user);

        if (registrationResult.startsWith("Successfully ")) {
            // Registration successful, redirect to a success page
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Registration failed, go back to the registration page with an error message
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
