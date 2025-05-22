package com.occasio.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement; // For Statement.RETURN_GENERATED_KEYS
import java.sql.Types;    // For Types.INTEGER

import java.util.ArrayList;
import java.util.List; // Import List

import com.occasio.config.DbConfig;
import com.occasio.model.EventModel;
import com.occasio.model.InterestedModel;
import com.occasio.model.SponsorModel;
import com.occasio.util.SessionUtil;

import jakarta.servlet.http.HttpServletRequest;

public class EventService {
	private Connection dbConn;
	private final SponsorService sponsorService;

	public EventService() {
		try {
			this.dbConn = DbConfig.getDbConnection();
		}
		catch(SQLException | ClassNotFoundException ex) {
			System.err.println("Database connection error: " + ex.getMessage());
			ex.printStackTrace();
		}
		this.sponsorService = new SponsorService();
	}

	public EventModel getEventById(int eventId) {
        if (this.dbConn == null) {
            System.err.println("EventService.getEventById: Database connection not found.");
            return null;
        }

        String sql = "SELECT * FROM event WHERE EventId = ?";
        EventModel event = null;

        try (PreparedStatement pstmt = dbConn.prepareStatement(sql)) {
            pstmt.setInt(1, eventId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    event = new EventModel();
                    event.setId(rs.getInt("EventId"));
                    event.setName(rs.getString("EventName"));

                    Date startDateDb = rs.getDate("StartDate");
                    Date endDateDb = rs.getDate("EndDate");
                    Date postDateDb = rs.getDate("PostDate");
                    event.setStartDate(startDateDb != null ? startDateDb.toLocalDate() : null);
                    event.setEndDate(endDateDb != null ? endDateDb.toLocalDate() : null);
                    event.setPostDate(postDateDb != null ? postDateDb.toLocalDate() : null);

                    event.setDescription(rs.getString("Description"));
                    event.setImagePath(rs.getString("ImagePath"));
                    event.setLocation(rs.getString("EventLocation"));
                    event.setRestriction(rs.getString("Restriction"));
                    event.setPosterUserId(rs.getInt("PostedUserId"));
                    event.setStatus(rs.getString("Status"));
                    event.setReviewNote(rs.getString("ReviewNote"));

                    // *** NEW: Fetch all sponsors for this event from the bridging table ***
                    event.setSponsors(getSponsorsForEvent(eventId)); // Call helper method
                }
            }
        } catch (SQLException e) {
            System.err.println("Occasio.EventService.getEventById: Error fetching event with ID " + eventId + " - " + e.getMessage());
            e.printStackTrace();
        }
        return event;
    }

    /**
     * Helper method to fetch all sponsors linked to a given event ID.
     */
	private List<SponsorModel> getSponsorsForEvent(int eventId) {
	    List<SponsorModel> sponsors = new ArrayList<>();
	    String sql = "SELECT s.* FROM sponsor s JOIN event_sponsor es ON s.sponsorID = es.sponsorID WHERE es.eventID = ?";
	    System.out.println("Fetching sponsors for event ID: " + eventId); // DEBUG
	    try (Connection conn = DbConfig.getDbConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, eventId);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                SponsorModel sponsor = new SponsorModel();
	                sponsor.setSponsorID(rs.getInt("sponsorID"));
	                sponsor.setSponsorName(rs.getString("sponsorName"));
	                sponsor.setSponsorContact(rs.getString("sponsorContact"));
	                sponsor.setSponsorEmail(rs.getString("sponsorEmail"));
	                sponsors.add(sponsor);
	                System.out.println("Found sponsor for event " + eventId + ": " + sponsor.getSponsorName()); // DEBUG
	            }
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        System.err.println("Occasio.EventService.getSponsorsForEvent: Error fetching sponsors for event " + eventId + ": " + e.getMessage());
	        e.printStackTrace();
	    }
	    System.out.println("Returning " + sponsors.size() + " sponsors for event " + eventId); // DEBUG
	    return sponsors;
	}

	public String addEvent(EventModel eventModel, String sponsorNameInput, String sponsorContactInput, String sponsorEmailInput) {
	    if (this.dbConn == null) {
	        return "Error while connecting to database";
	    }

        String validationError = validateEventData(eventModel, false, sponsorNameInput, sponsorContactInput, sponsorEmailInput);
        if (validationError != null) {
            return validationError;
        }

	    Integer resolvedSponsorId = null; // This will hold the ID of the sponsor to link

	    boolean anySponsorInfoProvided = (sponsorNameInput != null && !sponsorNameInput.trim().isEmpty()) ||
	                                     (sponsorContactInput != null && !sponsorContactInput.trim().isEmpty()) ||
	                                     (sponsorEmailInput != null && !sponsorEmailInput.trim().isEmpty());

	    if (anySponsorInfoProvided) {
	        SponsorModel existingSponsor = sponsorService.getSponsorByNameAndEmail(sponsorNameInput, sponsorEmailInput);

	        if (existingSponsor != null) {
	            resolvedSponsorId = existingSponsor.getSponsorID();
	            // Optional: Update contact if it changed
	            if (sponsorContactInput != null && !sponsorContactInput.equals(existingSponsor.getSponsorContact())) {
	                 existingSponsor.setSponsorContact(sponsorContactInput);
	                 sponsorService.updateSponsor(existingSponsor); // Call update if implemented
	            }
	        } else {
	            SponsorModel newSponsor = new SponsorModel();
	            newSponsor.setSponsorName(sponsorNameInput);
	            newSponsor.setSponsorContact(sponsorContactInput);
	            newSponsor.setSponsorEmail(sponsorEmailInput);

	            boolean sponsorAdded = sponsorService.addSponsor(newSponsor);
	            if (sponsorAdded) {
	                resolvedSponsorId = newSponsor.getSponsorID();
	            } else {
	                return "Failed to add new sponsor. Please check sponsor details.";
	            }
	        }
	    }

	    // Insert event data into 'event' table
	    String insertEventQuery = "INSERT INTO event (EventName, StartDate, EndDate, PostDate, Description, ImagePath, EventLocation, Restriction, PostedUserId, Status, ReviewNote) "
	            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    try (PreparedStatement addEventStmt = dbConn.prepareStatement(insertEventQuery, Statement.RETURN_GENERATED_KEYS)) {
	        int paramIndex = 1;
	        addEventStmt.setString(paramIndex++, eventModel.getName());
	        addEventStmt.setDate(paramIndex++, Date.valueOf(eventModel.getStartDate()));
	        addEventStmt.setDate(paramIndex++, Date.valueOf(eventModel.getEndDate()));
	        addEventStmt.setDate(paramIndex++, Date.valueOf(eventModel.getPostDate()));
	        addEventStmt.setString(paramIndex++, eventModel.getDescription());
	        addEventStmt.setString(paramIndex++, eventModel.getImagePath());
	        addEventStmt.setString(paramIndex++, eventModel.getLocation());
	        addEventStmt.setString(paramIndex++, eventModel.getRestriction());
	        addEventStmt.setInt(paramIndex++, eventModel.getPosterUserId());
	        addEventStmt.setString(paramIndex++, eventModel.getStatus());
	        addEventStmt.setString(paramIndex++, eventModel.getReviewNote());

	        int rowsAffected = addEventStmt.executeUpdate();

	        if (rowsAffected > 0) {
	             // Get auto-generated Event ID
	             try (ResultSet generatedKeys = addEventStmt.getGeneratedKeys()) {
	                 if (generatedKeys.next()) {
	                     eventModel.setId(generatedKeys.getInt(1));
	                 }
	             }

                 //Auto enroll the event creator in event_interested_users
                boolean enrolledCreator = false;
                try {
                  enrolledCreator = linkEventToSponsor(eventModel.getId(), eventModel.getPosterUserId()); // Use event's Id and postedUserId
                } catch (Exception en) {
                     System.err.println("Error autolinking EventID " +  eventModel.getId() + " to Poster ID: " +  eventModel.getPosterUserId() + " during event creation.");
                }

                if (!enrolledCreator) {
                 return "Successfully added event, but failed to autolink user to the event.";  //Non Critical failure
             }
                 return "Successfully added event";
	        } else {
	            return "An error occurred while adding event (Insertion Failed).";
	        }

        } catch (SQLException e) {
            System.err.println("Occasio.EventService.addEvent: Error while adding event: " + e.getMessage());
            e.printStackTrace();
            return "An error occurred while adding event. Please try again later.";
        }
	}

    /**
     * Helper method to link an event to a sponsor in the event_sponsor bridging table.
     */
    private boolean linkEventToSponsor(int eventId, int sponsorId) {
        String sql = "INSERT INTO event_sponsor (eventID, sponsorID) VALUES (?, ?)";
        try (Connection conn = DbConfig.getDbConnection(); // Use a new connection for transaction safety
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, eventId);
            pstmt.setInt(2, sponsorId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Occasio.EventService.linkEventToSponsor: Error linking event " + eventId + " to sponsor " + sponsorId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Helper method to unlink all sponsors from an event in the event_sponsor bridging table.
     */
    private boolean unlinkAllSponsorsFromEvent(int eventId) {
        String sql = "DELETE FROM event_sponsor WHERE eventID = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, eventId);
            pstmt.executeUpdate(); // executeUpdate returns rows affected. 0 is okay here (no links to remove)
            return true;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Occasio.EventService.unlinkAllSponsorsFromEvent: Error unlinking sponsors for event " + eventId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


	// *** CRITICAL CHANGE: updateEvent now handles Many-to-Many linking ***
	public String updateEvent(EventModel eventModel, String sponsorNameInput, String sponsorContactInput, String sponsorEmailInput) {
        if (this.dbConn == null) {
           return "Database connection error.";
       }
       if (eventModel == null || eventModel.getId() <= 0) {
            return "Invalid event data or missing Event ID for update.";
       }

       String validationError = validateEventData(eventModel, true, sponsorNameInput, sponsorContactInput, sponsorEmailInput);
       if (validationError != null) {
           return validationError;
       }

       Integer resolvedSponsorId = null;
       boolean anySponsorInfoProvided = (sponsorNameInput != null && !sponsorNameInput.trim().isEmpty()) ||
                                        (sponsorContactInput != null && !sponsorContactInput.trim().isEmpty()) ||
                                        (sponsorEmailInput != null && !sponsorEmailInput.trim().isEmpty());

       if (anySponsorInfoProvided) {
           SponsorModel existingSponsor = sponsorService.getSponsorByNameAndEmail(sponsorNameInput, sponsorEmailInput);

           if (existingSponsor != null) {
               resolvedSponsorId = existingSponsor.getSponsorID();
               if (sponsorContactInput != null && !sponsorContactInput.equals(existingSponsor.getSponsorContact())) {
                    existingSponsor.setSponsorContact(sponsorContactInput);
                    sponsorService.updateSponsor(existingSponsor);
               }
           } else {
               SponsorModel newSponsor = new SponsorModel();
               newSponsor.setSponsorName(sponsorNameInput);
               newSponsor.setSponsorContact(sponsorContactInput);
               newSponsor.setSponsorEmail(sponsorEmailInput);

               boolean sponsorAdded = sponsorService.addSponsor(newSponsor);
               if (sponsorAdded) {
                   resolvedSponsorId = newSponsor.getSponsorID();
               } else {
                   return "Failed to add new sponsor during event update.";
               }
           }
       }

       // Update event data in 'event' table
       StringBuilder sqlBuilder = new StringBuilder("UPDATE event SET EventName = ?, StartDate = ?, EndDate = ?, Description = ?, EventLocation = ?, Restriction = ?, Status = ?, ReviewNote = ?");

       boolean updateImage = eventModel.getImagePath() != null;
       if (updateImage) {
            sqlBuilder.append(", ImagePath = ?");
       }
       sqlBuilder.append(" WHERE EventId = ?");
       String sql = sqlBuilder.toString();
       System.out.println("Executing Update SQL: " + sql);

       try (PreparedStatement pstmt = dbConn.prepareStatement(sql)) {
           int paramIndex = 1;
           pstmt.setString(paramIndex++, eventModel.getName());
           pstmt.setDate(paramIndex++, Date.valueOf(eventModel.getStartDate()));
           pstmt.setDate(paramIndex++, Date.valueOf(eventModel.getEndDate()));
           pstmt.setString(paramIndex++, eventModel.getDescription());
           pstmt.setString(paramIndex++, eventModel.getLocation());
           pstmt.setString(paramIndex++, eventModel.getRestriction());
           pstmt.setString(paramIndex++, eventModel.getStatus()); // Ensure status is set if updated from form
           pstmt.setString(paramIndex++, eventModel.getReviewNote()); // Ensure reviewNote is set if updated from form

           if (updateImage) {
                pstmt.setString(paramIndex++, eventModel.getImagePath());
           }

           pstmt.setInt(paramIndex, eventModel.getId());

           int rowsAffected = pstmt.executeUpdate();

           if (rowsAffected > 0) {
                // *** NEW: Update sponsor links in event_sponsor table ***
                // 1. Remove all existing links for this event
                if (!unlinkAllSponsorsFromEvent(eventModel.getId())) {
                    System.err.println("Occasio.EventService.updateEvent: Failed to unlink existing sponsors for event " + eventModel.getId());
                    return "Successfully updated event details, but failed to update sponsor links.";
                }

                // 2. Add the (potentially new) link
                if (resolvedSponsorId != null && eventModel.getId() > 0) {
                     if (!linkEventToSponsor(eventModel.getId(), resolvedSponsorId)) {
                         System.err.println("Occasio.EventService.updateEvent: Failed to link event " + eventModel.getId() + " to sponsor " + resolvedSponsorId);
                         return "Successfully updated event details, but failed to link new sponsor.";
                     }
                }
                return "Successfully updated event";
           } else {
               return "Event update failed (Event not found or no changes made).";
           }
       } catch (SQLException e) {
           System.err.println("Occasio.EventService.updateEvent: Error updating event: " + e.getMessage());
           e.printStackTrace();
           return "An error occurred during event update.";
       }
   }

	public ArrayList<EventModel> getEventsByUser(int userId) {
		ArrayList<EventModel> userEvents = new ArrayList<>();

		if(this.dbConn == null) {
			System.err.println("EventService.getEventsByUser: Database connection not found.");
			return null;
		}

		String fetchUserEventsQuery = "SELECT * FROM event WHERE PostedUserId = ?";

		try (PreparedStatement fetchUserEventStmt = dbConn.prepareStatement(fetchUserEventsQuery)) {
			fetchUserEventStmt.setInt(1, userId);

			ResultSet rs = fetchUserEventStmt.executeQuery();

			while(rs.next()) {
				EventModel event = new EventModel();

				event.setId(rs.getInt("EventId"));
				event.setName(rs.getString("EventName"));
				event.setStartDate(rs.getDate("StartDate").toLocalDate());
				event.setEndDate(rs.getDate("EndDate").toLocalDate());
				event.setPostDate(rs.getDate("PostDate").toLocalDate());
				event.setLocation(rs.getString("EventLocation"));
				event.setDescription(rs.getString("Description"));
				event.setImagePath(rs.getString("ImagePath"));
				event.setRestriction(rs.getString("Restriction"));
				event.setPosterUserId(rs.getInt("PostedUserId"));
				event.setStatus(rs.getString("Status"));
				event.setReviewNote(rs.getString("ReviewNote"));

                // *** NEW: Fetch all sponsors for this event from the bridging table ***
                event.setSponsors(getSponsorsForEvent(event.getId())); // Call helper method

				userEvents.add(event);
			}
		}
		catch(SQLException e) {
			System.err.println("Occasio.EventService.getEventsByUser: Error found while getting user events:" + e);
			return null;
		}
		return userEvents;
	}

	public InterestedModel getInterestedUsersForEvent(int eventId, int postedUserId) {
		InterestedModel totalInterested = new InterestedModel();
		String getInterestedQuery = "SELECT i.UserId, u.ProfilePicturePath FROM event_interested_users i JOIN user u ON i.UserId = u.UserId WHERE i.eventId = ?";
		try(PreparedStatement getInterestedStmt = dbConn.prepareStatement(getInterestedQuery)){
			getInterestedStmt.setInt(1, eventId);
			ResultSet rs = getInterestedStmt.executeQuery();
			int totalUsersCount = 0;
			ArrayList<String> interestedUserImages = new ArrayList<String>();
			while(rs.next()) {
				totalUsersCount++;
				if(totalUsersCount < 4) {
					interestedUserImages.add(rs.getString("ProfilePicturePath"));
				}
			}
			totalInterested.setEventId(eventId);
			totalInterested.setInterestedUsersPicturePaths(interestedUserImages);
            totalInterested.setTotalInterestedCount(totalUsersCount);
		}
		catch(SQLException e) {
			System.err.println("Occasio.EventService.getInterestedUsersForEvent: Error found while getting interested user for event: " + eventId + e);
		}
		return totalInterested;
	}
	
	public ArrayList<EventModel> getOngoingEvents(int userId, int orgId, String filter){
		ArrayList<EventModel> ongoingEvents = new ArrayList<>();
		if(this.dbConn == null) {
			System.err.println("EventService.getOngoingEvents: Database connection not found.");
			return null;
		}
		
		LocalDate currentDate = LocalDate.now();
		
		String getOngoingEventsQuery = "SELECT e.*, i.UserId AS Interested FROM event e "
				+ "JOIN user u ON e.PostedUserId = u.UserId LEFT JOIN event_interested_users i ON e.EventId = i.EventId AND i.UserId = ? "
				+ "WHERE u.OrgId = ?  AND e.Status = ? AND StartDate <= ? AND EndDate >= ? AND e.EventName LIKE ?";
		
		try(PreparedStatement getOngoingEventsStmt = dbConn.prepareStatement(getOngoingEventsQuery)){
			getOngoingEventsStmt.setInt(1, userId);
			getOngoingEventsStmt.setInt(2, orgId);
			getOngoingEventsStmt.setString(3, "pending");
			getOngoingEventsStmt.setDate(4, Date.valueOf(currentDate));
			getOngoingEventsStmt.setDate(5, Date.valueOf(currentDate));
			getOngoingEventsStmt.setString(6, "%" + filter + "%");
			
			ResultSet rs = getOngoingEventsStmt.executeQuery();
			while(rs.next()) {
				EventModel event = new EventModel();
				event.setId(rs.getInt("EventId"));
				event.setName(rs.getString("EventName"));
				event.setStartDate(rs.getDate("StartDate").toLocalDate());
				event.setEndDate(rs.getDate("EndDate").toLocalDate());
				event.setPostDate(rs.getDate("PostDate").toLocalDate());
				event.setLocation(rs.getString("EventLocation"));
				event.setDescription(rs.getString("Description"));
				event.setImagePath(rs.getString("ImagePath"));
				event.setRestriction(rs.getString("Restriction"));
				event.setPosterUserId(rs.getInt("PostedUserId"));
				event.setStatus(rs.getString("Status"));
				event.setReviewNote(rs.getString("ReviewNote"));

                // *** NEW: Fetch all sponsors for this event from the bridging table ***
                event.setSponsors(getSponsorsForEvent(event.getId()));

				Boolean isInterested = rs.getObject("Interested") != null;
				event.setInterested(isInterested);
				InterestedModel interestedUsers = getInterestedUsersForEvent(rs.getInt("EventId"), rs.getInt("PostedUserId"));
				event.setInterestedUsers(interestedUsers);
				ongoingEvents.add(event);
			}
		}
		catch(SQLException e) {
			System.err.println("Occasio.EventService.getOngoingEvents: Error found while getting ongoing events:" + e);
		}
		return ongoingEvents;
	}
	
	public ArrayList<EventModel> getUpcomingEvents(int orgId, String filter){
		ArrayList<EventModel> upcomingEvents = new ArrayList<>();
		
		if(this.dbConn == null) {
			System.err.println("Error while fetching upcoming events: Database connection not found.");
			return null;
		}
		
		LocalDate currentDate = LocalDate.now();
		
		String getUpcomingEventsQuery = "SELECT e.* FROM event e "
				+ "JOIN user u ON e.PostedUserId = u.UserId "
				+ "WHERE u.OrgId = ?  AND e.Status = ? AND StartDate > ? AND e.EventName LIKE ?";
		
		try(PreparedStatement getUpcomingEventsStmt = dbConn.prepareStatement(getUpcomingEventsQuery)){
			getUpcomingEventsStmt.setInt(1, orgId);
			getUpcomingEventsStmt.setString(2, "pending");
			getUpcomingEventsStmt.setDate(3, Date.valueOf(currentDate));
			getUpcomingEventsStmt.setString(4, "%" + filter + "%");
			
			ResultSet rs = getUpcomingEventsStmt.executeQuery();
			
			while(rs.next()) {
				EventModel event = new EventModel();
				
				event.setId(rs.getInt("EventId"));
				event.setName(rs.getString("EventName"));
				event.setStartDate(rs.getDate("StartDate").toLocalDate());
				event.setEndDate(rs.getDate("EndDate").toLocalDate());
				event.setPostDate(rs.getDate("PostDate").toLocalDate());
				event.setLocation(rs.getString("EventLocation"));
				event.setDescription(rs.getString("Description"));
				event.setImagePath(rs.getString("ImagePath"));
				event.setRestriction(rs.getString("Restriction"));
				event.setPosterUserId(rs.getInt("PostedUserId"));
				event.setStatus(rs.getString("Status"));
				event.setReviewNote(rs.getString("ReviewNote"));
				
				event.setSponsorName(rs.getString("SponsorName"));
	            event.setSponsorContact(rs.getString("SponsorContact"));
	            event.setSponsorEmail(rs.getString("SponsorEmail"));
	            
				upcomingEvents.add(event);
			}
		}
		catch(SQLException e) {
			System.err.println("Error found while getting upcoming events:" + e);
		}
		
		return upcomingEvents;
	}
	
	public EventModel getEventData(HttpServletRequest req, int eventId, int userId) {
		EventModel event = new EventModel();
		
		if(this.dbConn == null) {
			System.err.println("Error while fetching upcoming events: Database connection not found.");
			return null;
		}
		
		String getEventDataQuery = "SELECT e.*, i.UserId AS Interested, u.FullName AS PostedBy FROM event e "
				+ "LEFT JOIN event_interested_users i ON e.EventId = i.EventId AND i.UserId = ? "
				+ "JOIN user u ON e.PostedUserId = u.UserId "
				+ "WHERE e.EventId = ?";
		
		try(PreparedStatement getEventDataStmt = dbConn.prepareStatement(getEventDataQuery)){
			getEventDataStmt.setInt(1, userId);
			getEventDataStmt.setInt(2, eventId);
			
			ResultSet rs = getEventDataStmt.executeQuery();
			
			if(rs.next()) {		
				event.setId(rs.getInt("EventId"));
				event.setName(rs.getString("EventName"));
				event.setStartDate(rs.getDate("StartDate").toLocalDate());
				event.setEndDate(rs.getDate("EndDate").toLocalDate());
				event.setPostDate(rs.getDate("PostDate").toLocalDate());
				event.setLocation(rs.getString("EventLocation"));
				event.setDescription(rs.getString("Description"));
				event.setImagePath(rs.getString("ImagePath"));
				event.setRestriction(rs.getString("Restriction"));
				event.setPosterUserId(rs.getInt("PostedUserId"));
				event.setPostedUserName(rs.getString("PostedBy"));
				event.setStatus(rs.getString("Status"));
				event.setReviewNote(rs.getString("ReviewNote"));
				
				event.setSponsorName(rs.getString("SponsorName"));
	            event.setSponsorContact(rs.getString("SponsorContact"));
	            event.setSponsorEmail(rs.getString("SponsorEmail"));
	            
	            Boolean isInterested = rs.getObject("Interested") != null;
	            event.setInterested(isInterested);
	            
	            InterestedModel interestedUsers = getInterestedUsersForEvent(rs.getInt("EventId"), rs.getInt("PostedUserId"));
				event.setInterestedUsers(interestedUsers);
			}
			else {
				SessionUtil.setAttribute(req, "popupMessage", "Event not found");
				SessionUtil.setAttribute(req, "popupType", "error");
				return null;
			}
		}
		catch(SQLException e) {
			System.err.println("Error found while getting data:" + e);
			SessionUtil.setAttribute(req, "popupMessage", "Error found while getting data");
			SessionUtil.setAttribute(req, "popupType", "error");
			return null;
		}
		
		return event;
	}
	
    private String validateEventData(EventModel event, boolean isUpdate) {
        if (event.getName() == null || event.getName().trim().isEmpty()) return "Event Title cannot be empty.";
        if (event.getStartDate() == null) return "Start Date cannot be empty.";
        if (event.getEndDate() == null) return "End Date cannot be empty.";
        if (event.getLocation() == null || event.getLocation().trim().isEmpty()) return "Event Location cannot be empty.";
        if (event.getDescription() == null || event.getDescription().trim().isEmpty()) return "Event Description cannot be empty.";

        if (event.getName().length() > 30) return "Event Title cannot exceed 30 characters.";
        if (event.getDescription().length() > 2000) return "Event Description cannot exceed 2000 characters.";

        if (event.getStartDate().isAfter(event.getEndDate())) {
            return "Start Date cannot be after End Date.";
        }

        String typedSponsorName = sponsorName != null ? sponsorName.trim() : "";
        String typedSponsorContact = sponsorContact != null ? sponsorContact.trim() : "";
        String typedSponsorEmail = sponsorEmail != null ? sponsorEmail.trim() : "";

        boolean anySponsorInfoProvided = !typedSponsorName.isEmpty() || !typedSponsorContact.isEmpty() || !typedSponsorEmail.isEmpty();

        if (anySponsorInfoProvided) {
            if (typedSponsorName.isEmpty()) {
                return "Sponsor Name is required if any sponsor details are provided.";
            }
            if (typedSponsorEmail.isEmpty()) {
                return "Sponsor Email is required if any sponsor details are provided.";
            }
        }
        return null;
    }
    
 // Method to remove an interested user from an event
 	public String removeInterestedUser(int userId, int eventId) {
         if (this.dbConn == null) {
             return "Error while connecting to the database.";
         }
         String sql = "DELETE FROM event_interested_users WHERE UserId = ? AND EventId = ?";
         try (PreparedStatement pstmt = dbConn.prepareStatement(sql)) {
             pstmt.setInt(1, userId);
             pstmt.setInt(2, eventId);
             int rowsAffected = pstmt.executeUpdate();

             if (rowsAffected > 0) {
                 return "Successfully removed interest";
             } else {
                 return "No record found for user and event.";
             }
         } catch (SQLException e) {
             System.err.println("Occasio.EventService.addInterestedUser: Error adding user to event: " + e.getMessage());
             e.printStackTrace();
             return "An error occurred while removing your interest";
         }
     }
 	
     // Method to add an interested user to an event
     public String addInterestedUser(int userId, int eventId) {
         if (this.dbConn == null) {
             return "Error while connecting to the database.";
         }

         String sql = "INSERT INTO event_interested_users (UserId, EventId) VALUES (?, ?)";
         try (PreparedStatement pstmt = dbConn.prepareStatement(sql)) {
             pstmt.setInt(1, userId);
             pstmt.setInt(2, eventId);
             int rowsAffected = pstmt.executeUpdate();

             if (rowsAffected > 0) {
                 return "Successfully confirmed interest";
             } else {
                 return "An error occurred while confirming your interest. Please try again later.";
             }
         } catch (SQLException e) {
             System.err.println("Occasio.EventService.addInterestedUser: Error adding user to event: " + e.getMessage());
             e.printStackTrace();
             return "An error occurred while confirming your interest";
         }
     }
}