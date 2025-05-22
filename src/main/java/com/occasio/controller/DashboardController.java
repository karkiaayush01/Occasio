package com.occasio.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.occasio.model.UserModel;
import com.occasio.service.DashboardService;
import com.occasio.util.SessionUtil;

import java.util.List;
import com.occasio.model.TopInterestedEventModel;
import com.occasio.model.MostEngagedUserModel;

/**
 * Servlet implementation class DashboardController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/dashboard" })
public class DashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        // Instantiate DashboardService
        DashboardService dashboardService = new DashboardService();

        // Fetch data using the service
        int ongoingEvents = dashboardService.getOngoingEventsDue();
        int upcomingEvents = dashboardService.getAllEventsDue();
        int completedEvents = dashboardService.getAllCompletedEvents();
        int totalUsers = dashboardService.getAllUsersCount();
        
        List<TopInterestedEventModel> topInterestedEvents = dashboardService.getTopInterestedEvents();
        List<MostEngagedUserModel> mostEngagedUsers = dashboardService.getMostEngagedUsers();

        // Set attributes for the JSP to access
        request.setAttribute("ongoingEvents", ongoingEvents);
        request.setAttribute("upcomingEvents", upcomingEvents);
        request.setAttribute("completedEvents", completedEvents);
        request.setAttribute("totalUsers", totalUsers);

        request.setAttribute("topInterestedEvents", topInterestedEvents);
        request.setAttribute("mostEngagedUsers", mostEngagedUsers);
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("fullName", user.getFullName());
        request.setAttribute("userEmail", user.getEmail());
        request.setAttribute("organizationId", user.getOrgId());
        request.setAttribute("userPhoneNumber", user.getPhoneNumber());
        request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());
        request.setAttribute("userId", user.getUserId());

        request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
