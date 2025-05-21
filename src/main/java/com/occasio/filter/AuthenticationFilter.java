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
	
	private static final List<String> LOGIN_ROUTES = List.of("/login", "/register");
	private static final List<String> USER_ROUTES = List.of("/home", "/myEvents", "/aboutUs", "/eventDetails");
	private static final List<String> ADMIN_ROUTES = List.of("/dashboard", "/userManagement", "/eventRequest");
	private static final List<String> SUPER_ADMIN_ROUTES = List.of("/superDashboard", "/organizations");
	
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
	
	private boolean doesNotMatchAnyRoute(String uri) {
	    return LOGIN_ROUTES.stream().noneMatch(uri::endsWith) &&
	           USER_ROUTES.stream().noneMatch(uri::endsWith) &&
	           ADMIN_ROUTES.stream().noneMatch(uri::endsWith) &&
	           SUPER_ADMIN_ROUTES.stream().noneMatch(uri::endsWith);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		// Cast the request and response to HttpServletRequest and HttpServletResponse
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String action = request.getParameter("action");

		// Get the requested URI
		String uri = req.getRequestURI();

		if (uri.endsWith(".css") || uri.endsWith(".ttf") || uri.endsWith(".js") || uri.endsWith(".svg") || uri.endsWith(".png") || uri.endsWith(".jpg")) {
			chain.doFilter(request, response);
			return;
		}

		// Get the session and check if user is logged in
		boolean isLoggedIn = SessionUtil.getAttribute(req, "user") != null;
		
		UserModel user = (UserModel) SessionUtil.getAttribute(req, "user");
		
		if (!isLoggedIn) {
			if (this.endsWithAny(uri, LOGIN_ROUTES)) {
				chain.doFilter(request, response);
			} else {
				res.sendRedirect(req.getContextPath() + LOGIN);
			}
		} else {
			//if user is already logged in but trying to redirect to login with logout action, do not block the user
			if (uri.endsWith(LOGIN) && action != null && action.equals("logout")) {
				chain.doFilter(request, response);
			}
			
			if(user.getRole().equals("admin")) {
				if (this.endsWithAny(uri, ADMIN_ROUTES) || this.endsWithAny(uri, USER_ROUTES)) {
					chain.doFilter(request, response);
				} else {
					res.sendRedirect(req.getContextPath() + "/dashboard");
				}
			}
			else if (user.getRole().equals("superAdmin")) {
				if (this.endsWithAny(uri, SUPER_ADMIN_ROUTES)) {
					chain.doFilter(request, response);
				} else {
					res.sendRedirect(req.getContextPath() + "/superDashboard");
				}
			}
			else {
				if (this.endsWithAny(uri, USER_ROUTES)) {
					chain.doFilter(request, response);
				} else {
					res.sendRedirect(req.getContextPath() + "/home");
				}
			}
		}
	}

	@Override
	public void destroy() {
		// Cleanup logic, if required
	}
}
