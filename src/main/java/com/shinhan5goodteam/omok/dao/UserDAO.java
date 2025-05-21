package com.shinhan5goodteam.omok.dao;

import java.sql.*;

public class UserDAO {

    public boolean isUserIdExist(String userid){
        String sql = "select * from USER_table where user_id = ?";
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

    public boolean isUserNicknameExist(String usernickname){
        String sql = "select * from USER_table where nickname = ?";
        try( Connection conn = DButil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, usernickname);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()){
                    return true;
                }
        } catch ( Exception e) {

        }

        return false;
    }

    public boolean createAccount(String userid, String userpassword, String usernickname,String  profileimage, String profilebackground){
        String sql = "insert into user_table (user_id,nickname,user_pw,profile_image,profile_color) values(?,?,?,?,?)";
        try( Connection conn = DButil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, userid);
                pstmt.setString(2, usernickname);
                pstmt.setString(3, userpassword);
                pstmt.setString(4, profileimage);
                pstmt.setString(5, profilebackground);

                int rows = pstmt.executeUpdate();
                if ( rows > 0) {
                    return true;
                }
        } catch ( Exception e) {

        }
        return false;
    }
}
