package com.occasio.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.time.LocalDate;

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
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("##Reached doGet in MyEventsController");

		UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=sessionExpired");
            return;
        }

		request.setAttribute("userId", user.getUserId());
		request.setAttribute("fullName", user.getFullName());
		request.setAttribute("userEmail", user.getEmail());
		request.setAttribute("organizationId", user.getOrgId());
		request.setAttribute("userPhoneNumber", user.getPhoneNumber());
		request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());
		
		// *** NEW: Get All and Categorize Events, then pass to attributes for JSP ***
		List<EventModel> allUserEvents = eventService.getEventsByUser(user.getUserId());
        List<EventModel> currentEvents = new ArrayList<>();
        List<EventModel> pastEvents = new ArrayList<>();
        LocalDate currentDate = LocalDate.now();

        if (allUserEvents != null) { // Ensure the list is not null
            for (EventModel event : allUserEvents) {
                // Check the event end date. All other is to be set to Upcoming events.
                if (event.getEndDate() != null && event.getEndDate().isBefore(currentDate)) {
                    pastEvents.add(event);
                } else {
                    currentEvents.add(event);
                }
            }

            // Sort the lists
            currentEvents.sort(Comparator.comparing(EventModel::getStartDate)); // Upcoming events sorted by start date
            pastEvents.sort(Comparator.comparing(EventModel::getEndDate).reversed());    // Past events sorted by end date descending
        }
        

        request.setAttribute("currentEvents", currentEvents); // For Current and Upcoming events
        request.setAttribute("pastEvents", pastEvents);        // For all Past events

		request.getRequestDispatcher("/WEB-INF/pages/myEvents.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}