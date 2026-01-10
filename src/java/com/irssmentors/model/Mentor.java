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
    
    private String username;
    private String password;
    private String fullname;
    private String email;
    private String phone;
    private String faculty;
    
    public Mentor(){
        
    }
    
    public Mentor(String username, String password, String fullname, String email, String phone, String faculty){
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.faculty = faculty;
    }
    
    public String getUsername(){return username;}
    public String getPassword(){return password;}
    public String getFullname(){return fullname;}
    public String getEmail(){return email;}
    public String getPhone(){return phone;}
    public String getFaculty(){return faculty;}
    
    public void setUsername(String username){
        this.username = username;
    }
    public void setPassword(String password){
        this.password = password;
    }
    public void setFullname(String fullname){
        this.fullname = fullname;
    }
    public void setEmail(String email){
        this.email = email;
    }
    public void setPhone(String phone){
        this.phone = phone;
    }
    public void setFaculty(String faculty){
        this.faculty = faculty;
    }
}
