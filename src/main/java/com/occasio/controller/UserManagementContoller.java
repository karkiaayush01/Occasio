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

@WebServlet(asyncSupported = true, urlPatterns = { "/userManagement" })
public class UserManagementContoller extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserManagementContoller() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        int orgId = user.getOrgId();

        UserManagementService userService = new UserManagementService();
        List<UserModel> users = userService.getAllUsersInOrganization(orgId);

        request.setAttribute("users", users);
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("fullName", user.getFullName());
        request.setAttribute("userEmail", user.getEmail());
        request.setAttribute("organizationId", user.getOrgId());
        request.setAttribute("userPhoneNumber", user.getPhoneNumber());
        request.setAttribute("userProfileImgUrl", user.getProfilePicturePath());

        request.getRequestDispatcher("/WEB-INF/pages/userManagement.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("deleteUser".equals(action)) {
            handleDeleteUser(request, response);
        } else if ("updateUser".equals(action)) {
            handleUpdateUser(request, response);
        } else {
            doGet(request, response); // Refresh the page in other cases
        }
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        UserManagementService userService = new UserManagementService();
        String result = userService.deleteUser(userId);

        doGet(request, response); // Refresh the page
    }

    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = new UserModel();
        user.setUserId(Integer.parseInt(request.getParameter("userId")));
        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhoneNumber(request.getParameter("phoneNumber"));

        UserManagementService userService = new UserManagementService();
        String result = userService.updateUser(user);

        doGet(request, response);
    }
}