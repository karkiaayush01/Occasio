/*
 * @author Occasio Team
 */

package com.occasio.model;

import java.time.LocalDate;

public class EventModel {
	private int id;
	private String name;
	private LocalDate startDate;
	private LocalDate endDate;
	private LocalDate postDate;
	private String description;
	private String imagePath;
	private String location;
	private String restriction;
	private int posterUserId;
	private String status;
	private String reviewNote;
	
	public EventModel() {
		
	}
	
	public EventModel(int id, String name, LocalDate startDate, LocalDate endDate, LocalDate postDate,
			String description, String imagePath, String location, String restriction, int posterUserId,
			String status, String reviewNote) {
		super();
		this.id = id;
		this.name = name;
		this.startDate = startDate;
		this.endDate = endDate;
		this.postDate = postDate;
		this.description = description;
		this.imagePath = imagePath;
		this.location = location;
		this.restriction = restriction;
		this.posterUserId = posterUserId;
		this.status = status;
		this.reviewNote = reviewNote;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public LocalDate getStartDate() {
		return startDate;
	}
	
	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
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
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getImagePath() {
		return imagePath;
	}
	
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getLocation() {
		return location;
	}
	
	public void setLocation(String location) {
		this.location = location;
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
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String eventStatus) {
		this.status = eventStatus;
	}

	public String getReviewNote() {
		return reviewNote;
	}

	public void setReviewNote(String reviewNote) {
		this.reviewNote = reviewNote;
	}
	
	

}
