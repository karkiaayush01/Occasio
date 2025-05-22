package com.occasio.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.occasio.config.DbConfig;
import com.occasio.model.UserModel;
import com.occasio.util.PasswordUtil;
import com.occasio.util.ValidationUtil;

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
	
	/**
	 * Adds a new user to the database.
	 * @param userModel The UserModel object containing the user's data.
	 * @return A string indicating the success or failure of the operation.
	 */
	public String addUser(UserModel userModel) {
		if(this.dbConn == null) {
			System.err.println("Database connection not found.");
			return "Error while connecting to database";
		}
		
		ValidationUtil validationUtil = new ValidationUtil();
		
		// Check if the email already exists
        if (validationUtil.isEmailAlreadyRegistered(userModel.getEmail())) {
            return "Email address already exists. Please use a different email.";
        }
		
		String getOrgQuery = "SELECT OrgName FROM organization WHERE OrgId = ? AND OrgId!=1 AND Status!='Deleted'";
		String insertUserQuery = "INSERT INTO user (FullName, UserEmail, Role, Password, DateJoined, PhoneNumber, ProfilePicturePath, OrgId) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		try (PreparedStatement getOrgStmt = dbConn.prepareStatement(getOrgQuery);
	             PreparedStatement insertUserStmt = dbConn.prepareStatement(insertUserQuery)) {

				//Check Organization Id validity first
				getOrgStmt.setInt(1, userModel.getOrgId());
				try (ResultSet result = getOrgStmt.executeQuery()) {
					// Check if the organization ID is valid
					if(!result.next()) {
						System.err.println("OrgId " + userModel.getOrgId() + " not found.");
						return "Provided Organization ID does not exist. Please recheck and try again.";
					}
				}

				insertUserStmt.setString(1, userModel.getFullName());
				insertUserStmt.setString(2, userModel.getEmail());
				insertUserStmt.setString(3, userModel.getRole());

				// --- Hash the Password ---
				String plainPassword = userModel.getPassword();
				//Check If Password Is Null
				if (plainPassword == null || plainPassword.isEmpty()) {
					return "Password cannot be empty.";
				}
				String hashedPassword = PasswordUtil.hashPassword(plainPassword);
				insertUserStmt.setString(4, hashedPassword);

				insertUserStmt.setDate(5, Date.valueOf(userModel.getDateJoined()));
				insertUserStmt.setString(6, userModel.getPhoneNumber());
				insertUserStmt.setString(7, userModel.getProfilePicturePath());
				insertUserStmt.setInt(8, userModel.getOrgId());

				int rowsAffected = insertUserStmt.executeUpdate();

				// Check If User Inserted
				if(rowsAffected > 0) {
					return "Successfully Added User";
				} else {
					System.err.println("User insertion failed, executeUpdate returned 0 rows affected.");
					return "An error occurred while registering user (insertion failed).";
				}

			} catch(SQLException e) {
				System.err.println("Error during user registration: " + e.getMessage());
				e.printStackTrace();
				return "An error occurred during registration. Please try again later.";
			} catch (IllegalArgumentException e) {
	            System.err.println("Error hashing password: " + e.getMessage());
	            return "An error occurred during registration (password processing).";
	        }
		}
}