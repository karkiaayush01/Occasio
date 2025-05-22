package com.occasio.model;

public class SponsorModel {
    private int sponsorID;           // storing sponsor ID
    private String sponsorName;      // storing sponsor name
    private String sponsorContact;   // storing sponsor contact
    private String sponsorEmail;     // storing sponsor email

    // getting sponsor ID
    public int getSponsorID() {
        return sponsorID;
    }

    // setting sponsor ID
    public void setSponsorID(int sponsorID) {
        this.sponsorID = sponsorID;
    }

    // getting sponsor name
    public String getSponsorName() {
        return sponsorName;
    }

    // setting sponsor name
    public void setSponsorName(String sponsorName) {
        this.sponsorName = sponsorName;
    }

    // getting sponsor contact
    public String getSponsorContact() {
        return sponsorContact;
    }

    // setting sponsor contact
    public void setSponsorContact(String sponsorContact) {
        this.sponsorContact = sponsorContact;
    }

    // getting sponsor email
    public String getSponsorEmail() {
        return sponsorEmail;
    }

    // setting sponsor email
    public void setSponsorEmail(String sponsorEmail) {
        this.sponsorEmail = sponsorEmail;
    }
}