package com.occasio.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.occasio.model.UserModel;
import com.occasio.service.UserManagementService;
import com.occasio.util.SessionUtil;

/**
 * Servlet implementation class UserManagementContoller
 * Handles displaying, updating, and deleting users in an organization.
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/userManagement" })
public class UserManagementContoller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Constructor
    public UserManagementContoller() {
        super();
    }

    /**
     * Handles GET requests to fetch and display users in the current organization.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //getting logged-in user from session
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        int orgId = user.getOrgId();

        //fetching all users from the same organization
        UserManagementService userService = new UserManagementService();
        List<UserModel> users = userService.getAllUsersInOrganization(orgId);

        //setting user info and user list to the request scope
        request.setAttribute("users", users);
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("fullName", user.getFullName());
        request.setAttribute("userEmail", user.getEmail());
        request.setAttribute("organizationId", user.getOrgId());
        request.setAttribute("userPhoneNumber", user.getPhoneNumber());
        request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());

        //forwarding to the user management JSP
        request.getRequestDispatcher("/WEB-INF/pages/userManagement.jsp").forward(request, response);
    }

    /**
     * Handles POST requests to perform user actions like update or delete.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("deleteUser".equals(action)) {
            //deleting user if action is deleteUser
            handleDeleteUser(request, response);
        } else if ("updateUser".equals(action)) {
            //updating user info if action is updateUser
            handleUpdateUser(request, response);
        } else {
            //fallback to refresh page if action is missing or invalid
            doGet(request, response);
        }
    }

    /**
     * Handles user deletion logic.
     */
    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        //calling service to delete user
        UserManagementService userService = new UserManagementService();
        String result = userService.deleteUser(userId); // result can be used for setting popup message

        //refreshing the user list
        doGet(request, response);
    }

    /**
     * Handles user update logic.
     */
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //creating user object with updated data from request
        UserModel user = new UserModel();
        user.setUserId(Integer.parseInt(request.getParameter("userId")));
        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhoneNumber(request.getParameter("phoneNumber"));

        //calling service to update user
        UserManagementService userService = new UserManagementService();
        String result = userService.updateUser(user); // result can be used for setting popup message

        //refreshing the user list
        doGet(request, response);
    }
}
