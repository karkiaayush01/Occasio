package com.occasio.model;

import java.util.ArrayList;

/**
 * Model class to hold information about users interested in a particular event.
 */
public class InterestedModel {
	private int eventId;                                    //id of the event
	private ArrayList<String> interestedUsersPicturePaths;  //profile picture paths of interested users
	private int totalInterestedCount;                       //total number of interested users

	//default constructor
	public InterestedModel() {
		super();
	}

	//parameterized constructor
	public InterestedModel(int eventId, ArrayList<String> interestedUsersPicturePaths, int totalInterestedCount) {
		super();
		this.eventId = eventId;
		this.interestedUsersPicturePaths = interestedUsersPicturePaths;
		this.totalInterestedCount = totalInterestedCount;
	}

	//getter and setter for eventId
	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	//getter and setter for picture paths of interested users
	public ArrayList<String> getInterestedUsersPicturePaths() {
		return interestedUsersPicturePaths;
	}

	public void setInterestedUsersPicturePaths(ArrayList<String> interestedUsersPicturePaths) {
		this.interestedUsersPicturePaths = interestedUsersPicturePaths;
	}

	//getter and setter for total interested count
	public int getTotalInterestedCount() {
		return totalInterestedCount;
	}

	public void setTotalInterestedCount(int totalInterestedCount) {
		this.totalInterestedCount = totalInterestedCount;
	}
}
