/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.dao;

import com.irssmentors.model.Admin;
import com.irssmentors.model.Mentor;
import com.irssmentors.utility.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nikla
 */
public class AdminDAO {
    
    public String authenticateUser(Admin admin){
        
        String username = admin.getUsername();
        String password = admin.getPassword();
        
        Connection con = null;
        Statement statement = null;
        ResultSet resultSet = null;
        String usernameDB = "";
        String passwordDB = "";
        
        try{
            con = DBConnection.createConnection();
            statement = con.createStatement();
            resultSet = statement.executeQuery("select username,password from admin");
            while(resultSet.next()){
                usernameDB = resultSet.getString("username");
                passwordDB = resultSet.getString("password");
                if(username.equals(usernameDB) && password.equals(passwordDB)){
                    return "SUCCESS";
                }
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return "Invalid user credentials";
    }
    
    public String registerNewMentor(Mentor mentor){
        
        String username = mentor.getUsername();
        String password = mentor.getPassword();
        String mentorFullname = mentor.getFullname();
        String mentorEmail = mentor.getEmail();
        String mentorPhone = mentor.getPhone();
        String mentorFaculty = mentor.getFaculty();
        
        Connection con = null;
        
        try{
            con = DBConnection.createConnection();
            String query = "INSERT INTO MENTORS (username, password, fullname, email, phone, faculty) VALUES (?,?,?,?,?,?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, mentorFullname);
            stmt.setString(4, mentorEmail);
            stmt.setString(5, mentorPhone);
            stmt.setString(6, mentorFaculty);
            stmt.executeUpdate();
            con.close();
            return "SUCCESS";
        } catch (SQLException e){
            e.printStackTrace();
        }
        return "Failed register";
    }
    
    public List<Mentor> getMentorList(){
        
        List<Mentor> mentorList = new ArrayList<>();
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try{
            con = DBConnection.createConnection();
            String query = "SELECT * FROM MENTORS";
            statement = con.prepareStatement(query);
            resultSet = statement.executeQuery();
            
            while(resultSet.next()){
                Mentor mentor = new Mentor(
                resultSet.getString("username"),
                resultSet.getString("password"),
                resultSet.getString("fullname"),
                resultSet.getString("email"),
                resultSet.getString("phone"),
                resultSet.getString("faculty")
                );
                mentorList.add(mentor);
            }
        } catch (SQLException e){
            e.printStackTrace();
        } finally {
            try { if (resultSet != null) resultSet.close(); } catch (Exception e) {}
            try { if (statement != null) statement.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        return mentorList;
    }
    
    public Mentor getMentorByUsername(String username) {
    Mentor mentor = null;
    try (Connection con = DBConnection.createConnection()) {
        String query = "SELECT * FROM MENTORS WHERE username = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            mentor = new Mentor(
                rs.getString("username"),
                rs.getString("password"),
                rs.getString("fullname"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("faculty")
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return mentor;
}
    
    public List<Mentor> setMentor(String username, String password, String fullname, String email, String phone, String faculty){
        
        Connection con = null;
        PreparedStatement statement = null;
        
        try{
            con = DBConnection.createConnection(); 
            String query = "UPDATE MENTORS SET password=?, fullname=?, email=?, phone=?, faculty=? WHERE username=?";
            statement = con.prepareStatement(query);
            
            statement.setString(1,password);
            statement.setString(2,fullname);
            statement.setString(3,email);
            statement.setString(4,phone);
            statement.setString(5,faculty);
            statement.setString(6,username);
            
            statement.executeUpdate();
   
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close();} catch (Exception e) {}
        }
        return getMentorList();
    }
    
    public String deleteMentor(String username) {
        Connection con = null;
        PreparedStatement statement = null;
        try {
            con = DBConnection.createConnection();
            String query = "DELETE FROM MENTORS WHERE username = ?";
            statement = con.prepareStatement(query);
            statement.setString(1, username);

            int result = statement.executeUpdate();
            if (result > 0) return "SUCCESS";
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        return "FAILURE";
    }
}
