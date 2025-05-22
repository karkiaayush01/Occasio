package com.occasio.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.occasio.model.UserModel;
import com.occasio.service.LoginService;
import com.occasio.util.SessionUtil;
import com.occasio.util.CookieUtil;

@WebServlet(asyncSupported = true, urlPatterns="/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    //private LoginService loginService;

    /**
     * Initializes the servlet.
     *
     * @throws ServletException if an initialization error occurs
     */
    @Override
    public void init() throws ServletException {
        
    }

    /**
     * Handles GET requests to the /login endpoint.
     * Loads the login page and displays any popup messages stored in the session.
     *
     * @param request  the HttpServletRequest object
     * @param response the HttpServletResponse object
     * @throws ServletException if an error occurs during request forwarding
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String popupMessage = (String) SessionUtil.getAttribute(request, "popupMessage");
        String popupType = (String) SessionUtil.getAttribute(request, "popupType");
        
        if(popupMessage != null && popupType != null) {
            request.setAttribute("popupMessage", popupMessage);
            request.setAttribute("popupType", popupType);
            SessionUtil.removeAttribute(request, "popupMessage");
            SessionUtil.removeAttribute(request, "popupType");
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles POST requests to the /login endpoint.
     * Processes login and logout actions, validates user input, and manages session state.
     *
     * @param request  the HttpServletRequest object containing form data
     * @param response the HttpServletResponse object for sending redirects or dispatching
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if(action != null) {
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
                        SessionUtil.setAttribute(request, "user", user); 
                        
                        CookieUtil.addCookie(response, "email", user.getEmail(), 900);
                        CookieUtil.addCookie(response, "fullName", user.getFullName(), 900);

                        if(user.getRole().equals("admin")) {
                            response.sendRedirect(request.getContextPath() + "/dashboard");
                            return;
                        }
                        else{
                            response.sendRedirect(request.getContextPath() + "/home"); // Redirect to protected area
                            return;
                        }

                    } else {
                        // Authentication Failed
                        errorMessage = "Invalid email or password.";
                        System.out.println("Login failed for email: " + email);
                    }
                }

                // Authentication Failed or Validation Error
                SessionUtil.setAttribute(request, "popupMessage", errorMessage);
                SessionUtil.setAttribute(request, "popupType", "error");
                response.sendRedirect(request.getContextPath() + "/home");
            }
            else if (action.equals("logout")) {
                SessionUtil.removeAttribute(request, "user");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
                dispatcher.forward(request, response);
            }
            else {
                System.out.println("No parameter named action");
            }
        } 
        else {
            System.out.println("Action is null");
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
