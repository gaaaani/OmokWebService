<%@page import="com.shinhan5goodteam.omok.dao.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shinhan5goodteam.omok.model.User" %>
<%@ page import="com.shinhan5goodteam.omok.model.History" %>
<%@ page import="com.shinhan5goodteam.omok.dao.HistoryDAO" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userId = user.getUserid();
    String nickname = user.getNickname();
    int points = user.getPoints();

    UserDAO userDao = new UserDAO();
    HistoryDAO dao = new HistoryDAO();
    List<History> historyList = dao.getUserHistories(userId);
%>
<%
    int total = historyList != null ? historyList.size() : 0;
    int win = 0;
    int lose = 0;
    if (historyList != null) {
        for (History h : historyList) {
            if (userId.equals(h.getWinnerId())) {
                win++;
            }
        }
        lose = total - win;
    }
%>
<%
    String profileImage = user.getProfileimage(); // ("rino", "moli", "sol", "lay")
    String profileImagePath = "img/" + profileImage + ".png";
%>
<%! // JSP 선언부: 컬러 HEX 매핑 함수
    public String getProfileColorHex(String color) {
        if ("orange".equals(color)) return "#F3B671";
        if ("pink".equals(color)) return "#F6C8E8";
        if ("gray".equals(color)) return "#A4B2C0";
        if ("navy".equals(color)) return "#5874A0";
        return "#DADADA"; // light gray or default
    }
%>
<%
    String profileColorHex = getProfileColorHex(user.getProfilecolor());
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/myhistory.css" />
</head>

<body>
    <div id="wrapper">
        <header>
            <div class="title">5조은목</div>
            <div class="home-icon">
                <img src="img/tomainicon.png" alt="홈" />
            </div>
        </header>
        <main>
            <div class="main-title">
                <div class="arrow-icon">
                    <img src="img/arrow.png" alt="화살표">
                </div>
                <h3>내 전적</h3>
            </div>
            <div class="container">
                <div class="profile-container">
                    <div class="profile">
                        <img src="<%= profileImagePath %>" alt="프로필 이미지" />
                    </div>
                    <div class="name-box"><%= nickname %></div>
                </div>
                <div class="score-container">
                    <div class="score-box1">
                        <div class="score-title">👑SCORE</div>
                        <div id="score"><%= points %></div>
                    </div>
                    <div class="score-box2">
                        <div class="score-title2">오목조목킹</div>
                        <div id="score2">
                            <div class="total"><%= total %>전</div>
                            <div class="win"><%= win %>승</div>
                            <div class="lose"><%= lose %>패</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="myhistory-container">
                <% if (historyList != null && !historyList.isEmpty()) { %>
                    <% for (History h : historyList) {
                        boolean isBlack = userId.equals(h.getBlackId());
                        String myStone = isBlack ? "⚫" : "⚪";
                        String opponentStone = isBlack ? "⚪" : "⚫";
                        String opponentId = isBlack ? h.getWhiteId() : h.getBlackId();
                        String winner = h.getWinnerId();

                        User opponentUser = userDao.findById(opponentId);
                        String opponentNickname = opponentUser.getNickname();
                        int opponentpoints = opponentUser.getPoints();
                        String opponentProfileImagePath = "img/" + opponentUser.getProfileimage() + ".png";
                        String opponentProfileColorHex = getProfileColorHex(opponentUser.getProfilecolor());
                    %>
                <div class="result-box">
                    <div class="result">
                        <div class="user-profile profile">
                            <img src="<%= profileImagePath %>" alt="프로필 이미지" />
                            <div class="name-box"><%= nickname %></div>
                        </div>
                        <div class="rank-box">
                            <div class="rank">오목조목킹 : <%= points %> 점</div>
                            <div><%= myStone %></div>
                        </div>
                    </div>
                    <h3>VS</h3>
                    <div class="result">
                        <div class="opponent-profile profile">
                            <img src="<%= opponentProfileImagePath %>" alt="프로필 이미지" />
                            <div class="name-box"><%= opponentNickname %></div>
                        </div>
                        <div class="rank-box">
                            <div class="rank">오목조목킹 : <%= opponentpoints %> 점</div>
                            <div><%= opponentStone %></div>
                        </div>
                    </div>
                </div>
                <% } 
            	 } else { %>
                <div style="text-align:center; color:#888;">전적이 없습니다.</div>
            <% } %>
            </div>


    </main>
    </div>
</body>

</html>