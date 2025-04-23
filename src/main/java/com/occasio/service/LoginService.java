package com.occasio.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.time.LocalDate;

import com.occasio.config.DbConfig;
import com.occasio.model.UserModel;
import com.occasio.util.PasswordUtil;

public class LoginService {

    /**
     * Attempts to authenticate a user.
     * @param email Provided email.
     * @param password Provided plain-text password.
     * @return Populated UserModel object if authentication is successful, otherwise null.
     */
    public UserModel authenticateUser(String email, String password) {
        UserModel user = null;
        String sql = "SELECT UserId, FullName, UserEmail, Password, Role, DateJoined, PhoneNumber, ProfilePicturePath, OrgId " +
                     "FROM user WHERE UserEmail = ?";

        if (email == null || email.trim().isEmpty() || password == null || password.isEmpty()) {
            return null;
        }

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) { // User found
                    String storedHashedPassword = rs.getString("Password");

                    // Verify password
                    if (PasswordUtil.checkPassword(password, storedHashedPassword)) {
                        // Password matches - Populate UserModel
                        user = new UserModel();
                        // int userId = rs.getInt("UserId");
                        user.setFullName(rs.getString("FullName"));
                        user.setEmail(rs.getString("UserEmail"));
                        // Do NOT set the password hash in the session model object
                        user.setRole(rs.getString("Role"));
                        java.sql.Date dbDate = rs.getDate("DateJoined");
                        if (dbDate != null) {
                             user.setDateJoined(dbDate.toLocalDate());
                        }
                        user.setPhoneNumber(rs.getString("PhoneNumber"));
                        user.setProfilePicturePath(rs.getString("ProfilePicturePath"));
                        user.setOrgId(rs.getInt("OrgId"));
                    }
                }
            } // ResultSet closed

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Database error during authentication: " + e.getMessage());
            e.printStackTrace();
            user = null;
        } catch (Exception e) {
             System.err.println("Unexpected error during authentication: " + e.getMessage());
             e.printStackTrace();
             user = null;
        }
        return user; // Return populated user object or null
    }
}