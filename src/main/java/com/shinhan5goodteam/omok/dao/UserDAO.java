package com.shinhan5goodteam.omok.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.shinhan5goodteam.omok.model.User;

public class UserDAO {

    //아이디 중복 검사
    public boolean isUserIdExist(String userid) {
        String sql = "select * from USER_table where user_id = ?";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return true;
            }

        } catch ( Exception e) {
             e.printStackTrace(); // 최소한 콘솔에 오류 로그 출력

        } 

        return false;
    }

    // 로그인용 메서드
    public User login(String userid, String userpw) {
        String sql = "SELECT * FROM USER_TABLE WHERE user_id = ? AND user_pw = ?";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid);
            pstmt.setString(2, userpw);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) { //로그인 성공 시 
                User user = new User();
                user.setUserid(rs.getString("user_id"));
                user.setUserpw(rs.getString("user_pw"));
                user.setNickname(rs.getString("nickname"));
                user.setProfileimage(rs.getString("profile_image"));
                user.setProfilecolor(rs.getString("profile_color"));
                user.setPoints(rs.getInt("points"));
                user.setProfileimage(rs.getString("profile_image"));
                user.setProfilecolor(rs.getString("profile_color"));

                return user; //user 객체 반환
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; //로그인 실패 시 null 반환 
    }

    // userId로 User 객체를 반환
    public static User findById(String userId) {
        User user = null;
        String sql = "SELECT USER_ID, NICKNAME, POINTS, PROFILE_IMAGE, PROFILE_COLOR FROM USER_TABLE WHERE USER_ID = ?";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) { // 결과가 있으면 user 객체 생성성
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
        return user; // 결과가 없으면 null
    }

    //닉네임 중복 검사
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

    //계정 생성
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


    public boolean updateProfile(String userid, String profileImage, String profileColor) {
    String sql = "UPDATE user_table SET profile_image = ?, profile_color = ? WHERE user_id = ?";
    try (Connection conn = DButil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {

        pstmt.setString(1, profileImage);
        pstmt.setString(2, profileColor);
        pstmt.setString(3, userid);
        return pstmt.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}


    
=======
    //findById 로 대체 가능. 
    public static User versusUser(String userid){
        String sql = "SELECT * FROM USER_TABLE WHERE user_id = ?";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserid(rs.getString("user_id"));
                user.setNickname(rs.getString("nickname"));
                user.setProfileimage(rs.getString("profile_image")); 
                user.setProfilecolor(rs.getString("profile_color"));
                user.setPoints(rs.getInt("points"));

                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    //랭킹 데이터
    public List<User> getRanking() {
        List<User> rankingList = new ArrayList<>();
        String sql = "SELECT USER_ID, NICKNAME, POINTS, PROFILE_IMAGE, PROFILE_COLOR FROM USER_TABLE ORDER BY POINTS DESC";
        try (Connection conn = DButil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserid(rs.getString("user_id"));
                user.setNickname(rs.getString("nickname"));
                user.setPoints(rs.getInt("points"));
                user.setProfileimage(rs.getString("profile_image"));
                user.setProfilecolor(rs.getString("profile_color"));
                rankingList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rankingList;
}

}
