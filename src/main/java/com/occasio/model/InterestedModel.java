package com.occasio.model;
import java.util.ArrayList;

public class InterestedModel {
	private int eventId;
	private ArrayList<String> interestedUsersPicturePaths;
	private int totalInterestedCount;
	
	public InterestedModel() {
		super();
	}

	public InterestedModel(int eventId, ArrayList<String> interestedUsersPicturePaths, int totalInterestedCount) {
		super();
		this.eventId = eventId;
		this.interestedUsersPicturePaths = interestedUsersPicturePaths;
		this.totalInterestedCount = totalInterestedCount;
	}

	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	public ArrayList<String> getInterestedUsersPicturePaths() {
		return interestedUsersPicturePaths;
	}

	public void setInterestedUsersPicturePaths(ArrayList<String> interestedUsersPicturePaths) {
		this.interestedUsersPicturePaths = interestedUsersPicturePaths;
	}

	public int getTotalInterestedCount() {
		return totalInterestedCount;
	}

	public void setTotalInterestedCount(int totalInterestedCount) {
		this.totalInterestedCount = totalInterestedCount;
	}
}
