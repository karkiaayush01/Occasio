package com.occasio.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

import com.occasio.model.UserModel;
import com.occasio.model.OrganizationModel;
import com.occasio.util.SessionUtil;
import com.occasio.service.DashboardService;
import com.occasio.util.PasswordUtil;
import com.occasio.util.ValidationUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/organizations" })
public class OrganizationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//service and validation utility instances
	private DashboardService dashboardService = new DashboardService();
	private ValidationUtil val = new ValidationUtil();

	public OrganizationController() {
		super();
	}

	//handling GET requests to display organizations page
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//fetching and displaying any popup messages from session
		String popupMessage = (String) SessionUtil.getAttribute(request, "popupMessage");
		String popupType = (String) SessionUtil.getAttribute(request, "popupType");

		if(popupMessage != null && popupType != null) {
			request.setAttribute("popupMessage", popupMessage);
			request.setAttribute("popupType", popupType);
			SessionUtil.removeAttribute(request, "popupMessage");
			SessionUtil.removeAttribute(request, "popupType");
		}

		//getting logged-in user details and setting as request attributes
		UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
		request.setAttribute("userId", user.getUserId());
		request.setAttribute("fullName", user.getFullName());
		request.setAttribute("userEmail", user.getEmail());
		request.setAttribute("organizationId", user.getOrgId());
		request.setAttribute("userPhoneNumber", user.getPhoneNumber());
		request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());

		//fetching all organizations
		ArrayList<OrganizationModel> organizations = dashboardService.getAllOrganizations();
		request.setAttribute("organizations", organizations != null ? organizations : new ArrayList<>());

		//forwarding to JSP page
		request.getRequestDispatcher("/WEB-INF/pages/organizations.jsp").forward(request, response);
	}

	//handling POST requests for create, update, and delete
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		//invalid or missing action parameter
		if(action == null) {
			System.out.println("No action provided");
			return;
		}

		else if (action.equals("createOrg")) {
			//fetching organization and admin details from request
			String orgName = request.getParameter("orgName");
			String adminName = request.getParameter("adminName");
			String adminEmail = request.getParameter("adminEmail");
			String adminPassword = request.getParameter("adminPassword");
			String errorMessage = "";

			//validating inputs
			if(orgName == null || orgName.trim().isEmpty() || adminName == null || adminName.trim().isEmpty() || adminEmail == null || adminEmail.trim().isEmpty() || adminPassword == null || adminPassword.trim().isEmpty()) {
				errorMessage = "Empty Fields Found";
			}
			else if(!val.isValidEmail(adminEmail)) {
				errorMessage="Invalid Email Format";
			}
			else {
				//hashing password before storing
				String hashedPassword = PasswordUtil.hashPassword(adminPassword);

				//creating organization model object
				OrganizationModel org = new OrganizationModel();
				org.setName(orgName);
				org.setAdminName(adminName);
				org.setAdminEmail(adminEmail);
				org.setAdminPassword(hashedPassword);

				//calling service to create organization
				String message = dashboardService.createNewOrganization(org);
				if(message.startsWith("Success:")) {
					//displaying success message
					String[] parts = message.split(": ", 2); 
					if (parts.length == 2) {
						SessionUtil.setAttribute(request, "popupMessage", parts[1]);
						SessionUtil.setAttribute(request, "popupType", "success");
						response.sendRedirect(request.getContextPath() + "/organizations");
						return;
					}
					else {
						SessionUtil.setAttribute(request, "popupMessage", "Successfully created organization");
						SessionUtil.setAttribute(request, "popupType", "success");
						response.sendRedirect(request.getContextPath() + "/organizations");
					}
				}
				else if (message.startsWith("Error:")){
					//extracting error message
					String[] parts = message.split(": ", 2); 
					if (parts.length == 2) {
						errorMessage = parts[1];
					}
					else {
						errorMessage = "An error occured";
					}
				}
				else {
					errorMessage = "An error occured";
				}
			}

			//showing error popup
			if(errorMessage != null && !errorMessage.isEmpty()) {
				SessionUtil.setAttribute(request, "popupMessage", errorMessage);
				SessionUtil.setAttribute(request, "popupType", "error");
				response.sendRedirect(request.getContextPath() + "/organizations");
			}
		}

		else if (action.equals("deleteOrg")) {
			//getting org id to delete
			int orgId = Integer.parseInt(request.getParameter("orgId"));

			//deleting via service
			String message = dashboardService.deleteOrganization(orgId);
			String errorMessage = "";

			if(message.startsWith("Success:")) {
				//successful deletion
				String[] parts = message.split(": ", 2); 
				if (parts.length == 2) {
					SessionUtil.setAttribute(request, "popupMessage", parts[1]);
					SessionUtil.setAttribute(request, "popupType", "success");
					response.sendRedirect(request.getContextPath() + "/organizations");
					return;
				}
				else {
					SessionUtil.setAttribute(request, "popupMessage", "Successfully created organization");
					SessionUtil.setAttribute(request, "popupType", "success");
				}
			}
			else if (message.startsWith("Error:")){
				//error in deletion
				String[] parts = message.split(": ", 2); 
				if (parts.length == 2) {
					errorMessage = parts[1];
				}
				else {
					errorMessage = "An error occured";
				}
			}
			else {
				errorMessage = "An error occured";
			}

			//displaying error popup
			if(errorMessage != null && !errorMessage.isEmpty()) {
				SessionUtil.setAttribute(request, "popupMessage", errorMessage);
				SessionUtil.setAttribute(request, "popupType", "error");
				response.sendRedirect(request.getContextPath() + "/organizations");
			}
		}

		else if (action.equals("updateOrg")) {
			//getting update data
			int orgId = Integer.parseInt(request.getParameter("orgId"));
			String orgName = request.getParameter("fullName");
			String adminName = request.getParameter("adminName");

			//creating model object
			OrganizationModel org = new OrganizationModel(orgId, orgName, adminName);

			//calling update service
			String message = dashboardService.updateOrg(org);
			String errorMessage = "";

			if(message.startsWith("Success:")) {
				String[] parts = message.split(": ", 2); 
				if (parts.length == 2) {
					SessionUtil.setAttribute(request, "popupMessage", parts[1]);
					SessionUtil.setAttribute(request, "popupType", "success");
					response.sendRedirect(request.getContextPath() + "/organizations");
					return;
				}
				else {
					SessionUtil.setAttribute(request, "popupMessage", "Successfully created organization");
					SessionUtil.setAttribute(request, "popupType", "success");
					response.sendRedirect(request.getContextPath() + "/organizations");
				}
			}
			else if (message.startsWith("Error:")){
				String[] parts = message.split(": ", 2); 
				if (parts.length == 2) {
					errorMessage = parts[1];
				}
				else {
					errorMessage = "An error occured";
				}
			}
			else {
				errorMessage = "An error occured";
			}

			if(errorMessage != null && !errorMessage.isEmpty()) {
				SessionUtil.setAttribute(request, "popupMessage", errorMessage);
				SessionUtil.setAttribute(request, "popupType", "error");
				response.sendRedirect(request.getContextPath() + "/organizations");
			}
		}
	}
}
