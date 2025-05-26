package com.shinhan5goodteam.omok.dao;

import java.sql.Connection;
import java.sql.DriverManager;

//오라클 db 연동
public class DButil {
	private static final String URL = "jdbc:oracle:thin:@192.168.0.147:1521:xe"; // orcl이면 xe 대신 orcl
    private static final String USER = "OMOK";
    private static final String PASSWORD = "omok1234";

    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver"); // JDBC 드라이버 로딩
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}