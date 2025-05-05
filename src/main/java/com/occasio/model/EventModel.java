/*
 * @author Occasio Team
 */

package com.occasio.model;

import java.time.LocalDate;

public class EventModel {
	private int eventId;
	private String eventName;
	private LocalDate startdate;
	private LocalDate endDate;
	private LocalDate postDate;
	private String eventDescription;
	private String eventImagePath;
	private String eventLocation;
	private String restriction;
	private int posterUserId;
	private String eventStatus;
	private String reviewNote;
	
	public EventModel() {
		
	}
	
	public EventModel(int eventId, String eventName, LocalDate startdate, LocalDate endDate, LocalDate postDate,
			String eventDescription, String eventImagePath, String eventLocation, String restriction, int posterUserId,
			String eventStatus, String reviewNote) {
		super();
		this.eventId = eventId;
		this.eventName = eventName;
		this.startdate = startdate;
		this.endDate = endDate;
		this.postDate = postDate;
		this.eventDescription = eventDescription;
		this.eventImagePath = eventImagePath;
		this.eventLocation = eventLocation;
		this.restriction = restriction;
		this.posterUserId = posterUserId;
		this.eventStatus = eventStatus;
		this.reviewNote = reviewNote;
	}

	public int getEventId() {
		return eventId;
	}
	
	public void setEventId(int eventId) {
		this.eventId = eventId;
	}
	
	public String getEventName() {
		return eventName;
	}
	
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	
	public LocalDate getStartdate() {
		return startdate;
	}
	public void setStartdate(LocalDate startdate) {
		this.startdate = startdate;
	}
	
	public LocalDate getEndDate() {
		return endDate;
	}
	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}
	
	public LocalDate getPostDate() {
		return postDate;
	}
	public void setPostDate(LocalDate postDate) {
		this.postDate = postDate;
	}
	
	public String getEventDescription() {
		return eventDescription;
	}
	public void setEventDescription(String eventDescription) {
		this.eventDescription = eventDescription;
	}
	
	public String getEventImagePath() {
		return eventImagePath;
	}
	
	public void setEventImagePath(String eventImagePath) {
		this.eventImagePath = eventImagePath;
	}
	public String getEventLocation() {
		return eventLocation;
	}
	
	public void setEventLocation(String eventLocation) {
		this.eventLocation = eventLocation;
	}
	
	public String getRestriction() {
		return restriction;
	}
	
	public void setRestriction(String restriction) {
		this.restriction = restriction;
	}
	
	public int getPosterUserId() {
		return posterUserId;
	}
	
	public void setPosterUserId(int posterUserId) {
		this.posterUserId = posterUserId;
	}
	
	public String getEventStatus() {
		return eventStatus;
	}
	
	public void setEventStatus(String eventStatus) {
		this.eventStatus = eventStatus;
	}

	public String getReviewNote() {
		return reviewNote;
	}

	public void setReviewNote(String reviewNote) {
		this.reviewNote = reviewNote;
	}
	
	

}
