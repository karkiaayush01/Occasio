package com.occasio.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.occasio.config.DbConfig;
import com.occasio.model.EventModel;
import com.occasio.model.InterestedModel;

public class EventService {
	private Connection dbConn;
	
	public EventService() {
		try {
			this.dbConn = DbConfig.getDbConnection();
		}
		catch(SQLException | ClassNotFoundException ex) {
			System.err.println("Database connection error: " + ex.getMessage());
			ex.printStackTrace();
		}
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
                    event.setSponsorName(rs.getString("SponsorName"));
                    event.setSponsorContact(rs.getString("SponsorContact"));
                    event.setSponsorEmail(rs.getString("SponsorEmail"));
                }
            }
        } catch (SQLException e) {
            System.err.println("EventService.getEventById: Error fetching event with ID " + eventId + " - " + e.getMessage());
            e.printStackTrace();
        }
        return event;
    }
	
	public String addEvent(EventModel eventModel) {
	    if (this.dbConn == null) {
	        return "Error while connecting to database";
	    }

	    String validationError = validateEventData(eventModel, false);
	    if (validationError != null) {
	        return validationError;
	    }

	    String insertEventQuery = "INSERT INTO event (EventName, StartDate, EndDate, PostDate, Description, ImagePath, EventLocation, Restriction, PostedUserId, Status, ReviewNote, SponsorName, SponsorContact, SponsorEmail) "
	            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    try (PreparedStatement addEventStmt = dbConn.prepareStatement(insertEventQuery)) {
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

	        addEventStmt.setString(paramIndex++, eventModel.getSponsorName());
	        addEventStmt.setString(paramIndex++, eventModel.getSponsorContact());
	        addEventStmt.setString(paramIndex++, eventModel.getSponsorEmail());

	        int rowsAffected = addEventStmt.executeUpdate();

	        if (rowsAffected > 0) {
	             return "Successfully added event";
	        } else {
	            return "An error occurred while adding event (Insertion Failed).";
	        }

	    } catch (SQLException e) {
	        System.err.println("Error while adding event: " + e.getMessage());
	        e.printStackTrace();
	        return "An error occurred while adding event. Please try again later.";
	    }
	}
	
	public String updateEvent(EventModel eventModel) {
        if (this.dbConn == null) {
           return "Database connection error.";
       }
       if (eventModel == null || eventModel.getId() <= 0) {
            return "Invalid event data or missing Event ID for update.";
       }

       String validationError = validateEventData(eventModel, true);
       if (validationError != null) {
           return validationError;
       }

       StringBuilder sqlBuilder = new StringBuilder("UPDATE event SET EventName = ?, StartDate = ?, EndDate = ?, Description = ?, EventLocation = ?, Restriction = ?, SponsorName = ?, SponsorContact = ?, SponsorEmail = ?");

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
           pstmt.setString(paramIndex++, eventModel.getSponsorName());
           pstmt.setString(paramIndex++, eventModel.getSponsorContact());
           pstmt.setString(paramIndex++, eventModel.getSponsorEmail());

           if (updateImage) {
                pstmt.setString(paramIndex++, eventModel.getImagePath());
           }

           pstmt.setInt(paramIndex, eventModel.getId());

           int rowsAffected = pstmt.executeUpdate();

           if (rowsAffected > 0) {
                return "Successfully updated event";
           } else {
               return "Event update failed (Event not found or no changes made).";
           }
       } catch (SQLException e) {
           System.err.println("Error updating event: " + e.getMessage());
           e.printStackTrace();
           return "An error occurred during event update.";
       }
   }
	
	public ArrayList<EventModel> getEventsByUser(int userId) {
		ArrayList<EventModel> userEvents = new ArrayList<>();
		
		if(this.dbConn == null) {
			System.err.println("Error while fetching user events: Database connection not found.");
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
				
				event.setSponsorName(rs.getString("SponsorName"));
	            event.setSponsorContact(rs.getString("SponsorContact"));
	            event.setSponsorEmail(rs.getString("SponsorEmail"));
				
				userEvents.add(event);
			}
		} 
		catch(SQLException e) {
			System.err.println("Error found while getting user events:" + e);
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
			System.err.println("Error found while getting interested user for event: " + String.valueOf(eventId) + e);
		}
		
		return totalInterested;
	}
	
	public ArrayList<EventModel> getOngoingEvents(int userId, int orgId){
		ArrayList<EventModel> ongoingEvents = new ArrayList<>();
		
		if(this.dbConn == null) {
			System.err.println("Error while fetching ongoing events: Database connection not found.");
			return null;
		}

		/*
		 * After getting the organizationId, all the ongoing events for this orgainzation are retrieved.
		 * This includes any event where startDate is earlier and end date is later than current date.
		 * The events must be aproved
		 */
		
		LocalDate currentDate = LocalDate.now();
		
		String getOngoingEventsQuery = "SELECT e.*, i.UserId AS Interested FROM event e JOIN user u ON e.PostedUserId = u.UserId LEFT JOIN event_interested_users i ON e.EventId = i.EventId AND i.UserId = ? WHERE u.OrgId = ?  AND e.Status = ? AND StartDate <= ? AND EndDate >= ?";
		
		try(PreparedStatement getOngoingEventsStmt = dbConn.prepareStatement(getOngoingEventsQuery)){
			getOngoingEventsStmt.setInt(1, userId);
			getOngoingEventsStmt.setInt(2, orgId);
			getOngoingEventsStmt.setString(3, "pending");
			getOngoingEventsStmt.setDate(4, Date.valueOf(currentDate));
			getOngoingEventsStmt.setDate(5, Date.valueOf(currentDate));
			
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
				
				event.setSponsorName(rs.getString("SponsorName"));
	            event.setSponsorContact(rs.getString("SponsorContact"));
	            event.setSponsorEmail(rs.getString("SponsorEmail"));
	            
	            Boolean isInterested = rs.getObject("Interested") != null;
	            event.setInterested(isInterested);
	            
	            InterestedModel interestedUsers = getInterestedUsersForEvent(rs.getInt("EventId"), rs.getInt("PostedUserId"));
				event.setInterestedUsers(interestedUsers);
	            
				ongoingEvents.add(event);
			}
		}
		catch(SQLException e) {
			System.err.println("Error found while getting ongoing events:" + e);
		}
		
		return ongoingEvents;
	}
	
    private String validateEventData(EventModel event, boolean isUpdate) {
        if (event.getName() == null || event.getName().trim().isEmpty()) return "Event Title cannot be empty.";
        if (event.getStartDate() == null) return "Start Date cannot be empty.";
        if (event.getEndDate() == null) return "End Date cannot be empty.";
        if (event.getLocation() == null || event.getLocation().trim().isEmpty()) return "Event Location cannot be empty.";
        if (event.getDescription() == null || event.getDescription().trim().isEmpty()) return "Event Description cannot be empty.";

        if (event.getName().length() > 30) return "Event Title cannot exceed 30 characters.";
        if (event.getDescription().length() > 100) return "Event Description cannot exceed 100 characters.";

        if (event.getStartDate().isAfter(event.getEndDate())) {
            return "Start Date cannot be after End Date.";
        }

        String sponsorName = event.getSponsorName() != null ? event.getSponsorName().trim() : "";
        String sponsorContact = event.getSponsorContact() != null ? event.getSponsorContact().trim() : "";
        String sponsorEmail = event.getSponsorEmail() != null ? event.getSponsorEmail().trim() : "";

        boolean nameProvided = !sponsorName.isEmpty();
        boolean contactProvided = !sponsorContact.isEmpty();
        boolean emailProvided = !sponsorEmail.isEmpty();

        if ((contactProvided || emailProvided) && !nameProvided) {
            return "Sponsor Name is required if Sponsor Contact or Sponsor Email is provided.";
        }

        return null;
    }
}
