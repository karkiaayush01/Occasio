package com.occasio.model;

/**
 * Model class representing the user with the most engagement (likes, comments, interests, etc.).
 */
public class MostEngagedUserModel {
    private String fullName;              //user's full name
    private String email;                 //user's email address
    private String profilePicturePath;   //path to user's profile picture
    private int engagementCount;         //number of engagements made by the user

    //getter and setter for full name
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    //getter and setter for email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    //getter and setter for profile picture path
    public String getProfilePicturePath() {
        return profilePicturePath;
    }

    public void setProfilePicturePath(String profilePicturePath) {
        this.profilePicturePath = profilePicturePath;
    }

    //getter and setter for engagement count
    public int getEngagementCount() {
        return engagementCount;
    }

    public void setEngagementCount(int engagementCount) {
        this.engagementCount = engagementCount;
    }
}
