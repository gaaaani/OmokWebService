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

    public List<Room> getAllRooms() { // 방 리스트 출력
        List<Room> list = new ArrayList<>();
        try {
            conn = DButil.getConnection();
            String sql = "SELECT * FROM Room WHERE status = 'ready'";
            pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setUserId(rs.getString("user_id"));
                room.setRoomName(rs.getString("room_name"));
                room.setRoomExplain(rs.getString("room_explain"));
                room.setStatus(rs.getString("status"));
                list.add(room);
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

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

        String sql = "INSERT INTO Room (room_id, user_id, room_name, room_explain, status, black_id, white_id) " +
                "VALUES (ROOM_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?)";

        String sqlGetId = "SELECT ROOM_SEQ.CURRVAL FROM dual";

        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                PreparedStatement pstmtGetId = conn.prepareStatement(sqlGetId)) {

            conn.setAutoCommit(false);

            pstmt.setString(1, room.getUserId());
            pstmt.setString(2, room.getRoomName());
            pstmt.setString(3, room.getRoomExplain());
            pstmt.setString(4, room.getStatus());
            pstmt.setString(5, blackId);
            pstmt.setString(6, whiteId);

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

    public static Room getRoomById(int roomId) { // room_id로 방 정보 가져오기
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

    // 방 상태 가져오기
    public static boolean checkRoomStatus(int roomId){
        Room room = null;
        String sql = "SELECT status FROM Room WHERE room_id = ?";

        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                room = new Room();
                room.setStatus(rs.getString("status"));
            }
            
            if(room.getStatus().equals("start")){
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
