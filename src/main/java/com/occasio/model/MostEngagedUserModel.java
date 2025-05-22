package com.occasio.model;

public class MostEngagedUserModel {
    private String fullName;
    private String email;
    private String profilePicturePath;
    private int engagementCount;

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getProfilePicturePath() {
        return profilePicturePath;
    }

    public void setProfilePicturePath(String profilePicturePath) {
        this.profilePicturePath = profilePicturePath;
    }

    public int getEngagementCount() {
        return engagementCount;
    }

    public void setEngagementCount(int engagementCount) {
        this.engagementCount = engagementCount;
    }
}