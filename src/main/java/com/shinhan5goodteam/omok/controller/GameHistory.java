package com.shinhan5goodteam.omok.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shinhan5goodteam.omok.dao.HistoryDAO;
import com.shinhan5goodteam.omok.dao.UserDAO;
import com.shinhan5goodteam.omok.model.History;
import com.shinhan5goodteam.omok.model.User;

@WebServlet("/gameHistory")
public class GameHistory extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GameHistory() {
        super();
    }

    @Override
    public void init(ServletConfig config) throws ServletException {}

    @Override
    public void destroy() {}

    // HEX 매핑 함수 (컨트롤러에서 사용)
    private String getProfileColorHex(String color) {
        if ("orange".equals(color)) return "#F3B671";
        if ("pink".equals(color)) return "#F2BFCB";
        if ("gray".equals(color)) return "#A4B2C0";
        if ("navy".equals(color)) return "#5874A0";
        return "#D8CFE2";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String userId = user.getUserid();
        String nickname = user.getNickname();
        int points = user.getPoints();

        // 전적 리스트 및 정렬
        HistoryDAO dao = new HistoryDAO();
        List<History> historyList = dao.getUserHistories(userId);
        historyList.sort((h1, h2) -> {
            if (h1.getEndTime() == null && h2.getEndTime() == null) return 0;
            if (h1.getEndTime() == null) return 1;
            if (h2.getEndTime() == null) return -1;
            return h2.getEndTime().compareTo(h1.getEndTime());
        });

        // 승/패/총전적 계산
        int total = historyList.size();
        int win = 0;
        for (History h : historyList) {
            if (userId.equals(h.getWinnerId())) win++;
        }
        int lose = total - win;

        // 프로필 이미지 경로
        String profileImage = user.getProfileimage();
        String profileImagePath = "img/" + profileImage + ".png";

        // 랭킹 데이터 및 내 랭킹 계산
        UserDAO userDao = new UserDAO();
        List<User> rankingList = userDao.getRanking();
        int userRank = -1;
        int rank = 1;
        for (User rankedUser : rankingList) {
            if (rankedUser.getUserid().equals(userId)) {
                userRank = rank;
                break;
            }
            rank++;
        }

        // 전적 상세 정보 가공
        List<Map<String, Object>> historyViewList = new ArrayList<>();
        for (History h : historyList) {
            Map<String, Object> map = new HashMap<>();
            boolean isBlack = userId.equals(h.getBlackId());
            map.put("isBlack", isBlack);
            map.put("myStone", isBlack ? "⚫" : "⚪");
            map.put("opponentStone", isBlack ? "⚪" : "⚫");
            String opponentId = isBlack ? h.getWhiteId() : h.getBlackId();
            map.put("opponentId", opponentId);
            map.put("winner", h.getWinnerId());

            // 상대방 정보 조회
            User opponentUser = userDao.findById(opponentId);
            map.put("opponentNickname", opponentUser.getNickname());
            map.put("opponentPoints", opponentUser.getPoints());
            map.put("opponentProfileImagePath", "img/" + opponentUser.getProfileimage() + ".png");
            map.put("opponentProfileColorHex", getProfileColorHex(opponentUser.getProfilecolor()));

            // 날짜 포맷
            String endDate = "";
            if (h.getEndTime() != null) {
                String[] parts = h.getEndTime().toString().split(" ");
                endDate = parts[0];
            }
            map.put("endDate", endDate);

            historyViewList.add(map);
        }

        // JSP에서 쓸 데이터 전달
        request.setAttribute("user", user);
        request.setAttribute("historyList", historyList);
        request.setAttribute("total", total);
        request.setAttribute("win", win);
        request.setAttribute("lose", lose);
        request.setAttribute("profileImagePath", profileImagePath);
        request.setAttribute("rankingList", rankingList);
        request.setAttribute("userRank", userRank);
        request.setAttribute("historyViewList", historyViewList);

        request.getRequestDispatcher("myhistory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}