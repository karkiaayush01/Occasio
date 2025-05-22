package com.occasio.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.occasio.config.DbConfig;
import com.occasio.model.UserModel;

public class UserManagementService {

    private Connection dbConn;

    public UserManagementService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("UserManagementService: Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public List<UserModel> getAllUsersInOrganization(int orgId) {
        if (this.dbConn == null) {
            System.err.println("UserManagementService.getAllUsersInOrganization: Database connection not found.");
            return new ArrayList<>();
        }

        List<UserModel> users = new ArrayList<>();
        String sql = "SELECT UserId, FullName, UserEmail, Role, PhoneNumber, OrgId, ProfilePicturePath " +
                     "FROM user " +
                     "WHERE OrgId = ? AND Role != 'superAdmin'"; // Exclude super admins

        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            stmt.setInt(1, orgId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                UserModel user = new UserModel();
                user.setUserId(rs.getInt("UserId"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("UserEmail"));
                user.setRole(rs.getString("Role"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setOrgId(rs.getInt("OrgId"));
                user.setProfilePicturePath(rs.getString("ProfilePicturePath"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("UserManagementService.getAllUsersInOrganization: Error fetching users: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    public String deleteUser(int userId) {
        if (this.dbConn == null) {
            System.err.println("UserManagementService.deleteUser: Database connection not found.");
            return "Error: Database Connection Failed";
        }

        String sql = "DELETE FROM user WHERE UserId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return "Success: User deleted successfully";
            } else {
                return "Error: User not found or could not be deleted";
            }
        } catch (SQLException e) {
            System.err.println("UserManagementService.deleteUser: Error deleting user: " + e.getMessage());
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }

    public String updateUser(UserModel user) {
        if (this.dbConn == null) {
            System.err.println("UserManagementService.updateUser: Database connection not found.");
            return "Error: Database Connection Failed";
        }

        String sql = "UPDATE user SET FullName = ?, UserEmail = ?, PhoneNumber = ? WHERE UserId = ?";

        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhoneNumber());
            stmt.setInt(4, user.getUserId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return "Success: User updated successfully";
            } else {
                return "Error: User not found or could not be updated";
            }
        } catch (SQLException e) {
            System.err.println("UserManagementService.updateUser: Error updating user: " + e.getMessage());
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }
}