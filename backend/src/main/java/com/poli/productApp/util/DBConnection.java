package com.poli.productApp.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    private static Connection connection;

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Properties props = new Properties();
                FileInputStream fis = new FileInputStream("config.properties");
                props.load(fis);

                String url = props.getProperty("db.url");
                String user = props.getProperty("db.user");
                String password = props.getProperty("db.password");

                connection = DriverManager.getConnection(url, user, password);
                System.out.println("¡Conexión exitosa!");
            } catch (IOException e) {
                throw new SQLException("Error leyendo archivo de configuración", e);
            }
        }
        return connection;
    }
}
