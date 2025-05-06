package com.occasio.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // Needed for the email check
import java.sql.SQLException;

import com.occasio.config.DbConfig;
import com.occasio.model.UserModel;
import com.occasio.util.PasswordUtil;

public class UserService {

    private Connection dbConn;

    public UserService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("UserService: Database connection error during initialization: " + ex.getMessage());
            ex.printStackTrace();
            this.dbConn = null;
        }
    }

    /**
     * Checks if an email address is already used by another user.
     *
     * @param email The email address to check.
     * @param currentUserId The ID of the user currently being updated (to exclude them from the check).
     * @return true if the email is taken by another user, false otherwise.
     */
    private boolean isEmailTakenByOtherUser(String email, int currentUserId) {
        if (this.dbConn == null || email == null || email.trim().isEmpty()) {
            return false; // Cannot check without connection or email
        }
        // Query to find if the email exists for any user OTHER than the current one
        String sql = "SELECT UserId FROM user WHERE UserEmail = ? AND UserId != ?";
        try (PreparedStatement pstmt = dbConn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            pstmt.setInt(2, currentUserId);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next(); // If rs.next() is true, it means another user has this email
            }
        } catch (SQLException e) {
            System.err.println("UserService.isEmailTakenByOtherUser: Error checking email existence - " + e.getMessage());
            e.printStackTrace();
            // Fail safely - assume email might be taken to prevent potential issues
            // Or you could throw an exception to indicate a check failure
            return true;
        }
    }

    public boolean updateUserProfile(UserModel userData, String newPassword) {

        if (this.dbConn == null) {
            System.err.println("UserService.updateUserProfile: Database connection is not available.");
            return false;
        }

        if (userData == null || userData.getUserId() <= 0) {
            System.err.println("UserService.updateUserProfile: Invalid user data or user ID provided.");
            return false;
        }

        // --- NEW: Email Clash Validation ---
        if (isEmailTakenByOtherUser(userData.getEmail(), userData.getUserId())) {
            System.err.println("UserService.updateUserProfile: Email '" + userData.getEmail() + "' is already taken by another user.");
            // Optionally set a specific error message attribute here for the controller
            return false; // Stop the update process
        }
        // --- End Email Clash Validation ---


        String hashedPassword = null;
        boolean updatePassword = false;

        if (newPassword != null && !newPassword.trim().isEmpty()) {
            try {
                hashedPassword = PasswordUtil.hashPassword(newPassword);
                updatePassword = true;
                System.out.println("UserService.updateUserProfile: New password provided for User ID " + userData.getUserId() + ", hashing...");
            } catch (IllegalArgumentException e) {
                System.err.println("UserService.updateUserProfile: Error hashing password - " + e.getMessage());
                return false;
            }
        } else {
             System.out.println("UserService.updateUserProfile: Password not changed for User ID " + userData.getUserId());
        }

        StringBuilder sqlBuilder = new StringBuilder("UPDATE user SET FullName = ?, UserEmail = ?, PhoneNumber = ?, ProfilePicturePath = ?");

        if (updatePassword) {
            sqlBuilder.append(", Password = ?");
        }
        sqlBuilder.append(" WHERE UserId = ?");
        String sql = sqlBuilder.toString();
        System.out.println("Executing SQL: " + sql);

        try (PreparedStatement pstmt = dbConn.prepareStatement(sql)) {
            int paramIndex = 1;
            pstmt.setString(paramIndex++, userData.getFullName());
            pstmt.setString(paramIndex++, userData.getEmail());
            pstmt.setString(paramIndex++, userData.getPhoneNumber());
            pstmt.setString(paramIndex++, userData.getProfilePicturePath());

            if (updatePassword) {
                pstmt.setString(paramIndex++, hashedPassword);
            }
            pstmt.setInt(paramIndex, userData.getUserId());

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("UserService.updateUserProfile: Successfully updated profile for User ID " + userData.getUserId());
                return true;
            } else {
                System.err.println("UserService.updateUserProfile: Update executed but 0 rows affected for User ID " + userData.getUserId() + ". User might not exist?");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("UserService.updateUserProfile: SQL error during profile update for User ID " + userData.getUserId() + " - " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("UserService.updateUserProfile: Unexpected error during profile update for User ID " + userData.getUserId() + " - " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}