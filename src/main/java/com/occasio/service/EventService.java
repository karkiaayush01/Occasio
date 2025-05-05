package com.occasio.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.PreparedStatement;

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
			addEventStmt.setString(1, eventModel.getEventName());
			addEventStmt.setDate(2, Date.valueOf(eventModel.getStartdate()));
			addEventStmt.setDate(3, Date.valueOf(eventModel.getEndDate()));
			addEventStmt.setDate(4, Date.valueOf(eventModel.getPostDate()));
			addEventStmt.setString(5, eventModel.getEventDescription());
			addEventStmt.setString(6, eventModel.getEventImagePath());
			addEventStmt.setString(7, eventModel.getEventLocation());
			addEventStmt.setString(8, eventModel.getRestriction());
			addEventStmt.setInt(9, eventModel.getPosterUserId());
			addEventStmt.setString(10, eventModel.getEventStatus());
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
}
