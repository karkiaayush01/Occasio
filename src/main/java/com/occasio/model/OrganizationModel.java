package com.occasio.model;

import java.time.LocalDate;

public class OrganizationModel {
	private int id;
	private String name;
	private LocalDate onboardedDate;
	private String status;
	private String adminName;
	private String adminEmail;
	private String adminPassword;
	
	public OrganizationModel() {
		super();
	}

	public OrganizationModel(int id, String name, LocalDate onboardedDate, String status, String adminName,
			String adminEmail, String adminPassword) {
		super();
		this.id = id;
		this.name = name;
		this.onboardedDate = onboardedDate;
		this.status = status;
		this.adminName = adminName;
		this.adminEmail = adminEmail;
		this.adminPassword = adminPassword;
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

	public LocalDate getOnboardedDate() {
		return onboardedDate;
	}

	public void setOnboardedDate(LocalDate onboardedDate) {
		this.onboardedDate = onboardedDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getAdminEmail() {
		return adminEmail;
	}

	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}

	public String getAdminPassword() {
		return adminPassword;
	}

	public void setAdminPassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}

	public OrganizationModel(int id, String name, String adminName) {
		super();
		this.id = id;
		this.name = name;
		this.adminName = adminName;
	}
}
