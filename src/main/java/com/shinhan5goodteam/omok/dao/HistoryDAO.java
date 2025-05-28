package com.shinhan5goodteam.omok.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shinhan5goodteam.omok.model.History;
import com.shinhan5goodteam.omok.model.Room;

public class HistoryDAO {

    //전적 가져오기
    public List<History> getUserHistories(String userId) {
        List<History> list = new ArrayList<>();
        String sql = "SELECT HISTORY_ID, END_TIME, BLACK_ID, WHITE_ID, WINNER_ID FROM HISTORY WHERE BLACK_ID = ? OR WHITE_ID = ?";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setString(2, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                try {
                    History history = new History();
                    history.setHistoryId(rs.getInt("HISTORY_ID"));
                    history.setEndTime(rs.getDate("END_TIME"));
                    history.setBlackId(rs.getString("BLACK_ID"));
                    history.setWhiteId(rs.getString("WHITE_ID"));
                    history.setWinnerId(rs.getString("WINNER_ID"));
                    list.add(history);
                } catch (Exception e) {
                    // System.out.println("Error at HISTORY_ID: " + rs.getInt("HISTORY_ID"));
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //게임 종료 시 전적 추가
    public static boolean addHistory(Room room, String winnerId){
        String sql = "insert into history (start_time,end_time,black_id,white_id,winner_id,room_id) values(?,?,?,?,?,?)";
        try (Connection conn = DButil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setDate(1, room.getCreatedAt());
            pstmt.setDate(2, room.getClosedAt());
            pstmt.setString(3, room.getBlackId());
            pstmt.setString(4, room.getWhiteId());
            pstmt.setString(5, winnerId);
            pstmt.setInt(6,room.getRoomId());

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                return true;
            }
        } catch (Exception e) {

        }
        return false;
    }
}
