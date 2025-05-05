package com.occasio.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import com.occasio.config.DbConfig;
import com.occasio.model.EventModel;

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
	
	public String addEvent(EventModel eventModel) {
		if(this.dbConn == null) {
			System.err.println("Database connection not found.");
			return "Error while connecting to database";
		}
		
		String insertEventQuery = "INSERT INTO event (EventName, StartDate, EndDate, PostDate, Description, ImagePath, EventLocation, Restriction, PostedUserId, Status, ReviewNote) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try(PreparedStatement addEventStmt = dbConn.prepareStatement(insertEventQuery)) {
			addEventStmt.setString(1, eventModel.getName());
			addEventStmt.setDate(2, Date.valueOf(eventModel.getStartDate()));
			addEventStmt.setDate(3, Date.valueOf(eventModel.getEndDate()));
			addEventStmt.setDate(4, Date.valueOf(eventModel.getPostDate()));
			addEventStmt.setString(5, eventModel.getDescription());
			addEventStmt.setString(6, eventModel.getImagePath());
			addEventStmt.setString(7, eventModel.getLocation());
			addEventStmt.setString(8, eventModel.getRestriction());
			addEventStmt.setInt(9, eventModel.getPosterUserId());
			addEventStmt.setString(10, eventModel.getStatus());
			addEventStmt.setString(11, eventModel.getReviewNote());
			
			int rowsAffected = addEventStmt.executeUpdate();
			
			if(rowsAffected > 0) {
				return "Successfully added event.";
			}
			else {
				return "An error occured while adding event (Insertion Failed).";
			}
			
		} catch(SQLException e) {
			System.err.println("Error while adding event: " + e.getMessage());
			e.printStackTrace();
			return "An error occurred while adding event. Please try again later.";
		}
	}
	
	public ArrayList<EventModel> getEventsByUser(int userId) {
		ArrayList<EventModel> userEvents = new ArrayList<>();
		
		if(this.dbConn == null) {
			System.err.println("Database connection not found.");
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
				
				userEvents.add(event);
			}
		} 
		catch(SQLException e) {
			System.err.println("Error found while getting user events:" + e);
			return null;
		}
		
		return userEvents;
	}
}
