package com.shinhan5goodteam.omok.dao;

import java.sql.*;

import com.shinhan5goodteam.omok.model.User;

public class UserDAO {

    public boolean isUserIdExist(String userid) {
        String sql = "select * from USER where user_id = ?";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {

        }

        return false;
    }

    // 로그인용 메서드 추가
    public User login(String userid, String userpw) {
        String sql = "SELECT * FROM USER_TABLE WHERE user_id = ? AND user_pw = ?";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid);
            pstmt.setString(2, userpw);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserid(rs.getString("user_id"));
                user.setUserpw(rs.getString("user_pw"));
                user.setNickname(rs.getString("nickname")); 

                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
