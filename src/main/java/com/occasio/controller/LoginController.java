package com.occasio.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.occasio.model.UserModel;
import com.occasio.service.LoginService;
import com.occasio.util.SessionUtil;

@WebServlet(asyncSupported = true, urlPatterns="/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    //private LoginService loginService;

    @Override
    public void init() throws ServletException {
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String action = request.getParameter("action");
    	if(action.equals("login")) {
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        String errorMessage = null;
	        LoginService loginService = new LoginService();
	
	        if (email == null || email.trim().isEmpty() || password == null || password.isEmpty()) {
	            errorMessage = "Email and Password are required.";
	        } else {
	            UserModel user = loginService.authenticateUser(email, password);
	
	            if (user != null) {
	                // Authentication Successful
	                SessionUtil.setAttribute(request, "username", user); 
	
	                System.out.println("Login successful for: " + user.getEmail());
	                response.sendRedirect(request.getContextPath() + "/home"); // Redirect to protected area
	                return; // Stop further processing
	
	            } else {
	                // Authentication Failed
	                errorMessage = "Invalid email or password.";
	                System.out.println("Login failed for email: " + email);
	            }
	        }
	
	        // Authentication Failed or Validation Error
	        request.setAttribute("loginError", errorMessage);
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
	        dispatcher.forward(request, response);
    	}
    	else if (action.equals("logout")) {
    		SessionUtil.removeAttribute(request, "username");
    		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
    		dispatcher.forward(request, response);
    	}
    	else {
    		System.out.println("No parameter named action");
    	}
    }
}