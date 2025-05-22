package com.occasio.service;

import java.sql.Connection;
import java.sql.Date; 
import java.sql.SQLException; 
import java.sql.Statement; 
import java.time.LocalDate; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList; 

import java.util.List;
import com.occasio.model.TopInterestedEventModel; 
import com.occasio.model.MostEngagedUserModel;

import com.occasio.config.DbConfig;
import com.occasio.model.OrganizationModel;
import com.occasio.util.ValidationUtil; 

public class DashboardService {
	private Connection dbConn;
	
	public DashboardService() {
		// Constructor to initialize the database connection
		try {
			this.dbConn = DbConfig.getDbConnection(); // Get database connection from DbConfig
		}
		catch(SQLException | ClassNotFoundException ex) {
			// Catch any SQLException or ClassNotFoundException during database connection
			System.err.println("Database connection error: " + ex.getMessage()); // Print error message to the console
			ex.printStackTrace(); // Print stack trace for debugging
		}
	}
	
	public int getAllOrganizationCount() {
		// Method to get the count of all organizations (excluding the one with OrgId=1)
		if (this.dbConn == null) {
            // Check if the database connection is null
            System.err.println("DashboardService.getAllOrganizationCount: Database connection not found."); // Print error message if connection is null
            return 0; // Return 0 if connection is null
        }
		
		String getAllOrgCountQuery = "SELECT COUNT(*) AS OrgCount FROM organization WHERE OrgId!=1"; // SQL query to get the count of organizations
		int count = 0; // Initialize count variable
		
		try(PreparedStatement getAllOrgCountStmt = dbConn.prepareStatement(getAllOrgCountQuery)){
			// Create a PreparedStatement to execute the query
			ResultSet rs = getAllOrgCountStmt.executeQuery(); // Execute the query and get the result set
			
			if (rs.next()) {
				// Check if the result set has any rows
				count = rs.getInt("OrgCount"); // Get the organization count from the result set
			}
		} catch (SQLException e) {
            // Catch any SQLException during query execution
            System.err.println("DashboardService.getAllOrganizationCount: Error fetching org count " + e.getMessage()); // Print error message
            e.printStackTrace(); // Print stack trace
        }
		
		return count; // Return the organization count
	}
	
	public int getAllUsersCount() {
		// Method to get the count of all users (excluding superAdmin)
		if (this.dbConn == null) {
            // Check if the database connection is null
            System.err.println("DashboardService.getAllUsersCount: Database connection not found."); // Print error message if connection is null
            return 0; // Return 0 if connection is null
        }
		
		String getAllUsersCountQuery = "SELECT COUNT(*) AS UsersCount FROM user WHERE Role!='superAdmin'"; // SQL query to get the count of users
		int count = 0; // Initialize count variable
		
		try(PreparedStatement getgetAllUsersCountStmt = dbConn.prepareStatement(getAllUsersCountQuery)){
			// Create a PreparedStatement to execute the query
			ResultSet rs = getgetAllUsersCountStmt.executeQuery(); // Execute the query and get the result set
			
			if (rs.next()) {
				// Check if the result set has any rows
				count = rs.getInt("UsersCount"); // Get the user count from the result set
			}
		} catch (SQLException e) {
            // Catch any SQLException during query execution
            System.err.println("DashboardService.getAllUsersCount: Error fetching users count " + e.getMessage()); // Print error message
            e.printStackTrace(); // Print stack trace
        }
		
		return count; // Return the user count
	}
	
	public int getAllCompletedEvents() {
		// Method to get the count of all completed events
		if (this.dbConn == null) {
            // Check if the database connection is null
            System.err.println("DashboardService.getAllCompletedEvents: Database connection not found."); // Print error message if connection is null
            return 0; // Return 0 if connection is null
        }
		
		LocalDate currentDate = LocalDate.now(); // Get the current date
		
		String getAllCompletedEventsQuery = "SELECT COUNT(*) AS EventCount FROM event WHERE Status='approved' AND EndDate < ?"; // SQL query to get the count of completed events
		int count = 0; // Initialize count variable
		
		try(PreparedStatement getAllCompletedEventsStmt = dbConn.prepareStatement(getAllCompletedEventsQuery)){
			// Create a PreparedStatement to execute the query
			getAllCompletedEventsStmt.setDate(1, Date.valueOf(currentDate)); // Set the current date as a parameter in the query
			ResultSet rs = getAllCompletedEventsStmt.executeQuery(); // Execute the query and get the result set
			
			if (rs.next()) {
				// Check if the result set has any rows
				count = rs.getInt("EventCount"); // Get the event count from the result set
			}
		} catch (SQLException e) {
            // Catch any SQLException during query execution
            System.err.println("DashboardService.getAllCompletedEvents: Error fetching completed events count " + e.getMessage()); // Print error message
            e.printStackTrace(); // Print stack trace
        }
		
		return count; // Return the event count
	}
	
	public int getAllEventsDue() {
		// Method to get the count of all events due (upcoming or ongoing)
		if (this.dbConn == null) {
            // Check if the database connection is null
            System.err.println("DashboardService.getAllEventsDue: Database connection not found."); // Print error message if connection is null
            return 0; // Return 0 if connection is null
        }
		
		LocalDate currentDate = LocalDate.now(); // Get the current date
		
		String getAllDueEventsQuery = "SELECT COUNT(*) AS EventCount FROM event WHERE Status='approved' AND ((StartDate < ? AND EndDate > ?) OR (StartDate > ?))"; // SQL query to get the count of due events
		int count = 0; // Initialize count variable
		
		try(PreparedStatement getAllDueEventsStmt = dbConn.prepareStatement(getAllDueEventsQuery)){
			// Create a PreparedStatement to execute the query
			getAllDueEventsStmt.setDate(1, Date.valueOf(currentDate)); // Set the current date as a parameter in the query
			getAllDueEventsStmt.setDate(2, Date.valueOf(currentDate)); // Set the current date as a parameter in the query
			getAllDueEventsStmt.setDate(3, Date.valueOf(currentDate)); // Set the current date as a parameter in the query
			ResultSet rs = getAllDueEventsStmt.executeQuery(); // Execute the query and get the result set
			
			if (rs.next()) {
				// Check if the result set has any rows
				count = rs.getInt("EventCount"); // Get the event count from the result set
			}
		} catch (SQLException e) {
            // Catch any SQLException during query execution
            System.err.println("DashboardService.getAllCompletedEvents: Error fetching completed events count " + e.getMessage()); // Print error message
            e.printStackTrace(); // Print stack trace
        }
		
		return count; // Return the event count
	}
	
	public int getOngoingEventsDue() {
	    // Method to get the count of ongoing events
	    if (this.dbConn == null) {
	        // Check if the database connection is null
	        System.err.println("DashboardService.getOngoingEventsDue: Database connection not found."); // Print error message if connection is null
	        return 0; // Return 0 if connection is null
	    }
	    
	    LocalDate currentDate = LocalDate.now(); // Get the current date
	    
	    String getOngoingEventsQuery = "SELECT COUNT(*) AS EventCount FROM event WHERE Status='approved' AND StartDate <= ? AND EndDate >= ?"; // SQL query to get the count of ongoing events
	    int count = 0; // Initialize count variable
	    
	    try (PreparedStatement getOngoingEventsStmt = dbConn.prepareStatement(getOngoingEventsQuery)) {
	        // Create a PreparedStatement to execute the query
	        getOngoingEventsStmt.setDate(1, Date.valueOf(currentDate)); // Set the current date as a parameter in the query
	        getOngoingEventsStmt.setDate(2, Date.valueOf(currentDate)); // Set the current date as a parameter in the query
	        
	        ResultSet rs = getOngoingEventsStmt.executeQuery(); // Execute the query and get the result set
	        
	        if (rs.next()) {
	            // Check if the result set has any rows
	            count = rs.getInt("EventCount"); // Get the event count from the result set
	        }
	    } catch (SQLException e) {
	        // Catch any SQLException during query execution
	        System.err.println("DashboardService.getOngoingEventsDue: Error fetching ongoing events count " + e.getMessage()); // Print error message
	        e.printStackTrace(); // Print stack trace
	    }
	    
	    return count; // Return the event count
	}

	
	public ArrayList<OrganizationModel> getAllOrganizations() {
		// Method to get all organizations from the database
		if (this.dbConn == null) {
            // Check if the database connection is null
            System.err.println("DashboardService.getAllEventsDue: Database connection not found."); // Print error message if connection is null
            return null; // Return null if connection is null
        }
		
		ArrayList<OrganizationModel> organizations = new ArrayList<OrganizationModel>(); // Initialize an ArrayList to store organizations
		
		String getOrganizationQuery = "SELECT o.*, u.UserId, u.FullName AS AdminName FROM organization o JOIN user u ON o.OrgId = u.OrgId AND u.Role='Admin' AND o.OrgId!=1"; // SQL query to get all organizations with admin name
		
		try(PreparedStatement getOrganizationStmt = dbConn.prepareStatement(getOrganizationQuery)){
			// Create a PreparedStatement to execute the query
			ResultSet rs = getOrganizationStmt.executeQuery(); // Execute the query and get the result set
			
			while(rs.next()) {
				// Iterate through the result set
				OrganizationModel org = new OrganizationModel(); // Create a new OrganizationModel object
				
				org.setId(rs.getInt("OrgId")); // Set organization ID
				org.setName(rs.getString("OrgName")); // Set organization name
				org.setOnboardedDate(rs.getDate("OnboardedDate").toLocalDate()); // Set organization onboarded date
				org.setStatus(rs.getString("Status")); // Set organization status
				org.setAdminName(rs.getString("AdminName")); // Set organization admin name
				
				organizations.add(org); // Add the organization to the ArrayList
			}
		} catch (SQLException e) {
            // Catch any SQLException during query execution
            System.err.println("DashboardService.getAllOrganizations: Error fetching organizations data " + e.getMessage()); // Print error message
            e.printStackTrace(); // Print stack trace
        }
		
		return organizations; // Return the ArrayList of organizations
	}
	
	/**
	 * Creates a new organization in the database.
	 * @param org The OrganizationModel object containing the organization's data.
	 * @return A string indicating the success or failure of the operation.
	 */
	public String createNewOrganization(OrganizationModel org) {
		// Method to create a new organization
		if(this.dbConn == null) {
			// Check if the database connection is null
			System.err.println("DashboardService.createNewOrganization: Database connection not found."); // Print error message if connection is null
            return "Error: Database Connnection Failed"; // Return an error message
		}
		
		LocalDate currentDate = LocalDate.now(); // Get the current date
		ValidationUtil validation = new ValidationUtil(); // Create a ValidationUtil object
		
		if (validation.isEmailAlreadyRegistered(org.getAdminEmail())) {
			// Check if the admin email is already registered
			return "Error: Email Already Exists"; // Return an error message if the email already exists
		}
		
		String createOrgQuery = "INSERT INTO organization (OrgName,OnboardedDate,Status) VALUES (?, ?, 'Active')"; // SQL query to insert a new organization
		String createAdminQuery = "INSERT INTO user (FullName,UserEmail,Role,Password,DateJoined,OrgId) VALUES (?, ?, 'admin', ?, ?, ?)"; // SQL query to insert a new admin user
		
		try(PreparedStatement createOrgStmt = dbConn.prepareStatement(createOrgQuery, Statement.RETURN_GENERATED_KEYS)){
			// Create a PreparedStatement to execute the organization insertion query
			createOrgStmt.setString(1, org.getName()); // Set the organization name as a parameter
			createOrgStmt.setDate(2, Date.valueOf(currentDate)); // Set the onboarded date as a parameter
			
			int rowsAffected = createOrgStmt.executeUpdate(); // Execute the query and get the number of rows affected
			
			if(rowsAffected == 0) {
				// Check if any rows were affected
				return("Error: An error occured while creating organization"); // Return an error message if no rows were affected
			}
			
			try (ResultSet generatedKeys = createOrgStmt.getGeneratedKeys()) {
		        // Get the generated keys (OrgId)
		        if (generatedKeys.next()) {
		            // Check if there are any generated keys
		            org.setId(generatedKeys.getInt(1)); // Set the organization ID from the generated keys
		        } else {
		            // If no generated keys were found return an error
		            return "Error: Organization created but OrgId not retrieved";
		        }
		    }
		}catch (SQLException e) {
            // Catch any SQLException during query execution
            System.err.println("DashboardService.createNewOrganization: Error creatng organization " + e.getMessage()); // Print error message
            e.printStackTrace(); // Print stack trace
            return "Error: Error while creating organization"; // Return an error message
        }
		
		try(PreparedStatement createAdminStmt = dbConn.prepareStatement(createAdminQuery)){
			// Create a PreparedStatement to execute the admin user insertion query
			createAdminStmt.setString(1, org.getAdminName()); // Set the admin name as a parameter
			createAdminStmt.setString(2, org.getAdminEmail()); // Set the admin email as a parameter
			createAdminStmt.setString(3, org.getAdminPassword()); // Set the admin password as a parameter
			createAdminStmt.setDate(4, Date.valueOf(currentDate)); // Set the date joined as a parameter
			createAdminStmt.setInt(5, org.getId()); // Set the organization ID as a parameter
			
			int rowsAffected = createAdminStmt.executeUpdate(); // Execute the query and get the number of rows affected
			
			if(rowsAffected == 0) {
				// Check if any rows were affected
				return("Error: An error occured while creating admin"); // Return an error message if no rows were affected
			}
		} catch (SQLException e) {
            // Catch any SQLException during query execution
            System.err.println("DashboardService.createNewOrganization: Error creatng admin " + e.getMessage()); // Print error message
            e.printStackTrace(); // Print stack trace
            return "Error: Error while creating organization"; // Return an error message
        }
		 
		
		return "Success: Successfully Added Organization"; // Return a success message
	}
	
	/**
	 * Deletes an organization by setting its status to 'Deleted'.
	 * @param orgId The ID of the organization to delete.
	 * @return A string indicating the success or failure of the operation.
	 */
	public String deleteOrganization(int orgId) {
		// Method to delete an organization
		if(this.dbConn == null) {
			// Check if the database connection is null
			System.err.println("DashboardService.deleteOrganization: Database connection not found."); // Print error message if connection is null
            return "Error: Database Connnection Failed"; // Return an error message
		}
		
		String deleteOrgQuery = "UPDATE organization SET Status = 'Deleted' WHERE OrgId = ?"; // SQL query to update the organization status to 'Deleted'
		
		try(PreparedStatement deleteOrgStmt = dbConn.prepareStatement(deleteOrgQuery)){
			// Create a PreparedStatement to execute the update query
			deleteOrgStmt.setInt(1, orgId); // Set the organization ID as a parameter
			
			int rowsAffected = deleteOrgStmt.executeUpdate(); // Execute the query and get the number of rows affected
			
			if(rowsAffected == 0) {
				// Check if any rows were affected
				return("Error: An error occured while deleting organization."); // Return an error message if no rows were affected
			}
		} catch (SQLException e) {
            // Catch any SQLException during query execution
            System.err.println("DashboardService.deleteOrganization: Error deleting org " + e.getMessage()); // Print error message
            e.printStackTrace(); // Print stack trace
            return "Error: Error while deleting organization"; // Return an error message
        }
		
		return "Success: Successfully Deleted Organization"; // Return a success message
	}
	
	/**
	 * Updates an organization's name and admin's name.
	 * @param org The OrganizationModel object containing the updated data.
	 * @return A string indicating the success or failure of the operation.
	 */
	public String updateOrg(OrganizationModel org) {
		// Method to update an organization
		if(this.dbConn == null) {
			// Check if the database connection is null
			System.err.println("DashboardService.deleteOrganization: Database connection not found."); // Print error message if connection is null
            return "Error: Database Connnection Failed"; // Return an error message
		}
		
		String orgNameInDb = ""; // Variable to store the organization name from the database
		String adminNameInDb = ""; // Variable to store the admin name from the database
		int adminIdFromDb; // Variable to store admin ID from the database
		String fetchOrgQuery = "SELECT o.OrgName, u.FullName, u.UserId FROM organization o JOIN user u ON o.OrgId = u.orgId WHERE o.OrgId = ?"; // SQL query to fetch organization and admin data

		try (PreparedStatement fetchOrgStmt = dbConn.prepareStatement(fetchOrgQuery)) {
			// Create a PreparedStatement to execute the fetch query
			fetchOrgStmt.setInt(1, org.getId()); // Set the organization ID as a parameter

			ResultSet rs = fetchOrgStmt.executeQuery(); // Execute the query and get the result set
			if (rs.next()) {
				// Check if there are any rows in the result set
				orgNameInDb = rs.getString("OrgName"); // Get organization name from the result set
				adminNameInDb = rs.getString("FullName"); // Get admin name from the result set
				adminIdFromDb = rs.getInt("UserId"); // Get admin ID from the result set
			} else {
				// Handle the case where no organization is found with the given ID
				System.out.println("No organization found with OrgId: " + org.getId()); // Print message to console
				return "Error: Organization Data not found"; // Return an error message
			}
		} catch (SQLException e) {
			// Catch any SQLException during query execution
			System.err.println("DashboardService.deleteOrganization: Error deleting org " + e.getMessage()); // Print error message
			e.printStackTrace(); // Print stack trace
			return "Error: Error while updating organization"; // Return an error message
		}
		
		if(orgNameInDb.equals(org.getName()) && adminNameInDb.equals(org.getAdminName())) {
			// check if there is any update value
			return "Error: Error, no value to update"; // if no update value return error
		}
		
		// If something changed, proceed to update
		try {
		    // Check if the organization name has changed
		    if (!orgNameInDb.equals(org.getName())) {
		        String updateOrgNameQuery = "UPDATE organization SET OrgName = ? WHERE OrgId = ?"; // SQL query to update organization name
		        try (PreparedStatement updateOrgStmt = dbConn.prepareStatement(updateOrgNameQuery)) {
		            updateOrgStmt.setString(1, org.getName()); // Set the new organization name as a parameter
		            updateOrgStmt.setInt(2, org.getId()); // Set the organization ID as a parameter
		            updateOrgStmt.executeUpdate(); // Execute the query
		        }
		    }

		    // Check if the admin name has changed
		    if (!adminNameInDb.equals(org.getAdminName())) {
		        String updateAdminNameQuery = "UPDATE user SET FullName = ? WHERE UserId = ?"; // SQL query to update admin name
		        try (PreparedStatement updateAdminStmt = dbConn.prepareStatement(updateAdminNameQuery)) {
		            updateAdminStmt.setString(1, org.getAdminName()); // Set the new admin name as a parameter
		            updateAdminStmt.setInt(2, adminIdFromDb); // Set the admin ID as a parameter
		            updateAdminStmt.executeUpdate(); // Execute the query
		        }
		    }

		    return "Success: Successfully Updated Organization"; // Return a success message

		} catch (SQLException e) {
		    System.err.println("DashboardService.updateOrganization: Error updating org " + e.getMessage()); // Print error message
		    e.printStackTrace(); // Print stack trace
		    return "Error: Error while updating organization"; // Return an error message
		}
	}
	
	/**
	 * Retrieves a list of top interested events based on the number of users interested.
	 * @return A list of TopInterestedEventModel objects.
	 */
	public List<TopInterestedEventModel> getTopInterestedEvents() {
		// Method to get the top interested events
        if (this.dbConn == null) {
			// Check if the database connection is null
            System.err.println("DashboardService.getTopInterestedEvents: Database connection not found."); // Print error message if connection is null
            return new ArrayList<>(); // Return an empty list to avoid errors
        }

        List<TopInterestedEventModel> topEvents = new ArrayList<>(); // Initialize list of top events
        String sql = "SELECT e.EventName, COUNT(ei.UserId) AS InterestCount " +
                     "FROM event e " +
                     "JOIN event_interested_users ei ON e.EventId = ei.EventId " +
                     "GROUP BY e.EventName " +
                     "ORDER BY InterestCount DESC " +
                     "LIMIT 5"; // SQL query to get top 5 interested events

        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
			// Create a PreparedStatement to execute the query
            ResultSet rs = stmt.executeQuery(); // Execute the query and get the result set
            while (rs.next()) {
				// Iterate through the result set
                TopInterestedEventModel event = new TopInterestedEventModel(); // Create a new TopInterestedEventModel object
                event.setEventName(rs.getString("EventName")); // Set the event name
                event.setInterestCount(rs.getInt("InterestCount")); // Set the interest count
                topEvents.add(event); // Add the event to the list
            }
        } catch (SQLException e) {
			// Catch any SQLException during query execution
            System.err.println("DashboardService.getTopInterestedEvents: Error fetching data: " + e.getMessage()); // Print error message
            e.printStackTrace(); // Print stack trace
        }
        return topEvents; // Return the list of top events
    }

	/**
	 * Retrieves a list of most engaged users based on the number of events they are interested in.
	 * @return A list of MostEngagedUserModel objects.
	 */
    public List<MostEngagedUserModel> getMostEngagedUsers() {
		// Method to get the most engaged users
        if (this.dbConn == null) {
			// Check if the database connection is null
            System.err.println("DashboardService.getMostEngagedUsers: Database connection not found."); // Print error message if connection is null
            return new ArrayList<>(); // Return empty list
        }

        List<MostEngagedUserModel> engagedUsers = new ArrayList<>(); // Initialize list of engaged users
        String sql = "SELECT u.FullName, u.UserEmail, u.ProfilePicturePath, COUNT(ei.EventId) AS EngagementCount " +
                     "FROM user u " +
                     "JOIN event_interested_users ei ON u.UserId = ei.UserId " +
                     "GROUP BY u.UserId " +
                     "ORDER BY EngagementCount DESC " +
                     "LIMIT 5";  // SQL query to get top 5 engaged users

        try (PreparedStatement stmt = dbConn.prepareStatement(sql)) {
			// Create a PreparedStatement to execute the query
            ResultSet rs = stmt.executeQuery(); // Execute the query and get the result set
            while (rs.next()) {
				// Iterate through the result set
                MostEngagedUserModel user = new MostEngagedUserModel(); // Create a new MostEngagedUserModel object
                user.setFullName(rs.getString("FullName")); // Set the user's full name
                user.setEmail(rs.getString("UserEmail")); // Set the user's email
                user.setProfilePicturePath(rs.getString("ProfilePicturePath")); // Assuming you have a ProfilePicturePath column // Set the user's profile picture path
                user.setEngagementCount(rs.getInt("EngagementCount")); // Set the user's engagement count
                engagedUsers.add(user); // Add the user to the list
            }
        } catch (SQLException e) {
			// Catch any SQLException during query execution
            System.err.println("DashboardService.getMostEngagedUsers: Error fetching data: " + e.getMessage()); // Print error message
            e.printStackTrace(); // Print stack trace
        }
        return engagedUsers; // Return the list of engaged users
    }
}