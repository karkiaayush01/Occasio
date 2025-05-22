package com.occasio.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import com.occasio.util.ImageUtil;
import com.occasio.util.SessionUtil;
import com.occasio.model.EventModel;
import com.occasio.model.UserModel;
import com.occasio.service.EventService;

/**
 * Servlet for handling event-related requests, including creation, editing, and display.
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/event" })
@MultipartConfig // Required for handling file uploads (e.g., event cover images)
public class EventController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final EventService eventService = new EventService();
    private final ImageUtil imageUtil = new ImageUtil();

    // Constants for image paths
    private static final String EVENT_IMAGE_SUBFOLDER = "event_covers";
    private static final String IMAGE_BASE_WEB_PATH = "resources/images";

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		UserModel user = (UserModel) SessionUtil.getAttribute(request, "user"); // Get current user

		// Ensure user is logged in for any event action via GET
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=sessionExpired");
            return;
        }
        
        if("fetchEventData".equals(action)) {
        	int eventId = Integer.parseInt(request.getParameter("eventId"));
        	int userId = Integer.parseInt(request.getParameter("userId"));
        	
        	EventModel event = eventService.getEventData(request, eventId, userId);
        	
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
    		request.setAttribute("event", event);
    		
        	request.getRequestDispatcher("/WEB-INF/pages/eventdetails.jsp").forward(request, response);
        	return;
        }
            
        // Action for fetching event data to pre-fill an edit form (e.g., /event?action=fetchForEdit&eventId=123)
        if ("fetchForEdit".equals(action)) {
            try {
                int eventId = Integer.parseInt(request.getParameter("eventId"));
                System.out.println("Fetching event data for edit, ID: " + eventId);

                EventModel eventToEdit = eventService.getEventById(eventId);

				if (eventToEdit != null) {
					// Authorization Check: Ensure the current user owns the event
					 if (eventToEdit.getPosterUserId() == user.getUserId()) {
						request.setAttribute("eventToEdit", eventToEdit);
						System.out.println("Event data fetched successfully, preparing to forward back to home.");
					 } else {
						System.err.println("User ID " + user.getUserId() + " is not authorized to edit event ID " + eventId);
						redirectToHomeWithError(request, response, "You are not authorized to edit this event.");
						return;
					 }
				} else {
					System.err.println("Event with ID " + eventId + " not found for editing.");
					 redirectToHomeWithError(request, response, "Event not found.");
					 return;
				}
			} catch (NumberFormatException e) {
				System.err.println("Invalid event ID format for editing: " + request.getParameter("eventId"));
				 redirectToHomeWithError(request, response, "Invalid event reference.");
				 return;
			} catch (Exception e) { // Catch potential errors from service layer
				System.err.println("Error fetching event for edit: " + e.getMessage());
				e.printStackTrace();
				 redirectToHomeWithError(request, response, "Error loading event data.");
				 return;
			}

            System.out.println("Repopulating home attributes before forwarding.");
            
            request.getRequestDispatcher("/WEB-INF/pages/myEvents.jsp").forward(request, response);

        }
         else {
    			System.out.println("GET request to /event with invalid or missing action: " + action);
    			response.sendRedirect(request.getContextPath() + "/myEvents?error=invalidAction");
    		}
    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");
        UserModel currentUser = (UserModel) SessionUtil.getAttribute(request, "user"); // Get current user

         // Ensure user is logged in for any event modification
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=sessionExpired");
            return;
        }

		if ("EDIT".equalsIgnoreCase(method)) {
			handleEditEvent(request, response, currentUser); // Pass user for auth check maybe later
		} else {
			handleAddEvent(request, response, currentUser);
		}
	}

	private void handleAddEvent(HttpServletRequest request, HttpServletResponse response, UserModel currentUser) throws ServletException, IOException {
		System.out.println("Handling Add Event for User ID: " + currentUser.getUserId());

		String eventName = request.getParameter("event-title");
		String startDateStr = request.getParameter("start-date");
		String endDateStr = request.getParameter("end-date");
		String eventLocation = request.getParameter("event-location");
		String eventDescription = request.getParameter("event-description");
		String restriction = request.getParameter("restriction");
		String imageChanged = request.getParameter("image-change");

		String sponsorName = request.getParameter("sponsor-name");
		String sponsorContact = request.getParameter("sponsor-contact");
		String sponsorEmail = request.getParameter("sponsor-email");

		LocalDate startDate = null;
		LocalDate endDate = null;
		LocalDate postedDate = LocalDate.now();

		try {
			// Basic check for non-empty date strings before parsing
            if (startDateStr != null && !startDateStr.trim().isEmpty()) startDate = LocalDate.parse(startDateStr);
            if (endDateStr != null && !endDateStr.trim().isEmpty()) endDate = LocalDate.parse(endDateStr);
		} catch (DateTimeParseException e) {
			 System.err.println("Error parsing dates for Add Event: " + e.getMessage());
			 redirectToHomeWithError(request, response, "Invalid date format provided.");
			 return;
		}

		String eventCoverDbPath = "";
		if ("true".equals(imageChanged)) {
			 eventCoverDbPath = handleImageUpload(request, "event-cover", EVENT_IMAGE_SUBFOLDER);
			 if (eventCoverDbPath == null) {
				  redirectToHomeWithError(request, response, "Failed to upload event image.");
				  return;
			 }
		}
		EventModel event = new EventModel();
		event.setName(eventName);
		event.setStartDate(startDate);
		event.setEndDate(endDate);
		event.setPostDate(postedDate);
		event.setLocation(eventLocation);
		event.setDescription(eventDescription);
		event.setRestriction(restriction);
		event.setImagePath(eventCoverDbPath);
		event.setPosterUserId(currentUser.getUserId()); // Use logged-in user's ID
		event.setStatus("pending");
		event.setReviewNote(null);

		// EventService will now handle the sponsor data
		String addEventResult = eventService.addEvent(event, sponsorName, sponsorContact, sponsorEmail);

		if (addEventResult.startsWith("Successfully")) {
			System.out.println("Added event successfully");
			response.sendRedirect(request.getContextPath() + "/myEvents?eventAdd=success");
		} else {
			System.err.println("Failed to add event: " + addEventResult);
			redirectToHomeWithError(request, response, addEventResult); // Pass service error message
		}
	}

	private void handleEditEvent(HttpServletRequest request, HttpServletResponse response, UserModel currentUser) throws ServletException, IOException {
		System.out.println("Handling Edit Event for User ID: " + currentUser.getUserId());

		int eventId = -1;
		try {
			eventId = Integer.parseInt(request.getParameter("eventId"));
		} catch (NumberFormatException e) {
			 redirectToHomeWithError(request, response, "Invalid Event ID for update.");
			 return;
		}

        EventModel originalEvent = eventService.getEventById(eventId);
        if (originalEvent == null) {
             redirectToHomeWithError(request, response, "Event not found for update.", eventId);
             return;
        }
        if (originalEvent.getPosterUserId() != currentUser.getUserId()) {
             redirectToHomeWithError(request, response, "You are not authorized to update this event.", eventId);
             return;
        }

		String eventName = request.getParameter("event-title");
		String startDateStr = request.getParameter("start-date");
		String endDateStr = request.getParameter("end-date");
		String eventLocation = request.getParameter("event-location");
		String eventDescription = request.getParameter("event-description");
//        String restriction = request.getParameter("restriction");
		String imageChanged = request.getParameter("image-change");

		String sponsorName = request.getParameter("sponsor-name");
		String sponsorContact = request.getParameter("sponsor-contact");
		String sponsorEmail = request.getParameter("sponsor-email");

		LocalDate startDate = null;
		LocalDate endDate = null;

		 try {
            if (startDateStr != null && !startDateStr.trim().isEmpty()) startDate = LocalDate.parse(startDateStr);
            if (endDateStr != null && !endDateStr.trim().isEmpty()) endDate = LocalDate.parse(endDateStr);
		} catch (DateTimeParseException e) {
			 System.err.println("Error parsing dates for Edit Event: " + e.getMessage());
			 redirectToHomeWithError(request, response, "Invalid date format provided.", eventId);
			 return;
		}

		// Image Handling for Edit
        String eventCoverDbPath = originalEvent.getImagePath(); // Get current path

        if ("true".equals(imageChanged)) {
            System.out.println("Image change requested for edit.");
            // Attempt upload. Result will be new path, empty string "", or null on failure.
            String uploadResultPath = handleImageUpload(request, "event-cover", EVENT_IMAGE_SUBFOLDER);

            if (uploadResultPath == null) { // Explicit check for upload failure
                 redirectToHomeWithError(request, response, "Failed to upload new event image.", eventId);
                 return;
            }
            // If upload succeeded (or user removed image resulting in ""), update the path
            eventCoverDbPath = uploadResultPath;
            System.out.println("Image path set for update: [" + eventCoverDbPath + "]");
        } else {
             System.out.println("Image not changed during edit. Keeping original: [" + eventCoverDbPath + "]");
        }
		EventModel eventToUpdate = new EventModel();
		eventToUpdate.setId(eventId);
		eventToUpdate.setName(eventName);
		eventToUpdate.setStartDate(startDate);
		eventToUpdate.setEndDate(endDate);
		eventToUpdate.setLocation(eventLocation);
		eventToUpdate.setDescription(eventDescription);
//        eventToUpdate.setRestriction(restriction);
		eventToUpdate.setImagePath(eventCoverDbPath);

        eventToUpdate.setPosterUserId(originalEvent.getPosterUserId());
        eventToUpdate.setPostDate(originalEvent.getPostDate());
        eventToUpdate.setStatus(originalEvent.getStatus());
        eventToUpdate.setReviewNote(originalEvent.getReviewNote());

		String updateResult = eventService.updateEvent(eventToUpdate, sponsorName, sponsorContact, sponsorEmail);

		if (updateResult.startsWith("Successfully")) {
			System.out.println("Updated event successfully");
			response.sendRedirect(request.getContextPath() + "/myEvents?eventUpdate=success");
		} else {
			System.err.println("Failed to update event: " + updateResult);
			 redirectToHomeWithError(request, response, updateResult, eventId);
		}
	}

	// Helper for Image Upload (returns path or null on failure)
	private String handleImageUpload(HttpServletRequest request, String partName, String subFolder) throws IOException, ServletException {
		Part filePart = request.getPart(partName);
		String originalFileName = imageUtil.getImageNameFromPart(filePart);
		String dbPath = null; // Default to null (indicates failure)

		// Check if a file was actually submitted and has a name
		if (filePart != null && filePart.getSize() > 0 && originalFileName != null && !originalFileName.isEmpty()) {
			// Attempt upload
			boolean uploaded = imageUtil.uploadImage(filePart, request.getServletContext(), subFolder);
			if (uploaded) {
				// Construct relative path ONLY if upload succeeded
				dbPath = IMAGE_BASE_WEB_PATH + "/" + subFolder + "/" + originalFileName;
				System.out.println("Upload Successful. DB path set to: " + dbPath);
			} else {
				System.err.println("ImageUtil.uploadImage failed for: " + originalFileName);
				// Keep dbPath as null to indicate failure
			}
		} else if (filePart != null && (originalFileName == null || originalFileName.isEmpty())) {
             System.out.println("File part exists but has no name (likely means no file selected or removed). Setting DB path to empty string.");
             dbPath = ""; // Explicitly set path to empty string if user removed image
        }
        else {
			 System.out.println("No new image uploaded or file part was empty.");
			 // Keep dbPath as null (indicates no change requested through upload)
		}
		return dbPath; // Returns new path, empty string "", or null
	}

	// Helper for Redirecting with Error
	private void redirectToHomeWithError(HttpServletRequest request, HttpServletResponse response, String errorMessage) throws IOException {
		 redirectToHomeWithError(request, response, errorMessage, -1);
	}

	private void redirectToHomeWithError(HttpServletRequest request, HttpServletResponse response, String errorMessage, int eventId) throws IOException {
		String encodedError = URLEncoder.encode(errorMessage, StandardCharsets.UTF_8.toString());
		String redirectUrl = request.getContextPath() + "/myEvents?error=" + encodedError;
		 if (eventId > 0) {
			 // If edit failed, add parameter to potentially re-open edit form with error later
			 // The JSP's DOMContentLoaded needs to check for 'error' and 'failedEventId'
			 redirectUrl += "&action=fetchForEdit&eventId=" + eventId;
		 }
		response.sendRedirect(redirectUrl);
	}

    // Helper to populate attributes needed by home.jsp
    private void populateHomeAttributes(HttpServletRequest request) {
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
         if (user != null) {
            request.setAttribute("userId", user.getUserId());
            request.setAttribute("fullName", user.getFullName());
            request.setAttribute("userEmail", user.getEmail());
            request.setAttribute("organizationId", user.getOrgId());
            request.setAttribute("userPhoneNumber", user.getPhoneNumber());
            request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());

            // Always fetch user events when reloading the home context
            ArrayList<EventModel> userEvents = eventService.getEventsByUser(user.getUserId());
            request.setAttribute("userEvents", userEvents != null ? userEvents : new ArrayList<>()); // Ensure not null
         }
    }
}