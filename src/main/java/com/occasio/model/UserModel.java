/*
 * @author Occasio Team
*/

package com.occasio.model;

/*
 * Importing LocalDate from the java.time Class.
 * Used to manuaaly add a joined date for each user.
*/
import java.time.LocalDate;

/*
 * UserModel is a class that contains configurations about a particular user.
 * It contains all the instance variables required for a user's data.
 * The constructor creates a UserModelObject with provided values
 * The getter and setter methods are created to set or get a particular instance variable.
*/

public class UserModel {
	private int userId;
	private String fullName;
	private String email;
	private String role;
	private String password;
	private LocalDate dateJoined;
	private String phoneNumber;
	private int orgId;
	private String profilePicturePath;
	private String eventReviewNote;
	
	public UserModel() {	
	}

	public UserModel(String fullName, String email, String role, String password, String phoneNumber, int orgId) {
		super();
		this.fullName = fullName;
		this.email = email;
		this.role = role;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.orgId = orgId;
	}

	public UserModel(String fullName, String email, String role, String password, String phoneNumber, int orgId, String profilePicturePath) {
		super();
		this.fullName = fullName;
		this.email = email;
		this.role = role;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.orgId = orgId;
		this.profilePicturePath = profilePicturePath;
	}
	
	
	/* Constructing user object with id */
	public UserModel(int userId, String fullName, String email, String role, String password, String phoneNumber, int orgId, String profilePicturePath) {
		super();
		this.userId = userId;
		this.fullName = fullName;
		this.email = email;
		this.role = role;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.orgId = orgId;
		this.profilePicturePath = profilePicturePath;
	}
	
	public int getUserId() {
		return this.userId;
	}
	
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public LocalDate getDateJoined() {
		return dateJoined;
	}

	public void setDateJoined(LocalDate dateJoined) {
		this.dateJoined = dateJoined;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public int getOrgId() {
		return orgId;
	}

	public void setOrgId(int orgId) {
		this.orgId = orgId;
	}

	public String getProfilePicturePath() {
		return profilePicturePath;
	}

	public void setProfilePicturePath(String profilePicturePath) {
		this.profilePicturePath = profilePicturePath;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEventReviewNote() {
		return eventReviewNote;
	}

	public void setEventReviewNote(String eventReviewNote) {
		this.eventReviewNote = eventReviewNote;
	}
}
