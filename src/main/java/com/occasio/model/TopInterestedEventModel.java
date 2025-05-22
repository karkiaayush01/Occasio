package com.occasio.model;

public class TopInterestedEventModel {
    private String eventName;//storing event name
    private int interestCount;//storing interest count

    //getting event name
    public String getEventName() {
        return eventName;
    }

    //setting event name
    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    //getting interest count
    public int getInterestCount() {
        return interestCount;
    }

    //setting interest count
    public void setInterestCount(int interestCount) {
        this.interestCount = interestCount;
    }
}