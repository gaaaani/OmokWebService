package com.shinhan5goodteam.omok.dao;

import java.sql.*;

import com.shinhan5goodteam.omok.model.User;

public class UserDAO {

    public boolean isUserIdExist(String userid) {
        String sql = "select * from USER_table where user_id = ?";
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
                user.setPoints(rs.getInt("points"));
                user.setProfileimage(rs.getString("profile_image"));
                user.setProfilecolor(rs.getString("profile_color"));

                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // userId로 User 객체를 반환
    public User findById(String userId) {
        User user = null;
        String sql = "SELECT USER_ID, NICKNAME, POINTS, PROFILE_IMAGE, PROFILE_COLOR FROM USER_TABLE WHERE USER_ID = ?";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserid(rs.getString("user_id"));
                user.setNickname(rs.getString("nickname"));
                user.setPoints(rs.getInt("points"));
                user.setProfileimage(rs.getString("profile_image"));
                user.setProfilecolor(rs.getString("profile_color"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean isUserNicknameExist(String usernickname) {
        String sql = "select * from USER_table where nickname = ?";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, usernickname);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {

        }

        return false;
    }

    public boolean createAccount(String userid, String userpassword, String usernickname, String profileimage,
            String profilebackground) {
        String sql = "insert into user_table (user_id,nickname,user_pw,profile_image,profile_color) values(?,?,?,?,?)";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid);
            pstmt.setString(2, usernickname);
            pstmt.setString(3, userpassword);
            pstmt.setString(4, profileimage);
            pstmt.setString(5, profilebackground);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                return true;
            }
        } catch (Exception e) {

        }
        return false;
    }
}
