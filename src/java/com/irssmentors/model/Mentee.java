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
public class Mentee implements Serializable {

    private String menteeID;
    private String menteeUsername;
    private String menteePassword;
    private String menteeFullname;
    private String menteeEmail;
    private String menteePhone;
    private String menteeProgramme;
    private int menteeSemester;
    private float menteeCgpa;
    private String menteeStatus;
    private String mentorID; // Foreign key

    public Mentee(String menteeID, String menteeUsername, String menteePassword, String menteeFullname,
            String menteeEmail, String menteePhone,
            String menteeProgramme, int menteeSemester, float menteeCgpa, String menteeStatus, String mentorID) {
        this.menteeID = menteeID;
        this.menteeUsername = menteeUsername;
        this.menteePassword = menteePassword;
        this.menteeFullname = menteeFullname;
        this.menteeEmail = menteeEmail;
        this.menteePhone = menteePhone;
        this.menteeProgramme = menteeProgramme;
        this.menteeSemester = menteeSemester;
        this.menteeCgpa = menteeCgpa;
        this.menteeStatus = menteeStatus;
        this.mentorID = mentorID;
    }

    public Mentee(String menteeID, String menteeFullname, String menteeProgramme, int menteeSemester,
            String menteeEmail, String menteePhone) {
        this.menteeID = menteeID;
        this.menteeFullname = menteeFullname;
        this.menteeProgramme = menteeProgramme;
        this.menteeSemester = menteeSemester;
        this.menteeEmail = menteeEmail;
        this.menteePhone = menteePhone;
    }

    public Mentee(String username, String password) {
        this.menteeUsername = username;
        this.menteePassword = password;
    }

    public Mentee() {

    }

    // getters
    public String getMenteeID() {
        return menteeID;
    }

    public String getMenteeUsername() {
        return menteeUsername;
    }

    public String getMenteePassword() {
        return menteePassword;
    }

    public String getMenteeFullname() {
        return menteeFullname;
    }

    public String getMenteeEmail() {
        return menteeEmail;
    }

    public String getMenteePhone() {
        return menteePhone;
    }

    public String getMenteeProgramme() {
        return menteeProgramme;
    }

    public int getMenteeSemester() {
        return menteeSemester;
    }

    public float getMenteeCgpa() {
        return menteeCgpa;
    }

    public String getMenteeStatus() {
        return menteeStatus;
    }

    public String getMentorID() {
        return mentorID;
    }

    // setters
    public void setMenteeID(String menteeID) {
        this.menteeID = menteeID;
    }

    public void setMenteeUsername(String menteeUsername) {
        this.menteeUsername = menteeUsername;
    }

    public void setMenteePassword(String menteePassword) {
        this.menteePassword = menteePassword;
    }

    public void setMenteeFullname(String menteeFullname) {
        this.menteeFullname = menteeFullname;
    }

    public void setMenteeEmail(String menteeEmail) {
        this.menteeEmail = menteeEmail;
    }

    public void setMenteePhone(String menteePhone) {
        this.menteePhone = menteePhone;
    }

    public void setMenteeProgramme(String menteeProgramme) {
        this.menteeProgramme = menteeProgramme;
    }

    public void setMenteeSemester(int menteeSemester) {
        this.menteeSemester = menteeSemester;
    }

    public void setMenteeCgpa(float menteeCgpa) {
        this.menteeCgpa = menteeCgpa;
    }

    public void setMenteeStatus(String menteeStatus) {
        this.menteeStatus = menteeStatus;
    }

    public void setMentorID(String mentorID) {
        this.mentorID = mentorID;
    }
}
