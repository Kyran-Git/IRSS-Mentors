package com.irssmentors.dao;

import com.irssmentors.model.Admin;
import com.irssmentors.model.Mentee;
import com.irssmentors.model.Mentor;
import com.irssmentors.utility.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    
    // 1. Authenticate Admin
    public String authenticateUser(Admin admin){
        String username = admin.getUsername();
        String password = admin.getPassword();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try{
            con = DBConnection.createConnection();
            String sql = "SELECT * FROM Admin WHERE adminUsername=? AND adminPassword=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            resultSet = ps.executeQuery();
            if(resultSet.next()){
                return "SUCCESS";
            }
        } catch (SQLException e){
            e.printStackTrace();
        } finally {
            try { if(con!=null) con.close(); } catch(Exception e){}
        }
        return "Invalid user credentials";
    }
    
    // 2. Register Mentor
    public String registerNewMentor(Mentor mentor){
        Connection con = null;
        try{
            con = DBConnection.createConnection();
            String query = "INSERT INTO Mentor (mentorID, mentorUsername, mentorPassword, mentorFullname, mentorEmail, mentorPhone, mentorFaculty) VALUES (?,?,?,?,?,?,?)";
            PreparedStatement stmt = con.prepareStatement(query);
          
            stmt.setString(1, mentor.getMentorID());
            stmt.setString(2, mentor.getMentorUsername());
            stmt.setString(3, mentor.getMentorPassword());
            stmt.setString(4, mentor.getMentorFullname());
            stmt.setString(5, mentor.getMentorEmail());
            stmt.setString(6, mentor.getMentorPhone());
            stmt.setString(7, mentor.getMentorFaculty());
            
            int i = stmt.executeUpdate();
            con.close();
            if(i > 0) return "SUCCESS";
            
        } catch (SQLException e){
            e.printStackTrace();
            System.out.println("Register Error: " + e.getMessage()); 
        }
        return "Failed register";
    }
    
    // 3. Get List
    public List<Mentor> getMentorList(){
        List<Mentor> mentorList = new ArrayList<>();
        Connection con = null;
        try{
            con = DBConnection.createConnection();
            String query = "SELECT * FROM Mentor";
            PreparedStatement statement = con.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                Mentor mentor = new Mentor();
                mentor.setMentorID(resultSet.getString("mentorID"));
                mentor.setMentorUsername(resultSet.getString("mentorUsername"));
                mentor.setMentorPassword(resultSet.getString("mentorPassword"));
                mentor.setMentorFullname(resultSet.getString("mentorFullname"));
                mentor.setMentorEmail(resultSet.getString("mentorEmail"));
                mentor.setMentorPhone(resultSet.getString("mentorPhone"));
                mentor.setMentorFaculty(resultSet.getString("mentorFaculty"));
                mentorList.add(mentor);
            }
            con.close();
        } catch (SQLException e){ e.printStackTrace(); }
        return mentorList;
    }

    // 4. Search
    public List<Mentor> searchMentorsByName(String name) {
        List<Mentor> mentorList = new ArrayList<>();
        try {
            Connection con = DBConnection.createConnection();
            String query = "SELECT * FROM Mentor WHERE mentorFullname LIKE ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setMentorID(rs.getString("mentorID"));
                mentor.setMentorUsername(rs.getString("mentorUsername"));
                mentor.setMentorPassword(rs.getString("mentorPassword"));
                mentor.setMentorFullname(rs.getString("mentorFullname"));
                mentor.setMentorEmail(rs.getString("mentorEmail"));
                mentor.setMentorPhone(rs.getString("mentorPhone"));
                mentor.setMentorFaculty(rs.getString("mentorFaculty"));
                mentorList.add(mentor);
            }
            con.close();
        } catch (SQLException e) { e.printStackTrace(); }
        return mentorList;
    }
    
    // 5. Sort
    public List<Mentor> getSortedMentorList(String column) {
        List<Mentor> mentorList = new ArrayList<>();
        String orderBy = "mentorFullname"; 
        if ("faculty".equals(column)) { orderBy = "mentorFaculty"; }

        try {
            Connection con = DBConnection.createConnection();
            String query = "SELECT * FROM Mentor ORDER BY " + orderBy + " ASC";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setMentorID(rs.getString("mentorID"));
                mentor.setMentorUsername(rs.getString("mentorUsername"));
                mentor.setMentorPassword(rs.getString("mentorPassword"));
                mentor.setMentorFullname(rs.getString("mentorFullname"));
                mentor.setMentorEmail(rs.getString("mentorEmail"));
                mentor.setMentorPhone(rs.getString("mentorPhone"));
                mentor.setMentorFaculty(rs.getString("mentorFaculty"));
                mentorList.add(mentor);
            }
            con.close();
        } catch (SQLException e) { e.printStackTrace(); }
        return mentorList;
    }
    
    // 6. Get By ID
    public Mentor getMentorByID(String mentorID) {
        Mentor mentor = null;
        try {
            Connection con = DBConnection.createConnection();
            String query = "SELECT * FROM Mentor WHERE mentorID = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, mentorID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                mentor = new Mentor();
                mentor.setMentorID(rs.getString("mentorID"));
                mentor.setMentorUsername(rs.getString("mentorUsername"));
                mentor.setMentorPassword(rs.getString("mentorPassword"));
                mentor.setMentorFullname(rs.getString("mentorFullname"));
                mentor.setMentorEmail(rs.getString("mentorEmail"));
                mentor.setMentorPhone(rs.getString("mentorPhone"));
                mentor.setMentorFaculty(rs.getString("mentorFaculty"));
            }
            con.close();
        } catch (SQLException e) { e.printStackTrace(); }
        return mentor;
    }
    
    // 7. Update
    public void updateMentor(Mentor mentor){
        try{
            Connection con = DBConnection.createConnection(); 
            String query = "UPDATE Mentor SET mentorPassword=?, mentorFullname=?, mentorEmail=?, mentorPhone=?, mentorFaculty=?, mentorUsername=? WHERE mentorID=?";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1,mentor.getMentorPassword());
            statement.setString(2,mentor.getMentorFullname());
            statement.setString(3,mentor.getMentorEmail());
            statement.setString(4,mentor.getMentorPhone());
            statement.setString(5,mentor.getMentorFaculty());
            statement.setString(6,mentor.getMentorUsername());
            statement.setString(7,mentor.getMentorID());
            statement.executeUpdate();
            con.close();
        } catch (Exception e){ e.printStackTrace(); }
    }
    
    public String deleteMentor(String mentorID) {
        Connection con = null;
        try {
            con = DBConnection.createConnection();
            con.setAutoCommit(false);

            String unassignQuery = "UPDATE Mentee SET mentorID = NULL WHERE mentorID = ?";
            PreparedStatement psUnassign = con.prepareStatement(unassignQuery);
            psUnassign.setString(1, mentorID);
            psUnassign.executeUpdate();

            String deleteQuery = "DELETE FROM Mentor WHERE mentorID = ?";
            PreparedStatement psDelete = con.prepareStatement(deleteQuery);
            psDelete.setString(1, mentorID);
            int result = psDelete.executeUpdate();

            con.commit();
            con.close();

            if (result > 0) return "SUCCESS";
        } catch (SQLException e) {
            if(con != null) { try { con.rollback(); } catch(Exception ex){} }
            e.printStackTrace();
        }
        return "FAILURE";
    }
    
    public List<Mentee> getMenteeList() {
        List<Mentee> menteeList = new ArrayList<>();
        try (Connection con = DBConnection.createConnection()) {
            String query = "SELECT * FROM Mentee";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Mentee m = new Mentee();
                m.setMenteeID(rs.getString("menteeID"));
                m.setMenteeFullname(rs.getString("menteeFullname"));
                m.setMenteeProgramme(rs.getString("menteeProgramme"));
                m.setMenteeSemester(rs.getInt("menteeSemester"));
                m.setMenteeEmail(rs.getString("menteeEmail"));
                m.setMentorID(rs.getString("mentorID")); 
                m.setMenteeCGPA(rs.getDouble("menteeCGPA")); 

                menteeList.add(m);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return menteeList;
    }

    public boolean assignMentorToMentee(String menteeID, String mentorID) {
        try (Connection con = DBConnection.createConnection()) {
            String query = "UPDATE Mentee SET mentorID = ? WHERE menteeID = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, mentorID.isEmpty() ? null : mentorID);
            ps.setString(2, menteeID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Mentee> searchMenteesByName(String name) {
        List<Mentee> menteeList = new ArrayList<>();
        try (Connection con = DBConnection.createConnection()) {
            String query = "SELECT * FROM Mentee WHERE menteeFullname LIKE ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Mentee m = new Mentee();
                m.setMenteeID(rs.getString("menteeID"));
                m.setMenteeFullname(rs.getString("menteeFullname"));
                m.setMentorID(rs.getString("mentorID"));
                m.setMenteeCGPA(rs.getDouble("menteeCGPA")); 
                menteeList.add(m);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return menteeList;
    }

    public List<Mentee> getSortedMenteeList(String column) {
        List<Mentee> menteeList = new ArrayList<>();
        String orderBy;

        if ("programme".equals(column)) {
            orderBy = "menteeProgramme ASC";
        } else if ("status".equals(column)) {
            orderBy = "(CASE WHEN mentorID IS NULL THEN 0 ELSE 1 END) ASC, menteeFullname ASC";
        } else if ("cgpa".equals(column)) {
            orderBy = "menteeCGPA DESC";
        } else {
            orderBy = "menteeFullname ASC";
        }

        String query = "SELECT * FROM Mentee ORDER BY " + orderBy;
        try (Connection con = DBConnection.createConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Mentee m = new Mentee();
                m.setMenteeID(rs.getString("menteeID"));
                m.setMenteeFullname(rs.getString("menteeFullname"));
                m.setMenteeProgramme(rs.getString("menteeProgramme"));
                m.setMentorID(rs.getString("mentorID"));
                m.setMenteeCGPA(rs.getDouble("menteeCGPA"));
                menteeList.add(m);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return menteeList;
    }

    public List<Mentee> getMenteesByMentor(String mentorID) {
        List<Mentee> menteeList = new ArrayList<>();
        String query = "SELECT * FROM Mentee WHERE mentorID = ?";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, mentorID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Mentee m = new Mentee();
                m.setMenteeID(rs.getString("menteeID"));
                m.setMenteeFullname(rs.getString("menteeFullname"));
                m.setMenteeProgramme(rs.getString("menteeProgramme"));
                m.setMentorID(rs.getString("mentorID"));
                m.setMenteeCGPA(rs.getDouble("menteeCGPA")); 
                menteeList.add(m);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return menteeList;
    }
    
    public boolean updateMenteePerformance(String menteeID, double cgpa) {
        String query = "UPDATE Mentee SET menteeCGPA = ? WHERE menteeID = ?";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setDouble(1, cgpa);
            ps.setString(2, menteeID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}