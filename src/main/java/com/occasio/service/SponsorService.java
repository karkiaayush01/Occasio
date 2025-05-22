package com.occasio.service;

import com.occasio.model.SponsorModel;
import com.occasio.config.DbConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SponsorService {

    // Method to add a new sponsor
    public boolean addSponsor(SponsorModel sponsor) {
        String sql = "INSERT INTO sponsor (sponsorName, sponsorContact, sponsorEmail) VALUES (?, ?, ?)";
        try (Connection conn = DbConfig.getDbConnection(); // Use DbConfig
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) { // Return generated keys

            pstmt.setString(1, sponsor.getSponsorName());
            pstmt.setString(2, sponsor.getSponsorContact());
            pstmt.setString(3, sponsor.getSponsorEmail());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        sponsor.setSponsorID(generatedKeys.getInt(1)); // Set the auto-generated ID back to the model
                    } else {
                        throw new SQLException("Creating sponsor failed, no ID obtained.");
                    }
                }
                return true;
            } else {
                return false;
            }
        } catch (SQLException | ClassNotFoundException e) { // Handle both exceptions
            e.printStackTrace();
            return false;
        }
    }

    // Method to retrieve a sponsor by ID
    public SponsorModel getSponsorById(int sponsorId) {
        String sql = "SELECT * FROM sponsor WHERE sponsorID = ?";
        try (Connection conn = DbConfig.getDbConnection(); // Use DbConfig
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, sponsorId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                SponsorModel sponsor = new SponsorModel();
                sponsor.setSponsorID(rs.getInt("sponsorID"));
                sponsor.setSponsorName(rs.getString("sponsorName"));
                sponsor.setSponsorContact(rs.getString("sponsorContact"));
                sponsor.setSponsorEmail(rs.getString("sponsorEmail"));
                return sponsor;
            } else {
                return null; // Sponsor not found
            }
        } catch (SQLException | ClassNotFoundException e) { // Handle both exceptions
            e.printStackTrace();
            return null;
        }
    }

    // Method to list all sponsors
    public List<SponsorModel> getAllSponsors() {
        List<SponsorModel> sponsors = new ArrayList<>();
        String sql = "SELECT * FROM sponsor";
        try (Connection conn = DbConfig.getDbConnection(); // Use DbConfig
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                SponsorModel sponsor = new SponsorModel();
                sponsor.setSponsorID(rs.getInt("sponsorID"));
                sponsor.setSponsorName(rs.getString("sponsorName"));
                sponsor.setSponsorContact(rs.getString("sponsorContact"));
                sponsor.setSponsorEmail(rs.getString("sponsorEmail"));
                sponsors.add(sponsor);
            }
        } catch (SQLException | ClassNotFoundException e) { // Handle both exceptions
            e.printStackTrace();
        }
        return sponsors;
    }
    
    //get sponsor by name and id method
    public SponsorModel getSponsorByNameAndEmail(String name, String email) {
        // Basic validation for search
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            return null;
        }
        String sql = "SELECT * FROM sponsor WHERE sponsorName = ? AND sponsorEmail = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, name.trim());
            pstmt.setString(2, email.trim());
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                SponsorModel sponsor = new SponsorModel();
                sponsor.setSponsorID(rs.getInt("sponsorID"));
                sponsor.setSponsorName(rs.getString("sponsorName"));
                sponsor.setSponsorContact(rs.getString("sponsorContact"));
                sponsor.setSponsorEmail(rs.getString("sponsorEmail"));
                return sponsor;
            } else {
                return null;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    //method to update sposnor
    public boolean updateSponsor(SponsorModel sponsor) {
        if (sponsor.getSponsorID() <= 0) return false;
        String sql = "UPDATE sponsor SET sponsorName = ?, sponsorContact = ?, sponsorEmail = ? WHERE sponsorID = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, sponsor.getSponsorName());
            pstmt.setString(2, sponsor.getSponsorContact());
            pstmt.setString(3, sponsor.getSponsorEmail());
            pstmt.setInt(4, sponsor.getSponsorID());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
}