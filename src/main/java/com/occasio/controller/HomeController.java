package com.occasio.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

import com.occasio.util.SessionUtil;
import com.occasio.model.EventModel;
import com.occasio.model.UserModel;
import com.occasio.service.EventService;

/**
 * Servlet implementation class HomeController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/home", "/" })
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final EventService eventService = new EventService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
		
		String popupMessage = (String) SessionUtil.getAttribute(request, "popupMessage");
		String popupType = (String) SessionUtil.getAttribute(request, "popupType");

		if(popupMessage != null && popupType != null) {
			request.setAttribute("popupMessage", popupMessage);
			request.setAttribute("popupType", popupType);
			SessionUtil.removeAttribute(request, "popupMessage");
			SessionUtil.removeAttribute(request, "popupType");
		}
		
		request.setAttribute("userId", user.getUserId());
		request.setAttribute("fullName", user.getFullName());
		request.setAttribute("userEmail", user.getEmail());
		request.setAttribute("organizationId", user.getOrgId());
		request.setAttribute("userPhoneNumber", user.getPhoneNumber());
		request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());
		
		String searchFilter = (String) SessionUtil.getAttribute(request, "searchTerm");
		if(searchFilter == null) {
			searchFilter = "";
		}
		
		request.setAttribute("searchFilter", searchFilter);
		SessionUtil.removeAttribute(request, "searchFilter");
		
		ArrayList<EventModel> ongoingEvents = eventService.getOngoingEvents(user.getUserId(), user.getOrgId(), searchFilter);
		ArrayList<EventModel> upcomingEvents = eventService.getUpcomingEvents(user.getOrgId(), searchFilter);
		request.setAttribute("ongoingEvents", ongoingEvents);
		request.setAttribute("upcomingEvents", upcomingEvents);
		
		request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if(action.equals("search")) {
			SessionUtil.setAttribute(request, "searchTerm", request.getParameter("searchText"));
			
			response.sendRedirect(request.getContextPath() + "/home");
		}
	}

}
