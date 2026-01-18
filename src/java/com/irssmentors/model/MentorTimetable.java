/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.model;

import java.io.Serializable;

/**
 *
 * @author nikla
 */
public class MentorTimetable implements Serializable {
    private String mentorTimeID;
    private String mentorID;
    private String availableDay;
    private String availableTime;
    
    public MentorTimetable(String mentorTimeID, String mentorID, String availableDay, String availableTime){
        this.mentorTimeID = mentorTimeID;
        this.mentorID = mentorID;
        this.availableDay = availableDay;
        this.availableTime = availableTime;
    }
    
     // Getters and Setters
    public String getMentorTimeID() { return mentorTimeID; }
    public void setMentorTimeID(String mentorTimeID) { this.mentorTimeID = mentorTimeID; }
    
    public String getMentorID() { return mentorID; }
    public void setMentorID(String mentorID) { this.mentorID = mentorID; }
    
    public String getAvailableDay() { return availableDay; }
    public void setAvailableDay(String availableDay) { this.availableDay = availableDay; }
    
    public String getAvailableTime() { return availableTime; }
    public void setAvailableTime(String availableTime) { this.availableTime = availableTime; }
}
