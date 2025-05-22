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

/**
 * Servlet implementation class OrganizationController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/organizations" })
public class OrganizationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DashboardService dashboardService = new DashboardService();
	private ValidationUtil val = new ValidationUtil();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrganizationController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	String popupMessage = (String) SessionUtil.getAttribute(request, "popupMessage");
    	String popupType = (String) SessionUtil.getAttribute(request, "popupType");
    	
    	if(popupMessage != null && popupType != null) {
    		request.setAttribute("popupMessage", popupMessage);
    		request.setAttribute("popupType", popupType);
    		SessionUtil.removeAttribute(request, "popupMessage");
    		SessionUtil.removeAttribute(request, "popupType");
    	}
    	
		UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
		request.setAttribute("userId", user.getUserId());
		request.setAttribute("fullName", user.getFullName());
		request.setAttribute("userEmail", user.getEmail());
		request.setAttribute("organizationId", user.getOrgId());
		request.setAttribute("userPhoneNumber", user.getPhoneNumber());
		request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());
		
		ArrayList<OrganizationModel> organizations = dashboardService.getAllOrganizations();
		request.setAttribute("organizations", organizations != null ? organizations : new ArrayList<>());
		
		request.getRequestDispatcher("/WEB-INF/pages/organizations.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if(action == null) {
			System.out.println("No action provided");
			return;
		}
		else if (action.equals("createOrg")) {
			String orgName = request.getParameter("orgName");
			String adminName = request.getParameter("adminName");
			String adminEmail = request.getParameter("adminEmail");
			String adminPassword = request.getParameter("adminPassword");
			String errorMessage = "";
			
			if(orgName == null || orgName.trim().isEmpty() || adminName == null || adminName.trim().isEmpty() || adminEmail == null || adminEmail.trim().isEmpty() || adminPassword == null || adminPassword.trim().isEmpty()) {
				errorMessage = "Empty Fields Found";
			}
			else if(!val.isValidEmail(adminEmail)) {
				errorMessage="Invalid Email Format";
			}
			else {
				String hashedPassword = PasswordUtil.hashPassword(adminPassword);
				
				OrganizationModel org = new OrganizationModel();
				org.setName(orgName);
				org.setAdminName(adminName);
				org.setAdminEmail(adminEmail);
				org.setAdminPassword(hashedPassword);
				
				String message = dashboardService.createNewOrganization(org);
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
				
			}
			
			if(errorMessage != null && !errorMessage.isEmpty()) {
				SessionUtil.setAttribute(request, "popupMessage", errorMessage);
				SessionUtil.setAttribute(request, "popupType", "error");
				response.sendRedirect(request.getContextPath() + "/organizations");
			}
		}
		else if (action.equals("deleteOrg")) {
			int orgId = Integer.parseInt(request.getParameter("orgId"));
			
			String message = dashboardService.deleteOrganization(orgId);
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
		else if (action.equals("updateOrg")) {
			int orgId = Integer.parseInt(request.getParameter("orgId"));
			String orgName = request.getParameter("fullName");
			String adminName = request.getParameter("adminName");
			
			OrganizationModel org = new OrganizationModel(orgId, orgName, adminName);
			
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
