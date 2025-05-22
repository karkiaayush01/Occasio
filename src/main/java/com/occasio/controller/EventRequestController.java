package com.occasio.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.occasio.model.UserModel;
import com.occasio.model.EventModel; // Import EventModel
import com.occasio.service.EventRequestService;
import com.occasio.util.SessionUtil;

@WebServlet("/eventRequest")
public class EventRequestController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EventRequestController() {
        super();
    }

    /**
     * Handles GET requests for the /eventRequest endpoint.
     * Retrieves all event requests for the logged-in user's organization and
     * forwards the data to eventRequest.jsp.
     *
     * @param request  the HttpServletRequest containing user session
     * @param response the HttpServletResponse to send data to the JSP
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Entering doGet for eventRequest");
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        EventRequestService eventService = new EventRequestService();
        List<EventModel> allEvents = eventService.getAllEvents(user.getOrgId());

        request.setAttribute("allEvents", allEvents);
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("fullName", user.getFullName());
        request.setAttribute("userEmail", user.getEmail());
        request.setAttribute("organizationId", user.getOrgId());
        request.setAttribute("userPhoneNumber", user.getPhoneNumber());
        request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());
        System.out.println("####\n\nForwarding response to eventRequest.jsp\n\n\n#####");
        request.getRequestDispatcher("/WEB-INF/pages/eventRequest.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for the /eventRequest endpoint.
     * Delegates to appropriate handlers based on 'action' parameter.
     *
     * @param request  the HttpServletRequest containing form data
     * @param response the HttpServletResponse to send results
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("approveEvent".equals(action)) {
            handleApproveEvent(request, response);
        } else if ("rejectEvent".equals(action)) {
            handleRejectEvent(request, response);
        } else {
            doGet(request, response); // Refresh the page in other cases
        }
    }

    /**
     * Handles approval of an event.
     *
     * @param request  the HttpServletRequest containing the eventId
     * @param response the HttpServletResponse to redirect or show message
     * @throws ServletException
     * @throws IOException
     */
    private void handleApproveEvent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        EventRequestService eventService = new EventRequestService();
        String result = eventService.approveEvent(eventId);

        request.setAttribute("message", result);
        doGet(request, response);
    }

    /**
     * Handles rejection of an event with a reason.
     *
     * @param request  the HttpServletRequest containing the eventId and rejectionReason
     * @param response the HttpServletResponse to redirect or show message
     * @throws ServletException
     * @throws IOException
     */
    private void handleRejectEvent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String reviewNote = request.getParameter("rejectionReason");

        EventRequestService eventService = new EventRequestService();
        String result = eventService.rejectEvent(eventId, reviewNote);

        request.setAttribute("message", result);
        doGet(request, response);
    }
}
