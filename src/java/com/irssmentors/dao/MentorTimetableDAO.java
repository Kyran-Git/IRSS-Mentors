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
            try (Connection con = DBConnection.createConnection()) {
                String sql = "SELECT * FROM MentorTimetable WHERE mentorID = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, mentorID);
                ResultSet rs = ps.executeQuery();

                while(rs.next()){
                    MentorTimetable t = new MentorTimetable();
                    t.setMentorTimeID(rs.getString("mentorTimeID"));
                    t.setAvailableDay(rs.getString("availableDay"));
                    t.setAvailableTime(rs.getString("availableTime"));
                    t.setBookedByID(rs.getString("bookedByID")); // This line is crucial!
                    list.add(t);
                }
            } catch(Exception e) { e.printStackTrace(); }
            return list;
        }

                public boolean bookSlot(String slotID, String menteeID) {
                try (Connection con = DBConnection.createConnection()) {
                    String sql = "UPDATE MentorTimetable SET bookedByID = ? WHERE mentorTimeID = ? AND bookedByID IS NULL";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, menteeID);
                    ps.setString(2, slotID);
                    return ps.executeUpdate() > 0;
                } catch (Exception e) {
                    e.printStackTrace();
                    return false;
                }
            }
    
        public List<MentorTimetable> getTimetableForMentor(String mentorID) {
    List<MentorTimetable> list = new ArrayList<>();
    try (Connection con = DBConnection.createConnection()) {
        // SQL JOIN: Gets timetable data AND the mentee's full name
        String sql = "SELECT t.*, m.menteeFullname FROM MentorTimetable t " +
                     "LEFT JOIN Mentee m ON t.bookedByID = m.menteeID " +
                     "WHERE t.mentorID = ?";
        
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, mentorID);
        ResultSet rs = ps.executeQuery();
        
        while(rs.next()){
            MentorTimetable t = new MentorTimetable();
            t.setMentorTimeID(rs.getString("mentorTimeID"));
            t.setAvailableDay(rs.getString("availableDay"));
            t.setAvailableTime(rs.getString("availableTime"));
            
            // Set the mentee name from the 'menteeFullname' column in the JOIN
            t.setMenteeName(rs.getString("menteeFullname")); 
            
            list.add(t);
        }
    } catch(Exception e) { e.printStackTrace(); }
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
