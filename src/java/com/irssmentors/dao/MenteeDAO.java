/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.dao;

import com.irssmentors.model.Admin;
import com.irssmentors.model.Mentor;
import com.irssmentors.model.Mentee;
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
public class MenteeDAO {

    public Mentee login(String username, String password) {
        Mentee mentee = null;
        // Using try-with-resources is better practice for auto-closing connections
        try (Connection con = DBConnection.createConnection()) {
            String sql = "SELECT * FROM MENTEE WHERE MENTEEUSERNAME = ? AND MENTEEPASSWORD = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                mentee = new Mentee(); // Use the empty constructor you added earlier

                // Use the column names EXACTLY as they appear in your SQL database
                mentee.setMenteeID(rs.getString("MENTEEID"));
                mentee.setMenteeFullname(rs.getString("MENTEEFULLNAME"));
                mentee.setMenteeProgramme(rs.getString("MENTEEPROGRAMME"));
                mentee.setMenteeSemester(rs.getInt("MENTEESEMESTER"));
                mentee.setMenteeEmail(rs.getString("MENTEEEMAIL"));
                mentee.setMenteePhone(rs.getString("MENTEEPHONE"));
                mentee.setMenteeUsername(rs.getString("MENTEEUSERNAME"));
                
                mentee.setMentorID(rs.getString("MENTORID"));
            }
            // No need for manual con.close() if using try-with-resources
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mentee;
    }

    public String authenticateUser(Mentee mentee) {

        String username = mentee.getMenteeUsername();
        String password = mentee.getMenteePassword();

        Connection con = null;
        Statement statement = null;
        ResultSet resultSet = null;
        String usernameDB = "";
        String passwordDB = "";

        try {
            con = DBConnection.createConnection();
            statement = con.createStatement();
            resultSet = statement.executeQuery("SELECT MENTEEUSERNAME, MENTEEPASSWORD FROM MENTEE");
            while (resultSet.next()) {
                usernameDB = resultSet.getString("MENTEEUSERNAME");
                passwordDB = resultSet.getString("MENTEEPASSWORD");
                if (username.equals(usernameDB) && password.equals(passwordDB)) {
                    return "SUCCESS";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Invalid user credentials";
    }

}
