package com.occasio.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.occasio.config.DbConfig;
import com.occasio.model.UserModel;

/*
 * Register Service Class handles the registration of new users. 
 * It adds the provided information into the users table in the database.
*/

public class RegisterService {
	
	private Connection dbConn;
	
	/*
	 * Initializing the database connection via constructor
	*/
	public RegisterService() {
		try {
			this.dbConn = DbConfig.getDbConnection();
		}
		catch(SQLException | ClassNotFoundException ex) {
			System.err.println("Database connection error: " + ex.getMessage());
			ex.printStackTrace();
		}
	}
	
	public String addUser(UserModel userModel) {
		if(this.dbConn == null) {
			System.err.println("Database connection not found.");
			return "Error while connecting to database";
		}
		
		String getOrgQuery = "SELECT OrgName FROM organization WHERE OrgId = ?";
		String insertUserQuery = "INSERT INTO user (FullName, UserEmail, Role, Password, DateJoined, PhoneNumber, ProfilePicturePath, OrgId) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		try (PreparedStatement getOrgStmt=dbConn.prepareStatement(getOrgQuery);
			 PreparedStatement insertUserStmt=dbConn.prepareStatement(insertUserQuery)){
			
			//Get Organization Id
			getOrgStmt.setInt(1, userModel.getOrgId());
			ResultSet result = getOrgStmt.executeQuery();
			if(result.next()) {
				//If organization id found add the details of user in insert statement
				insertUserStmt.setString(1, userModel.getFullName());
				insertUserStmt.setString(2, userModel.getEmail());
				insertUserStmt.setString(3, userModel.getRole());
				insertUserStmt.setString(4, userModel.getPassword());
				insertUserStmt.setDate(5, Date.valueOf(userModel.getDateJoined()));
				insertUserStmt.setString(6, userModel.getPhoneNumber());
				insertUserStmt.setString(7, userModel.getProfilePicturePath());
				insertUserStmt.setInt(8, userModel.getOrgId());
				
				if(insertUserStmt.executeUpdate() > 0) {
					return "Successfully Added User";
				}
				else {
					return "An error occured while registering user.";
				}
			}
			else {
				System.err.println("OrgId " + String.valueOf(userModel.getOrgId()) + " not found.");
				return "Provided Organization Id does not exist. Please recheck and try again";
			}
		}
		catch(SQLException e) {
			System.err.println("Error while user registration: " + e.getMessage());
			e.printStackTrace();
			return "An error occured while registering user.";
		}
		
	}
}
