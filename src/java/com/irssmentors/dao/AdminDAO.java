/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.dao;

import com.irssmentors.model.Admin;
import com.irssmentors.utility.DBConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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
}
