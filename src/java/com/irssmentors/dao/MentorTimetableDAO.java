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
        try {
            Connection con = DBConnection.createConnection();
            String sql = "SELECT * FROM MentorTimetable WHERE mentorID = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, mentorID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                MentorTimetable mt = new MentorTimetable();
                mt.setMentorTimeID(rs.getString("mentorTimeID"));
                mt.setMentorID(rs.getString("mentorID"));
                mt.setAvailableDay(rs.getString("availableDay"));
                mt.setAvailableTime(rs.getString("availableTime"));
                list.add(mt);
            }
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean addSlot(MentorTimetable slot) {
        boolean status = false;
        try {
            Connection con = DBConnection.createConnection();
            String sql = "INSERT INTO MentorTimetable (mentorTimeID, mentorID, availableDay, availableTime) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, UUID.randomUUID().toString().substring(0, 8)); 
            ps.setString(2, slot.getMentorID());
            ps.setString(3, slot.getAvailableDay());
            ps.setString(4, slot.getAvailableTime());
            
            status = ps.executeUpdate() > 0;
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
        return status;
    }
    
    public boolean removeSlot(String timeID) {
        boolean status = false;
        try {
            Connection con = DBConnection.createConnection();
            String sql = "DELETE FROM MentorTimetable WHERE mentorTimeID = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, timeID);
            status = ps.executeUpdate() > 0;
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
        return status;
    }
}
