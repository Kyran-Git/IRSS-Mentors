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
public class Mentor implements Serializable{
    
    private String mentorID;
    private String mentorUsername;
    private String mentorPassword;
    private String mentorFullname;
    private String mentorEmail;
    private String mentorPhone;
    private String mentorFaculty;
    
    
    
    public String getMentorID(){return mentorID;}
    public String getMentorUsername(){return mentorUsername;}
    public String getMentorPassword(){return mentorPassword;}
    public String getMentorFullname(){return mentorFullname;}
    public String getMentorEmail(){return mentorEmail;}
    public String getMentorPhone(){return mentorPhone;}
    public String getMentorFaculty(){return mentorFaculty;}
    
    
    public void setMentorID(String mentorID){
        this.mentorID = mentorID;
    }
    public void setMentorUsername(String mentorUsername){
        this.mentorUsername = mentorUsername;
    }
    public void setMentorPassword(String mentorPassword){
        this.mentorPassword = mentorPassword;
    }
    public void setMentorFullname(String mentorFullname){
        this.mentorFullname = mentorFullname;
    }
    public void setMentorEmail(String mentorEmail){
        this.mentorEmail = mentorEmail;
    }
    public void setMentorPhone(String mentorPhone){
        this.mentorPhone = mentorPhone;
    }
    public void setMentorFaculty(String mentorFaculty){
        this.mentorFaculty = mentorFaculty;
    }
}
