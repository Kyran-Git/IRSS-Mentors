/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.dao;

/**
 *
 * @author nikla
 */

import com.irssmentors.model.MenteePerformance;
import com.irssmentors.utility.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenteePerformanceDAO {
    
    public List<MenteePerformance> getPerformanceByMentee(String menteeID) {
        List<MenteePerformance> list = new ArrayList<>();
        
        try (Connection con = DBConnection.createConnection()) {
            
            String sql = "SELECT * FROM MENTEEPERFORMANCE WHERE MENTEEID = ? ORDER BY SEMESTER ASC";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, menteeID);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                MenteePerformance mp = new MenteePerformance();
                
                mp.setPerfID(rs.getString("PERFID"));
                mp.setMenteeID(rs.getString("MENTEEID"));
                mp.setSemester(rs.getInt("SEMESTER"));
                mp.setGpa(rs.getDouble("GPA"));
                mp.setStatus(rs.getString("STATUS"));
                
                list.add(mp);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
}
