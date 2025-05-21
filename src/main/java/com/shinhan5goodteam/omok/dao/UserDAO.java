package com.shinhan5goodteam.omok.dao;

import java.sql.*;

public class UserDAO {

    public boolean isUserIdExist(String userid){
        String sql = "select * from USER where user_id = ?";
        try( Connection conn = DButil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, userid);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()){
                    return true;
                }
        } catch ( Exception e) {

        }

        return false;
    }
}
