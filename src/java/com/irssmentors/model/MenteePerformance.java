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
public class MenteePerformance implements Serializable{
    private String menteePerformID;
    private String menteeID;
    private int menteePerformSem;
    private float menteeGpa;
    private String menteePerformStatus;
    private String menteeRemark;
    
    public MenteePerformance(String menteePerformID, String menteeID, int menteePerformSem, 
            float menteeGpa, String menteePerformStatus, String menteeRemark){
        this.menteePerformID=menteePerformID;
        this.menteeID=menteeID;
        this.menteePerformSem=menteePerformSem;
        this.menteeGpa=menteeGpa;
        this.menteePerformStatus=menteePerformStatus;
        this.menteeRemark=menteeRemark;
    }
    public int getMenteePerformSem() { return menteePerformSem; }
    public void setMenteePerformSem(int menteePerformSem) { this.menteePerformSem = menteePerformSem; }
    public float getMenteeGpa() { return menteeGpa; }
    public void setMenteeGpa(float menteeGpa) { this.menteeGpa = menteeGpa; }
    public String getMenteePerformStatus() { return menteePerformStatus; }
    public void setMenteePerformStatus(String menteePerformStatus) { this.menteePerformStatus = menteePerformStatus; }
    public String getMenteeRemark() { return menteeRemark; }
    public void setMenteeRemark(String menteeRemark) { this.menteeRemark = menteeRemark; }
}
