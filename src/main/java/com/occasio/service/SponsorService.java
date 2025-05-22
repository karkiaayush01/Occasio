package com.occasio.service;

import com.occasio.model.SponsorModel;
import com.occasio.config.DbConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SponsorService {

    /**
     * Adds a new sponsor to the database.
     * @param sponsor The SponsorModel object containing the sponsor's data.
     * @return True if the sponsor was successfully added, false otherwise.
     */
    public boolean addSponsor(SponsorModel sponsor) {
        String sql = "INSERT INTO sponsor (sponsorName, sponsorContact, sponsorEmail) VALUES (?, ?, ?)";
        try (Connection conn = DbConfig.getDbConnection(); // Use DbConfig
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) { // Return generated keys

            pstmt.setString(1, sponsor.getSponsorName());
            pstmt.setString(2, sponsor.getSponsorContact());
            pstmt.setString(3, sponsor.getSponsorEmail());

            int affectedRows = pstmt.executeUpdate();

            // Check if insertion success
            if (affectedRows > 0) {
            	// Get Generated Key
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                	// Check If Genereated Key Is Available
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

    /**
     * Retrieves a sponsor from the database by their ID.
     * @param sponsorId The ID of the sponsor to retrieve.
     * @return The SponsorModel object if found, null otherwise.
     */
    public SponsorModel getSponsorById(int sponsorId) {
        String sql = "SELECT * FROM sponsor WHERE sponsorID = ?";
        try (Connection conn = DbConfig.getDbConnection(); // Use DbConfig
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, sponsorId);
            ResultSet rs = pstmt.executeQuery();

            // Check If Result Set Is Empty
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

    /**
     * Retrieves a list of all sponsors from the database.
     * @return A List of SponsorModel objects representing all sponsors.
     */
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
    
    /**
     * Retrieves a sponsor from the database by their name and email.
     * @param name The name of the sponsor to search for.
     * @param email The email of the sponsor to search for.
     * @return The SponsorModel object if found, null otherwise.
     */
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

            // Check If Any Result is Fetched
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
    
    /**
     * Updates an existing sponsor's information in the database.
     * @param sponsor The SponsorModel object containing the updated information.
     * @return True if the update was successful, false otherwise.
     */
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