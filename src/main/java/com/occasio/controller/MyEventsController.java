package com.occasio.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

import com.occasio.model.EventModel;
import com.occasio.model.UserModel;
import com.occasio.util.SessionUtil;
import com.occasio.service.EventService;

/**
 * Servlet implementation class MyEventsController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/myEvents" })
public class MyEventsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final EventService eventService = new EventService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyEventsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
		request.setAttribute("userId", user.getUserId());
		request.setAttribute("fullName", user.getFullName());
		request.setAttribute("userEmail", user.getEmail());
		request.setAttribute("organizationId", user.getOrgId());
		request.setAttribute("userPhoneNumber", user.getPhoneNumber());
		request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());
		
		ArrayList<EventModel> userEvents = eventService.getEventsByUser(user.getUserId());
		request.setAttribute("userEvents", userEvents);
		request.getRequestDispatcher("/WEB-INF/pages/myEvents.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
