package com.occasio.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.occasio.model.UserModel;
import com.occasio.util.SessionUtil;
import com.occasio.service.DashboardService;

/**
 * Servlet implementation class SuperDashboardController
 */
@WebServlet("/superDashboard")
public class SuperDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DashboardService dashboardService = new DashboardService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SuperDashboardController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
		request.setAttribute("userId", user.getUserId());
		request.setAttribute("fullName", user.getFullName());
		request.setAttribute("userEmail", user.getEmail());
		request.setAttribute("organizationId", user.getOrgId());
		request.setAttribute("userPhoneNumber", user.getPhoneNumber());
		request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());
		
		int totalOrgs = dashboardService.getAllOrganizationCount();
		int totalUsers = dashboardService.getAllUsersCount();
		int totalCompletedEvents = dashboardService.getAllCompletedEvents();
		int totalDueEvents = dashboardService.getAllEventsDue();
		
		request.setAttribute("totalOrgs", totalOrgs);
		request.setAttribute("totalUsers", totalUsers);
		request.setAttribute("totalCompletedEvents", totalCompletedEvents);
		request.setAttribute("totalDueEvents", totalDueEvents);
		
		request.getRequestDispatcher("/WEB-INF/pages/superDashboard.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
