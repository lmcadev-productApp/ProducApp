package com.poli.productApp;

import java.sql.Connection;
import com.poli.productApp.util.DBConnection;

public class TestDB {
    public static void main(String[] args) {
        try {
            Connection con = DBConnection.getConnection();
            System.out.println("¡Conexión exitosa!");
            con.close();
        } catch (Exception e) {
            System.out.println("Error de conexión: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
