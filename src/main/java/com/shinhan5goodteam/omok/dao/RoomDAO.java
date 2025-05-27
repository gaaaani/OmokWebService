package com.shinhan5goodteam.omok.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.shinhan5goodteam.omok.model.Room;

public class RoomDAO {
    private Connection conn;
    private PreparedStatement pstmt;

        //방리스트 가져오기
        public List<Room> getAllRooms() {
        List<Room> roomlist = new ArrayList<>();
        try {
            conn = DButil.getConnection();
            String sql = "SELECT r.room_id, room_name, r.room_explain, r.user_id, u.nickname, u.points, u.profile_color, u.profile_image, r.status " +
                    "FROM ROOM r JOIN USER_TABLE u ON r.user_id = u.user_id WHERE r.status = 'ready'" + "ORDER BY r.room_id DESC";
            pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomName(rs.getString("room_name"));
                room.setRoomExplain(rs.getString("room_explain"));
                room.setUserId(rs.getString("user_id"));
                room.setNickName(rs.getString("nickname"));
                room.setPoints(rs.getInt("points"));
                room.setProfileColor(rs.getString("profile_color"));
                room.setProfileImage(rs.getString("profile_image"));
                room.setStatus(rs.getString("status"));
                roomlist.add(room);
            }
            
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roomlist;
    }

    // 방 생성하기
    public static int insertRoom(Room room) {
        int roomId = -1;

        // 랜덤으로 black_id 또는 white_id 에 user_id 저장
        String blackId = null;
        String whiteId = null;
        if (Math.random() < 0.5) {
            blackId = room.getUserId();
        } else {
            whiteId = room.getUserId();
        }

        String sql = "INSERT INTO Room (room_id, user_id, room_name, room_explain, status) " +
                "VALUES (ROOM_SEQ.NEXTVAL, ?, ?, ?, ?)";

        String sqlGetId = "SELECT ROOM_SEQ.CURRVAL FROM dual";

        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                PreparedStatement pstmtGetId = conn.prepareStatement(sqlGetId)) {

            conn.setAutoCommit(false);

            pstmt.setString(1, room.getUserId());
            pstmt.setString(2, room.getRoomName());
            pstmt.setString(3, room.getRoomExplain());
            pstmt.setString(4, room.getStatus());

            int result = pstmt.executeUpdate();

            if (result > 0) {
                ResultSet rs = pstmtGetId.executeQuery();
                if (rs.next()) {
                    roomId = rs.getInt(1);
                }
                rs.close();
            }

            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return roomId;
    }
    // room_id로 방 정보 가져오기
    public static Room getRoomById(int roomId) { 
        Room room = null;
        String sql = "SELECT * FROM Room WHERE room_id = ?";

        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setUserId(rs.getString("user_id"));
                room.setRoomName(rs.getString("room_name"));
                room.setRoomExplain(rs.getString("room_explain"));
                room.setStatus(rs.getString("status"));
            }

            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return room;
    }

    // db 에 흑백 유정 지정 + 게임방 상태 업데이트
    public static boolean setBlackWhiteUsers(String user1Id, String user2Id, int roomId){
        String sql = "update room set black_id = ? , white_id = ?, status = ? where room_id = ?";

        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            ResultSet rs = pstmt.executeQuery();
            
            pstmt.setString(1, user1Id);
            pstmt.setString(2, user2Id);
            pstmt.setString(3, "start");
            pstmt.setInt(4, roomId);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                rs.close();
                return true;
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // 게임 종료 시 게임방 상태 종료
    public static boolean setGameOver(int roomId){
        String sql = "update room set closed_at = ?, status = ? where room_id = ?";

        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            ResultSet rs = pstmt.executeQuery();
            
            pstmt.setString(1, "sysdate");
            pstmt.setString(2, "end");
            pstmt.setInt(3, roomId);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                rs.close();
                return true;
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
