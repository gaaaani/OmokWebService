package com.shinhan5goodteam.omok.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shinhan5goodteam.omok.model.History;

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
                    System.out.println("Error at HISTORY_ID: " + rs.getInt("HISTORY_ID"));
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
