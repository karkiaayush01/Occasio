package com.occasio.model;

import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;

/**
 * Represents an Event with details like name, dates, description,
 * poster info, sponsors, and interested users.
 */
public class EventModel {
	private int id;                       //unique event id
	private String name;                  //event name
	private LocalDate startDate;          //event start date
	private LocalDate endDate;            //event end date
	private LocalDate postDate;           //date when event was posted
	private String description;           //event description
	private String imagePath;             //path to event image
	private String location;              //event location
	private String restriction;           //age/gender/location restrictions
	private int posterUserId;             //user id who posted the event
	private String postedUserName;        //username of the poster
	private String status;                //event approval status
	private String reviewNote;            //admin's review note if any

	private List<SponsorModel> sponsors;  //list of sponsors associated with this event

	private Boolean interested;           //true if current user is interested
	private InterestedModel interestedUsers; //detailed list of users who are interested

	//default constructor
	public EventModel() {
		this.sponsors = new ArrayList<>(); //initializing sponsors list
	}

	//parameterized constructor
	public EventModel(int id, String name, LocalDate startDate, LocalDate endDate, LocalDate postDate,
            String description, String imagePath, String location, String restriction, int posterUserId,
            String status, String reviewNote)
	{
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
		this.sponsors = new ArrayList<>(); //initializing sponsors list
	}

	//getters and setters
	public int getId() { return id; }
	public void setId(int id) { this.id = id; }

	public String getName() { return name; }
	public void setName(String name) { this.name = name; }

	public LocalDate getStartDate() { return startDate; }
	public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

	public LocalDate getEndDate() { return endDate; }
	public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

	public LocalDate getPostDate() { return postDate; }
	public void setPostDate(LocalDate postDate) { this.postDate = postDate; }

	public String getDescription() { return description; }
	public void setDescription(String description) { this.description = description; }

	public String getImagePath() { return imagePath; }
	public void setImagePath(String imagePath) { this.imagePath = imagePath; }

	public String getLocation() { return location; }
	public void setLocation(String location) { this.location = location; }

	public String getRestriction() { return restriction; }
	public void setRestriction(String restriction) { this.restriction = restriction; }

	public int getPosterUserId() { return posterUserId; }
	public void setPosterUserId(int posterUserId) { this.posterUserId = posterUserId; }

	public String getStatus() { return status; }
	public void setStatus(String eventStatus) { this.status = eventStatus; }

	public String getReviewNote() { return reviewNote; }
	public void setReviewNote(String reviewNote) { this.reviewNote = reviewNote; }

	//sponsor list getter and setter
	public List<SponsorModel> getSponsors() { return sponsors; }
	public void setSponsors(List<SponsorModel> sponsors) { this.sponsors = sponsors; }

	//helper to add a sponsor to the list
	public void addSponsor(SponsorModel sponsor) {
		if (this.sponsors == null) {
			this.sponsors = new ArrayList<>();
		}
		this.sponsors.add(sponsor);
	}

	//getter and setter for interested (single user)
	public Boolean getInterested() { 
		return interested; 
	}
	public void setInterested(Boolean interested) { 
		this.interested = interested; 
	}

	//getter and setter for all interested users
	public InterestedModel getInterestedUsers() { 
		return interestedUsers; 
	}
	public void setInterestedUsers(InterestedModel interestedUsers) { 
		this.interestedUsers = interestedUsers; 
	}

	//getter and setter for name of user who posted the event
	public String getPostedUserName() { return postedUserName; }
	
	public void setPostedUserName(String postedUserName) { 
		this.postedUserName = postedUserName; 
	}
}
