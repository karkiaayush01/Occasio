package com.occasio.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
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
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private RegisterService registerService;

    @Override
    public void init() throws ServletException {
        super.init();
        registerService = new RegisterService();
    }
       
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
		String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        String dateJoined = request.getParameter("dateJoined");
        String phoneNumber = request.getParameter("phoneNumber");
        String profilePicturePath = request.getParameter("profilePicturePath");
        String orgIdStr = request.getParameter("orgId");

        Map<String, String> errors = new HashMap<>();

        // --- Validation Checks ---
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.put("fullName", "Full Name is required.");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email is required.");
        } else if (!isValidEmail(email)) {
            errors.put("email", "Invalid email format.");
        }

        if (password == null || password.isEmpty()) {
            errors.put("password", "Password is required.");
        } else if (password.length() < 8) {
            errors.put("password", "Password must be at least 8 characters long.");
        }

        if (confirmPassword == null || confirmPassword.isEmpty()) {
            errors.put("confirmPassword", "Confirm Password is required.");
        } else if (!password.equals(confirmPassword)) {
            errors.put("confirmPassword", "Passwords do not match.");
        }

        if (role == null || role.trim().isEmpty()) {
            errors.put("role", "Role is required.");
        }

        if (dateJoined == null || dateJoined.trim().isEmpty()) {
            errors.put("dateJoined", "Date Joined is required.");
        } else {
            try {
                LocalDate.parse(dateJoined);
            } catch (Exception e) {
                errors.put("dateJoined", "Invalid date format (YYYY-MM-DD).");
            }
        }

        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            errors.put("phoneNumber", "Phone Number is required.");
        } else if (!isValidPhoneNumber(phoneNumber)) {
            errors.put("phoneNumber", "Invalid phone number format.");
        }

        if (orgIdStr == null || orgIdStr.trim().isEmpty()) {
            errors.put("orgId", "Organization ID is required.");
        } else if (!orgIdStr.matches("\\d+")) {
            errors.put("orgId", "Organization ID must be a number.");
        }

        // If there are validation errors, forward back to the registration page
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("role", role);
            request.setAttribute("dateJoined", dateJoined);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("profilePicturePath", profilePicturePath);
            request.setAttribute("orgId", orgIdStr);
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
        user.setDateJoined(LocalDate.parse(dateJoined));
        user.setPhoneNumber(phoneNumber);
        user.setProfilePicturePath(profilePicturePath);
        user.setOrgId(Integer.parseInt(orgIdStr));

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
            request.setAttribute("profilePicturePath", profilePicturePath);
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
