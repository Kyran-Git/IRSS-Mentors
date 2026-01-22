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

import java.io.Serializable;

public class MenteePerformance implements Serializable {

    private String perfID;      // Column: PERFID
    private String menteeID;    // Column: MENTEEID
    private int semester;       // Column: SEMESTER
    private double gpa;         // Column: GPA
    private String status;      // Column: STATUS

    // Getters
    public String getPerfID() { return perfID; }
    public String getMenteeID() { return menteeID; }
    public int getSemester() { return semester; }
    public double getGpa() { return gpa; }
    public String getStatus() { return status; }

    // Setters
    public void setPerfID(String perfID) { this.perfID = perfID; }
    public void setMenteeID(String menteeID) { this.menteeID = menteeID; }
    public void setSemester(int semester) { this.semester = semester; }
    public void setGpa(double gpa) { this.gpa = gpa; }
    public void setStatus(String status) { this.status = status; }
}