package com.occasio.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.occasio.config.DbConfig;
import com.occasio.model.EventModel;

public class EventRequestService {

    private Connection dbConn;

    public EventRequestService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("EventManagementService: Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
    
    public List<EventModel> getAllEvents(int orgId) {
        if (this.dbConn == null) {
            System.err.println("EventManagementService.getAllEvents: Database connection not found.");
            return new ArrayList<>();
        }

        List<EventModel> events = new ArrayList<>();
        String sql = "SELECT e.* FROM event e JOIN user u ON e.postedUserId = u.userId WHERE u.orgId = ? AND e.status = 'pending'"; // Removed WHERE clause

        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
        	stmt.setInt(1, orgId);
            System.out.println("Executing SQL query: " + sql); // Log the SQL query
            ResultSet rs = stmt.executeQuery();
            int rowCount = 0; // Track the number of rows retrieved

            while (rs.next()) {
                EventModel event = new EventModel();
                event.setId(rs.getInt("eventid"));
                event.setName(rs.getString("eventname"));
                if(rs.getDate("startDate")!=null)
                	event.setStartDate(rs.getDate("startDate").toLocalDate());
                if(rs.getDate("endDate")!=null)
                	event.setEndDate(rs.getDate("endDate").toLocalDate());
                if(rs.getDate("postDate")!=null)
                	event.setPostDate(rs.getDate("postDate").toLocalDate());
                event.setDescription(rs.getString("description"));
                event.setImagePath(rs.getString("imagePath"));
                event.setLocation(rs.getString("eventlocation"));
                event.setRestriction(rs.getString("restriction"));
                event.setPosterUserId(rs.getInt("postedUserId"));
                event.setStatus(rs.getString("status"));
                event.setReviewNote(rs.getString("reviewNote"));
                events.add(event);
                rowCount++; // Increment row count
            }

            System.out.println("Number of events retrieved: " + rowCount); // Log the row count
        } catch (SQLException e) {
            System.err.println("EventManagementService.getAllEvents: Error fetching events: " + e.getMessage());
            e.printStackTrace();
        }
        return events;
    }

    public List<EventModel> getAllPendingEvents() {
        if (this.dbConn == null) {
            System.err.println("EventManagementService.getAllPendingEvents: Database connection not found.");
            return new ArrayList<>();
        }

        List<EventModel> events = new ArrayList<>();
        String sql = "SELECT * FROM event WHERE status = 'pending'";

        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
        	System.out.println("*********\n\n*****Executing SQL query: " + sql);
        	
            ResultSet rs = stmt.executeQuery();
            int rowCount = 0;
            
            while (rs.next()) {
                EventModel event = new EventModel();
                event.setId(rs.getInt("id"));
                event.setName(rs.getString("name"));
                if(rs.getDate("startDate")!=null)
                	event.setStartDate(rs.getDate("startDate").toLocalDate());
                if(rs.getDate("endDate")!=null)
                	event.setEndDate(rs.getDate("endDate").toLocalDate());
                if(rs.getDate("postDate")!=null)
                	event.setPostDate(rs.getDate("postDate").toLocalDate());
                event.setDescription(rs.getString("description"));
                event.setImagePath(rs.getString("imagePath"));
                event.setLocation(rs.getString("location"));
                event.setRestriction(rs.getString("restriction"));
                event.setPosterUserId(rs.getInt("posterUserId"));
                event.setStatus(rs.getString("status"));
                event.setReviewNote(rs.getString("reviewNote"));
                events.add(event);
                rowCount++;
            }
            System.out.println("Number of pending events retrieved: " + rowCount);
        } catch (SQLException e) {
            System.err.println("EventManagementService.getAllPendingEvents: Error fetching events: " + e.getMessage());
            e.printStackTrace();
        }
        return events;
    }

    public String approveEvent(int eventId) {
        return updateEventStatus(eventId, "approved", null); // No review note for approval
    }

    public String rejectEvent(int eventId, String reviewNote) {
        return updateEventStatus(eventId, "rejected", reviewNote); // Include review note for rejection
    }

    private String updateEventStatus(int eventId, String status, String reviewNote) {
        if (this.dbConn == null) {
            System.err.println("EventManagementService.updateEventStatus: Database connection not found.");
            return "Error: Database Connection Failed";
        }

        String sql;
        if (reviewNote == null) {
            sql = "UPDATE event SET status = ?, reviewNote = null WHERE eventid = ?";
        } else {
            sql = "UPDATE event SET status = ?, reviewNote = ? WHERE eventid = ?";
        }

        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            stmt.setString(1, status);
            if (reviewNote != null) {
                stmt.setString(2, reviewNote);
                stmt.setInt(3, eventId);
            }
            else
            {
            	stmt.setInt(2, eventId);
            }

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return "Success: Event " + status + " successfully";
            } else {
                return "Error: Event not found or could not be updated";
            }
        } catch (SQLException e) {
            System.err.println("EventManagementService.updateEventStatus: Error updating event: " + e.getMessage());
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }
}