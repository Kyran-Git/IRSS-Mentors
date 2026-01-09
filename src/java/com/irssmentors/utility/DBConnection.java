/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.irssmentors.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author nikla
 */
public class DBConnection {
    
    private static final String URL = "jdbc:derby://localhost:1527/MentorshipDB";
    private static final String USER = "app";
    private static final String PASSWORD = "app";
    
    static {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e){
            e.printStackTrace();
        }
    }
    
    public static Connection createConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database connected successfully!");
        } catch (SQLException e) {
            System.out.println("Cannot connect the database!");
            e.printStackTrace();
        }
        return connection;
    }
}
