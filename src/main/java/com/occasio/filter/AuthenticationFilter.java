package com.occasio.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.occasio.util.SessionUtil;
import com.occasio.model.UserModel;

/**
 * Servlet Filter implementation class AuthenticationFilter
 */
@WebFilter(asyncSupported = true, urlPatterns = "/*")
public class AuthenticationFilter extends HttpFilter implements Filter {
       
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private static final List<String> LOGIN_ROUTES = List.of("/login", "/register", "/userProfile");
	private static final List<String> USER_ROUTES = List.of("/home", "/myEvents", "/aboutUs", "/eventDetails", "/event", "/userProfile");
	private static final List<String> ADMIN_ROUTES = List.of("/dashboard", "/userManagement", "/eventRequest", "/userProfile");
	private static final List<String> SUPER_ADMIN_ROUTES = List.of("/superDashboard", "/organizations", "/userProfile");
	
	private static final String LOGIN = "/login";

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// Initialization logic, if required
	}
	
	private boolean endsWithAny(String uri, List<String> routes) {
	    for (String route : routes) {
	        if (uri.endsWith(route)) {
	            return true;
	        }
	    }
	    return false;
	}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String action = request.getParameter("action");

		// Get the requested URI
		String uri = req.getRequestURI();

		if (uri.matches(".*\\.(css|ttf|js|svg|png|jpe?g|webp)$")) {
		    chain.doFilter(request, response);
		    return;
		}

        boolean isLoggedIn = SessionUtil.getAttribute(req, "user") != null;
        UserModel user = (UserModel) SessionUtil.getAttribute(req, "user");

        System.out.println("Filter: Is Logged In: " + isLoggedIn);
        System.out.println("Filter: User Role: " + (user != null ? user.getRole() : "N/A (not logged in)"));

        if (!isLoggedIn) {
            System.out.println("Filter: User not logged in.");
            if (this.endsWithAny(pathWithoutContext, LOGIN_ROUTES)) {
                System.out.println("Filter: Allowing access to login/register route: " + pathWithoutContext);
                chain.doFilter(request, response);
            } else {
                System.out.println("Filter: Redirecting unauthenticated user to LOGIN: " + LOGIN);
                res.sendRedirect(contextPath + LOGIN);
            }
        } else { // User is logged in
            System.out.println("Filter: User is logged in.");
            // Allow logged-in user to perform logout action
            if (pathWithoutContext.endsWith(LOGIN) && action != null && action.equals("logout")) {
                System.out.println("Filter: Allowing logged-in user to logout.");
                chain.doFilter(request, response);
            }
            // Role-based authorization
            else if(user.getRole().equals("admin")) {
                if (this.endsWithAny(pathWithoutContext, ADMIN_ROUTES) || this.endsWithAny(pathWithoutContext, USER_ROUTES)) {
                    System.out.println("Filter: Admin allowing access to route: " + pathWithoutContext);
                    chain.doFilter(request, response);
                } else {
                    System.out.println("Filter: Admin redirecting to dashboard (unauthorized route): " + pathWithoutContext);
                    res.sendRedirect(contextPath + "/dashboard");
                }
            }
            else if (user.getRole().equals("superAdmin")) {
                if (this.endsWithAny(pathWithoutContext, SUPER_ADMIN_ROUTES) || this.endsWithAny(pathWithoutContext, ADMIN_ROUTES) || this.endsWithAny(pathWithoutContext, USER_ROUTES)) { // SuperAdmin can access admin and user routes too
                    System.out.println("Filter: SuperAdmin allowing access to route: " + pathWithoutContext);
                    chain.doFilter(request, response);
                } else {
                    System.out.println("Filter: SuperAdmin redirecting to superDashboard (unauthorized route): " + pathWithoutContext);
                    res.sendRedirect(contextPath + "/superDashboard");
                }
            }
            else { // Default user role (not admin/superAdmin)
                if (this.endsWithAny(pathWithoutContext, USER_ROUTES)) {
                    System.out.println("Filter: Regular user allowing access to route: " + pathWithoutContext);
                    chain.doFilter(request, response);
                } else {
                    System.out.println("Filter: Regular user redirecting to home (unauthorized route): " + pathWithoutContext);
                    res.sendRedirect(contextPath + "/home"); // <-- This is your likely redirect location
                }
            }
        }
        System.out.println("--- AuthenticationFilter End ---\n");
    }

    @Override
    public void destroy() {
        // Cleanup logic, if required
    }
}