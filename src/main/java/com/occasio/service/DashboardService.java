package com.occasio.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.occasio.config.DbConfig;
import com.occasio.model.OrganizationModel;
import com.occasio.util.ValidationUtil;

public class DashboardService {
	private Connection dbConn;
	
	public DashboardService() {
		try {
			this.dbConn = DbConfig.getDbConnection();
		}
		catch(SQLException | ClassNotFoundException ex) {
			System.err.println("Database connection error: " + ex.getMessage());
			ex.printStackTrace();
		}
	}
	
	public int getAllOrganizationCount() {
		if (this.dbConn == null) {
            System.err.println("DashboardService.getAllOrganizationCount: Database connection not found.");
            return 0;
        }
		
		String getAllOrgCountQuery = "SELECT COUNT(*) AS OrgCount FROM organization WHERE OrgId!=1";
		int count = 0;
		
		try(PreparedStatement getAllOrgCountStmt = dbConn.prepareStatement(getAllOrgCountQuery)){
			ResultSet rs = getAllOrgCountStmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt("OrgCount");
			}
		} catch (SQLException e) {
            System.err.println("DashboardService.getAllOrganizationCount: Error fetching org count " + e.getMessage());
            e.printStackTrace();
        }
		
		return count;
	}
	
	public int getAllUsersCount() {
		if (this.dbConn == null) {
            System.err.println("DashboardService.getAllUsersCount: Database connection not found.");
            return 0;
        }
		
		String getAllUsersCountQuery = "SELECT COUNT(*) AS UsersCount FROM user WHERE Role!='superAdmin'";
		int count = 0;
		
		try(PreparedStatement getgetAllUsersCountStmt = dbConn.prepareStatement(getAllUsersCountQuery)){
			ResultSet rs = getgetAllUsersCountStmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt("UsersCount");
			}
		} catch (SQLException e) {
            System.err.println("DashboardService.getAllUsersCount: Error fetching users count " + e.getMessage());
            e.printStackTrace();
        }
		
		return count;
	}
	
	public int getAllCompletedEvents() {
		if (this.dbConn == null) {
            System.err.println("DashboardService.getAllCompletedEvents: Database connection not found.");
            return 0;
        }
		
		LocalDate currentDate = LocalDate.now();
		
		String getAllCompletedEventsQuery = "SELECT COUNT(*) AS EventCount FROM event WHERE Status='approved' AND EndDate < ?";
		int count = 0;
		
		try(PreparedStatement getAllCompletedEventsStmt = dbConn.prepareStatement(getAllCompletedEventsQuery)){
			getAllCompletedEventsStmt.setDate(1, Date.valueOf(currentDate));
			ResultSet rs = getAllCompletedEventsStmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt("EventCount");
			}
		} catch (SQLException e) {
            System.err.println("DashboardService.getAllCompletedEvents: Error fetching completed events count " + e.getMessage());
            e.printStackTrace();
        }
		
		return count;
	}
	
	public int getAllEventsDue() {
		if (this.dbConn == null) {
            System.err.println("DashboardService.getAllEventsDue: Database connection not found.");
            return 0;
        }
		
		LocalDate currentDate = LocalDate.now();
		
		String getAllDueEventsQuery = "SELECT COUNT(*) AS EventCount FROM event WHERE Status='approved' AND ((StartDate < ? AND EndDate > ?) OR (StartDate > ?))";
		int count = 0;
		
		try(PreparedStatement getAllDueEventsStmt = dbConn.prepareStatement(getAllDueEventsQuery)){
			getAllDueEventsStmt.setDate(1, Date.valueOf(currentDate));
			getAllDueEventsStmt.setDate(2, Date.valueOf(currentDate));
			getAllDueEventsStmt.setDate(3, Date.valueOf(currentDate));
			ResultSet rs = getAllDueEventsStmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt("EventCount");
			}
		} catch (SQLException e) {
            System.err.println("DashboardService.getAllCompletedEvents: Error fetching completed events count " + e.getMessage());
            e.printStackTrace();
        }
		
		return count;
	}
	
	public ArrayList<OrganizationModel> getAllOrganizations() {
		if (this.dbConn == null) {
            System.err.println("DashboardService.getAllEventsDue: Database connection not found.");
            return null;
        }
		
		ArrayList<OrganizationModel> organizations = new ArrayList<OrganizationModel>();
		
		String getOrganizationQuery = "SELECT o.*, u.UserId, u.FullName AS AdminName FROM organization o JOIN user u ON o.OrgId = u.OrgId AND u.Role='Admin' AND o.OrgId!=1";
		
		try(PreparedStatement getOrganizationStmt = dbConn.prepareStatement(getOrganizationQuery)){
			ResultSet rs = getOrganizationStmt.executeQuery();
			
			while(rs.next()) {
				OrganizationModel org = new OrganizationModel();
				
				org.setId(rs.getInt("OrgId"));
				org.setName(rs.getString("OrgName"));
				org.setOnboardedDate(rs.getDate("OnboardedDate").toLocalDate());
				org.setStatus(rs.getString("Status"));
				org.setAdminName(rs.getString("AdminName"));
				
				organizations.add(org);
			}
		} catch (SQLException e) {
            System.err.println("DashboardService.getAllOrganizations: Error fetching organizations data " + e.getMessage());
            e.printStackTrace();
        }
		
		return organizations;
	}
	
	public String createNewOrganization(OrganizationModel org) {
		if(this.dbConn == null) {
			System.err.println("DashboardService.createNewOrganization: Database connection not found.");
            return "Error: Database Connnection Failed";
		}
		
		LocalDate currentDate = LocalDate.now();
		ValidationUtil validation = new ValidationUtil();
		
		if (validation.isEmailAlreadyRegistered(org.getAdminEmail())) {
			return "Error: Email Already Exists";
		}
		
		String createOrgQuery = "INSERT INTO organization (OrgName,OnboardedDate,Status) VALUES (?, ?, 'Active')";
		String createAdminQuery = "INSERT INTO user (FullName,UserEmail,Role,Password,DateJoined,OrgId) VALUES (?, ?, 'admin', ?, ?, ?)";
		
		try(PreparedStatement createOrgStmt = dbConn.prepareStatement(createOrgQuery, Statement.RETURN_GENERATED_KEYS)){
			createOrgStmt.setString(1, org.getName());
			createOrgStmt.setDate(2, Date.valueOf(currentDate));
			
			int rowsAffected = createOrgStmt.executeUpdate();
			
			if(rowsAffected == 0) {
				return("Error: An error occured while creating organization");
			}
			
			try (ResultSet generatedKeys = createOrgStmt.getGeneratedKeys()) {
		        if (generatedKeys.next()) {
		            org.setId(generatedKeys.getInt(1));
		        } else {
		            return "Error: Organization created but OrgId not retrieved";
		        }
		    }
		}catch (SQLException e) {
            System.err.println("DashboardService.createNewOrganization: Error creatng organization " + e.getMessage());
            e.printStackTrace();
            return "Error: Error while creating organization";
        }
		
		try(PreparedStatement createAdminStmt = dbConn.prepareStatement(createAdminQuery)){
			createAdminStmt.setString(1, org.getAdminName());
			createAdminStmt.setString(2, org.getAdminEmail());
			createAdminStmt.setString(3, org.getAdminPassword());
			createAdminStmt.setDate(4, Date.valueOf(currentDate));
			createAdminStmt.setInt(5, org.getId());
			
			int rowsAffected = createAdminStmt.executeUpdate();
			
			if(rowsAffected == 0) {
				return("Error: An error occured while creating admin");
			}
		} catch (SQLException e) {
            System.err.println("DashboardService.createNewOrganization: Error creatng admin " + e.getMessage());
            e.printStackTrace();
            return "Error: Error while creating organization";
        }
		 
		
		return "Success: Successfully Added Organization";
	}
	
	public String deleteOrganization(int orgId) {
		if(this.dbConn == null) {
			System.err.println("DashboardService.deleteOrganization: Database connection not found.");
            return "Error: Database Connnection Failed";
		}
		
		String deleteOrgQuery = "UPDATE organization SET Status = 'Deleted' WHERE OrgId = ?";
		
		try(PreparedStatement deleteOrgStmt = dbConn.prepareStatement(deleteOrgQuery)){
			deleteOrgStmt.setInt(1, orgId);
			
			int rowsAffected = deleteOrgStmt.executeUpdate();
			
			if(rowsAffected == 0) {
				return("Error: An error occured while deleting organization.");
			}
		} catch (SQLException e) {
            System.err.println("DashboardService.deleteOrganization: Error deleting org " + e.getMessage());
            e.printStackTrace();
            return "Error: Error while deleting organization";
        }
		
		return "Success: Successfully Deleted Organization";
	}
	
	public String updateOrg(OrganizationModel org) {
		if(this.dbConn == null) {
			System.err.println("DashboardService.deleteOrganization: Database connection not found.");
            return "Error: Database Connnection Failed";
		}
		
		String orgNameInDb = "";
		String adminNameInDb = "";
		int adminIdFromDb;
		String fetchOrgQuery = "SELECT o.OrgName, u.FullName, u.UserId FROM organization o JOIN user u ON o.OrgId = u.orgId WHERE o.OrgId = ?";
		
		try(PreparedStatement fetchOrgStmt = dbConn.prepareStatement(fetchOrgQuery)){
			fetchOrgStmt.setInt(1, org.getId());
			
			ResultSet rs = fetchOrgStmt.executeQuery();
	        if (rs.next()) {
	            orgNameInDb = rs.getString("OrgName");
	            adminNameInDb = rs.getString("FullName");
	            adminIdFromDb = rs.getInt("UserId");
	        } else {
	            System.out.println("No organization found with OrgId: " + org.getId());
	            return "Error: Organization Data not found";
	        }
		} catch (SQLException e) {
            System.err.println("DashboardService.deleteOrganization: Error deleting org " + e.getMessage());
            e.printStackTrace();
            return "Error: Error while updating organization";
        }
		
		if(orgNameInDb.equals(org.getName()) && adminNameInDb.equals(org.getAdminName())) {
			return "Error: Error, no value to update";
		}
		
		// If something changed, proceed to update
		try {
		    if (!orgNameInDb.equals(org.getName())) {
		        String updateOrgNameQuery = "UPDATE organization SET OrgName = ? WHERE OrgId = ?";
		        try (PreparedStatement updateOrgStmt = dbConn.prepareStatement(updateOrgNameQuery)) {
		            updateOrgStmt.setString(1, org.getName());
		            updateOrgStmt.setInt(2, org.getId());
		            updateOrgStmt.executeUpdate();
		        }
		    }

		    if (!adminNameInDb.equals(org.getAdminName())) {
		        String updateAdminNameQuery = "UPDATE user SET FullName = ? WHERE UserId = ?";
		        try (PreparedStatement updateAdminStmt = dbConn.prepareStatement(updateAdminNameQuery)) {
		            updateAdminStmt.setString(1, org.getAdminName());
		            updateAdminStmt.setInt(2, adminIdFromDb);
		            updateAdminStmt.executeUpdate();
		        }
		    }

		    return "Success: Successfully Updated Organization";

		} catch (SQLException e) {
		    System.err.println("DashboardService.updateOrganization: Error updating org " + e.getMessage());
		    e.printStackTrace();
		    return "Error: Error while updating organization";
		}
	}
}
