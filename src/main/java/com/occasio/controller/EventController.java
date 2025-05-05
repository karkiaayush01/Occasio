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

import com.occasio.util.ImageUtil;
import com.occasio.model.EventModel;
import com.occasio.service.EventService;

/**
 * Servlet implementation class EventController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/event" })
@MultipartConfig
public class EventController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	EventService eventService = new EventService();
	ImageUtil imageUtil = new ImageUtil();
	
	private static final String EVENT_IMAGE_SUBFOLDER = "event_covers";
	private static final String IMAGE_BASE_WEB_PATH = "resources/images";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/WEB-INF/pages/eventdetails.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Entered Event Controller");
		String eventName =  request.getParameter("event-title");
		
		String startDateStr = request.getParameter("start-date");
		String endDateStr = request.getParameter("end-date");
		
		LocalDate startDate = null;
		LocalDate endDate = null;
		LocalDate postedDate = LocalDate.now();
		
		if(startDateStr == null || startDateStr.equals("") || endDateStr.equals("") || endDateStr == null) {
			System.out.println("Null Dates Found!!");
		}
		else {
			startDate = LocalDate.parse(request.getParameter("start-date"));
			endDate = LocalDate.parse(request.getParameter("end-date"));
		}
		
		String eventLocation = request.getParameter("event-location");
		String eventDescription = request.getParameter("event-description");
		
		String sponsorName = request.getParameter("sponsor-name");
		String sponsorsContact = request.getParameter("sponsor-contact");
		String sponsorsEmail = request.getParameter("sponsor-email");
		String imageChanged = request.getParameter("image-change");
		
		String uploadedImageName = null;
		String eventCoverDbPath = "";
		
		if(imageChanged.equals("true")) {
			try {
				Part filePart = request.getPart("event-cover");
				
				 // Use the new ImageUtil to get the filename
                uploadedImageName = imageUtil.getImageNameFromPart(filePart);

                // Check if a file was actually uploaded (size > 0) and has a valid name
                if (filePart != null && filePart.getSize() > 0 && uploadedImageName != null && !uploadedImageName.isEmpty() && !uploadedImageName.equals("")) {

                    // Use the new ImageUtil to upload the file
                    // The rootPath argument isn't used by the provided uploadImage, pass null or empty
                    boolean uploaded = imageUtil.uploadImage(filePart, request.getServletContext(), EVENT_IMAGE_SUBFOLDER);

                    if (uploaded) {
                        // Construct the relative path for DB storage and web access
                        // Assumes files are served from webapp/resources/images/
                        eventCoverDbPath = IMAGE_BASE_WEB_PATH + "/" + EVENT_IMAGE_SUBFOLDER + "/" + uploadedImageName;

                        System.out.println("Event Cover Upload Successful. DB path: " + eventCoverDbPath);
                    } else {
                        System.err.println("ImageUtil.uploadImage failed for: " + uploadedImageName);
                        uploadedImageName = null; // Nullify name if upload failed
                    }
                } else {
                    System.out.println("No profile picture uploaded or file was empty/default name.");
                    uploadedImageName = null; // No valid image uploaded
                }
			}
			catch (IOException | ServletException e) {
				System.err.println("Error processing uploaded file part: " + e.getMessage());
				e.printStackTrace();
			}
		}
		
		EventModel event = new EventModel();
		event.setName(eventName);
		event.setStartDate(startDate);
		event.setEndDate(endDate);
		event.setPostDate(postedDate);
		event.setLocation(eventLocation);
		event.setDescription(eventDescription);
		event.setImagePath(eventCoverDbPath);
		event.setPosterUserId(1);
		event.setStatus("pending");
		
		
		String addEventResult = eventService.addEvent(event);
		
		if (addEventResult.startsWith("Successfully ")) {
            // Registration successful, redirect to a success page
			System.out.println("Added event successfully");
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
        	response.sendRedirect(request.getContextPath() + "/home");
        }
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
