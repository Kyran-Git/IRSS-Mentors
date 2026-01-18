/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.dao;

import com.irssmentors.model.MentorTimetable;
import com.irssmentors.utility.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author nikla
 */
public class MentorTimetableDAO {
    public List<MentorTimetable> getTimetable(String mentorID) {
        List<MentorTimetable> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.createConnection();
            String sql = "SELECT * FROM MentorTimetable WHERE mentorID = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, mentorID);
            rs = ps.executeQuery();
            
            while(rs.next()){
                MentorTimetable t = new MentorTimetable();
                
                t.setMentorTimeID(rs.getString("mentorTimeID"));
                t.setMentorID(rs.getString("mentorID"));
                t.setAvailableDay(rs.getString("availableDay"));
                t.setAvailableTime(rs.getString("availableTime"));
                
                list.add(t);
                System.out.println("DAO: Found slot " + t.getAvailableDay() + " for " + mentorID);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs!=null) rs.close(); } catch(Exception e){}
            try { if(ps!=null) ps.close(); } catch(Exception e){}
            try { if(con!=null) con.close(); } catch(Exception e){}
        }
        return list;
    }
    
    public void addSlot(MentorTimetable slot) {
        Connection con = null;
        try {
            con = DBConnection.createConnection();
            String sql = "INSERT INTO MentorTimetable (mentorTimeID, mentorID, availableDay, availableTime) VALUES (?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            
            // Generate Random ID for Primary Key
            String uuid = UUID.randomUUID().toString().substring(0, 10);
            
            ps.setString(1, uuid);
            ps.setString(2, slot.getMentorID());
            ps.setString(3, slot.getAvailableDay());
            ps.setString(4, slot.getAvailableTime());
            
            ps.executeUpdate();
            con.close();
        } catch(SQLException e) { 
            e.printStackTrace(); 
        }
    }
    
    public void removeSlot(String id) {
        Connection con = null;
        try {
            con = DBConnection.createConnection();
            String sql = "DELETE FROM MentorTimetable WHERE mentorTimeID = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
            con.close();
        } catch(Exception e) { e.printStackTrace(); }
    }
}
