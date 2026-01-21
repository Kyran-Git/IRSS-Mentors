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
    
    public String authenticateUser(Mentee mentee){
        
        String username = mentee.getUsername();
        String password = mentee.getPassword();
        
        Connection con = null;
        Statement statement = null;
        ResultSet resultSet = null;
        String usernameDB = "";
        String passwordDB = "";
        
        try{
            con = DBConnection.createConnection();
            statement = con.createStatement();
            resultSet = statement.executeQuery("SELECT MENTEEUSERNAME, MENTEEPASSWORD FROM MENTEE");
            while(resultSet.next()){
                usernameDB = resultSet.getString("MENTEEUSERNAME");
                passwordDB = resultSet.getString("MENTEEPASSWORD");
                if(username.equals(usernameDB) && password.equals(passwordDB)){
                    return "SUCCESS";
                }
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return "Invalid user credentials";
    }
    
}
