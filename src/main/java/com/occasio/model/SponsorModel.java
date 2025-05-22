package com.occasio.model;

public class SponsorModel {
    private int sponsorID;
    private String sponsorName;
    private String sponsorContact;
    private String sponsorEmail;

    // Getters and setters for all fields

    public int getSponsorID() {
        return sponsorID;
    }

    public void setSponsorID(int sponsorID) {
        this.sponsorID = sponsorID;
    }

    public String getSponsorName() {
        return sponsorName;
    }

    public void setSponsorName(String sponsorName) {
        this.sponsorName = sponsorName;
    }

    public String getSponsorContact() {
        return sponsorContact;
    }

    public void setSponsorContact(String sponsorContact) {
        this.sponsorContact = sponsorContact;
    }

    public String getSponsorEmail() {
        return sponsorEmail;
    }

    public void setSponsorEmail(String sponsorEmail) {
        this.sponsorEmail = sponsorEmail;
    }
}