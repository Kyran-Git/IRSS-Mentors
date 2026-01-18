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
public class Mentee implements Serializable{
    
    private String menteeID;
    private String menteeFullname;
    private String menteeEmail;
    private String menteePhone;
    private String menteeProgramme;
    private int menteeSemester;
    private float menteeCgpa;
    private String menteeStatus;
    private String mentorID; //Foreign key
    
    
    //getters
    public String getMenteeID(){
        return menteeID;
    }
    public String getMenteeFullname(){
        return menteeFullname;
    }
    public String getMenteeEmail(){
        return menteeEmail;
    }
    public String getMenteePhone(){
        return menteePhone;
    }
    public String getMenteeProgramme(){
        return menteeProgramme;
    }
    public int getMenteeSemester(){
        return menteeSemester;
    }
    public float getMenteeCgpa(){
        return menteeCgpa;
    }
    public String getMenteeStatus(){
        return menteeStatus;
    }
    public String getMentorID(){
        return mentorID;
    }
    
    //setters
    public void setMenteeID(String menteeID){
        this.menteeID = menteeID;
    }
    public void setMenteeFullname(String menteeFullname){
        this.menteeFullname = menteeFullname;
    }
    public void setMenteeEmail(String menteeEmail){
        this.menteeEmail = menteeEmail;
    }
    public void setMenteePhone(String menteePhone){
        this.menteePhone = menteePhone;
    }
    public void setMenteeProgramme(String menteeProgramme){
        this.menteeProgramme = menteeProgramme;
    }
    public void setMenteeSemester(int menteeSemester){
        this.menteeSemester = menteeSemester;
    }
    public void setMenteeCgpa(float menteeCgpa){
        this.menteeCgpa = menteeCgpa;
    }
    public void setMenteeStatus(String menteeStatus){
        this.menteeStatus = menteeStatus;
    }
    public void setMentorID(String mentorID){
        this.mentorID = mentorID;
    }
}
