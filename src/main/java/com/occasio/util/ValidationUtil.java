package com.occasio.util;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.sql.Connection;

import com.occasio.config.DbConfig;

public class ValidationUtil {
	private Connection dbConn;
	
	public ValidationUtil() {
		try {
			this.dbConn = DbConfig.getDbConnection();
		}
		catch(SQLException | ClassNotFoundException ex) {
			System.err.println("Database connection error: " + ex.getMessage());
			ex.printStackTrace();
		}
	}
	
	/**
     * Checks if an email address is already registered in the database.
     * @param email The email address to check.
     * @return True if the email is already registered, false otherwise.
     */
	public boolean isEmailAlreadyRegistered(String email) {
        String checkEmailQuery = "SELECT UserEmail FROM user WHERE UserEmail = ?";
        try (PreparedStatement checkStmt = dbConn.prepareStatement(checkEmailQuery)) {
            checkStmt.setString(1, email);
            ResultSet resultSet = checkStmt.executeQuery();
            // Check If Result Set Is Empty
            return resultSet.next(); // Returns true if a user with this email exists
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
            return true; // Assume email exists to prevent duplicate creation in case of error
        }
    }
	
	 /**
     * Checks if a given string is a valid email address based on a simple regex.
     * @param email The email address to validate.
     * @return True if the email is valid, false otherwise.
     */
	 public boolean isValidEmail(String email) {
        // Basic email validation regex
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    /**
     * Checks if a given string is a valid phone number based on a simple regex.
     * @param phoneNumber The phone number to validate.
     * @return True if the phone number is valid, false otherwise.
     */
    public boolean isValidPhoneNumber(String phoneNumber) {
        // Basic phone number validation regex (allows digits, spaces, hyphens, parentheses)
        String phoneRegex = "^[\\d\\s\\-\\(\\)]+$";
        Pattern pattern = Pattern.compile(phoneRegex);
        Matcher matcher = pattern.matcher(phoneNumber);
        return matcher.matches();
    }
}