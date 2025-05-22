package com.occasio.model;

import java.time.LocalDate;

/**
 * Model class representing an organization and its admin details.
 */
public class OrganizationModel {
	private int id;                        //organization id
	private String name;                   //organization name
	private LocalDate onboardedDate;       //date when the organization joined
	private String status;                 //approval/active status
	private String adminName;              //organization admin's name
	private String adminEmail;             //admin's email
	private String adminPassword;          //admin's password (should not be stored in plain text)

	//default constructor
	public OrganizationModel() {
		super();
	}

	//full constructor
	public OrganizationModel(int id, String name, LocalDate onboardedDate, String status,
							 String adminName, String adminEmail, String adminPassword) {
		this.id = id;
		this.name = name;
		this.onboardedDate = onboardedDate;
		this.status = status;
		this.adminName = adminName;
		this.adminEmail = adminEmail;
		this.adminPassword = adminPassword;
	}

	//constructor with minimal details
	public OrganizationModel(int id, String name, String adminName) {
		this.id = id;
		this.name = name;
		this.adminName = adminName;
	}

	//getter and setter for id
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	//getter and setter for name
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	//getter and setter for onboardedDate
	public LocalDate getOnboardedDate() {
		return onboardedDate;
	}
	public void setOnboardedDate(LocalDate onboardedDate) {
		this.onboardedDate = onboardedDate;
	}

	//getter and setter for status
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	//getter and setter for admin name
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	//getter and setter for admin email
	public String getAdminEmail() {
		return adminEmail;
	}
	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}

	//getter and setter for admin password
	public String getAdminPassword() {
		return adminPassword;
	}
	public void setAdminPassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}
}