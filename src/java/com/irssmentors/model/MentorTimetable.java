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
    private String bookedByID;
    private String menteeName;
    
    
     // Getters and Setters
    public String getMentorTimeID() { return mentorTimeID; }
    public void setMentorTimeID(String mentorTimeID) { this.mentorTimeID = mentorTimeID; }
    
    public String getMentorID() { return mentorID; }
    public void setMentorID(String mentorID) { this.mentorID = mentorID; }
    
    public String getAvailableDay() { return availableDay; }
    public void setAvailableDay(String availableDay) { this.availableDay = availableDay; }
    
    public String getAvailableTime() { return availableTime; }
    public void setAvailableTime(String availableTime) { this.availableTime = availableTime; }
    
    public String getBookedByID() { return bookedByID; }
    public void setBookedByID(String bookedByID) { this.bookedByID = bookedByID; }

    public String getMenteeName() { return menteeName; }
    public void setMenteeName(String menteeName) { this.menteeName = menteeName; }
}
