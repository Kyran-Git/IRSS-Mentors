/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.dao;

import com.irssmentors.model.Mentee;
import com.irssmentors.model.Mentor;
import com.irssmentors.utility.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nikla
 */
public class MentorDAO {
    public Mentor login(String username, String password) {
        Mentor mentor = null;
        try {
            Connection con = DBConnection.createConnection();
            String sql = "SELECT * FROM Mentor WHERE mentorUsername = ? AND mentorPassword = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                mentor = new Mentor();
                mentor.setMentorID(rs.getString("mentorID"));
                mentor.setMentorFullname(rs.getString("mentorFullname"));
                mentor.setMentorFaculty(rs.getString("mentorFaculty"));
                mentor.setMentorUsername(rs.getString("mentorUsername"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mentor;
    }

    public List<Mentee> getMenteesByMentor(String mentorID) {
        List<Mentee> list = new ArrayList<>();
        try {
            Connection con = DBConnection.createConnection();
            // Assuming table Mentee has FK mentorID
            String sql = "SELECT * FROM Mentee WHERE mentorID = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, mentorID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Mentee m = new Mentee();
                        m.setMenteeID(rs.getString("menteeID"));
                        m.setMenteeFullname(rs.getString("menteeFullname"));
                        m.setMenteeProgramme(rs.getString("menteeProgramme"));
                        m.setMenteeSemester(rs.getInt("menteeSemester"));
                        m.setMenteeEmail(rs.getString("menteeEmail"));
                        m.setMenteePhone(rs.getString("menteePhone"));
                list.add(m);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
                        public Mentor getMentorByID(String mentorID) {
                Mentor mentor = null;
                // Using try-with-resources to automatically close the connection
                try (Connection con = DBConnection.createConnection()) {
                    String sql = "SELECT * FROM Mentor WHERE mentorID = ?";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, mentorID);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        mentor = new Mentor();
                        // Match these EXACTLY to your Database column names
                        mentor.setMentorID(rs.getString("mentorID"));
                        mentor.setMentorFullname(rs.getString("mentorFullname"));
                        mentor.setMentorEmail(rs.getString("mentorEmail"));
                        mentor.setMentorPhone(rs.getString("mentorPhone"));
                        mentor.setMentorFaculty(rs.getString("mentorFaculty"));
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return mentor;
            }
}
