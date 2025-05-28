
<%@page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shinhan5goodteam.omok.model.User" %>
<%@ page import="com.shinhan5goodteam.omok.model.History" %>
<%@ page import="com.shinhan5goodteam.omok.dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%
    User user = UserDAO.findById(((User) session.getAttribute("user")).getUserid());
    List<History> historyList = (List<History>) request.getAttribute("historyList");
    int total = (Integer) request.getAttribute("total");
    int win = (Integer) request.getAttribute("win");
    int lose = (Integer) request.getAttribute("lose");
    String profileImagePath = (String) request.getAttribute("profileImagePath");
    List<User> rankingList = (List<User>) request.getAttribute("rankingList");
    int userRank = (Integer) request.getAttribute("userRank");
    String nickname = user.getNickname();
    int points = user.getPoints();
    String profileColor = user.getProfilecolor();
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/myhistory.css" />
</head>
<script>
    //랭킹 모달 열기/닫기
    window.onload = function() {
        const rankingBtn = document.getElementById("ranking");
        const overlay = document.getElementById("overlay");
        const ranking = document.getElementById("ranking-container");
        let showingRanking = false;

        rankingBtn.addEventListener("click", function() {
            showingRanking = !showingRanking;
            if (showingRanking) {
                overlay.style.display = "block";
                ranking.style.display = "flex";
            } else {
                overlay.style.display = "none";
                ranking.style.display = "none";
            }
        });

        overlay.addEventListener("click", function() {
            overlay.style.display = "none";
            ranking.style.display = "none";
            showingRanking = false;
        });
    };
</script>

<body>
    <div id="wrapper">
        <header>
        <a href="<%= request.getContextPath() %>/roomList" id=home>
            <div class="title">5조은목</div>
        </a>
        </header>
        <main>
            <!-- 메인 타이틀, 랭킹 버튼튼-->
            <div class="main-title">
                <div class="arrow-icon">
                    <img src="img/arrow.png" alt="화살표">
                </div>
                <h3>내 전적</h3>
                <button id="ranking">🏆</button>
            </div>
            <!-- 프로필 및 점수 -->
            <div class="container">
                <div class="profile-container">

                    <div class="profile" style="background-color: <%= user.getProfilecolor() %>;" >
                        <img src="<%= profileImagePath %>" alt="프로필 이미지" />

                    </div>
                    <div class="name-box" style="background-color: <%= user.getProfilecolor() %>;"><%= nickname %></div>
                </div>
                <div class="score-container">
                    <div class="score-box1">
                        <div class="score-title">👑 SCORE</div>
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
            <!-- 내 전적 리스트 -->
            <div class="myhistory-container">
                <% 
                List<Map<String, Object>> historyViewList = (List<Map<String, Object>>) request.getAttribute("historyViewList");
                if (historyViewList != null && !historyViewList.isEmpty()) {
                    for (Map<String, Object> hv : historyViewList) {
                        String myStone = (String) hv.get("myStone");
                        String opponentStone = (String) hv.get("opponentStone");
                        String opponentNickname = (String) hv.get("opponentNickname");
                        int opponentPoints = (Integer) hv.get("opponentPoints");
                        String opponentProfileImagePath = (String) hv.get("opponentProfileImagePath");
                        String opponentProfileColor = (String) hv.get("opponentProfileColor");
                        String winner = (String) hv.get("winner");
                        String endDate = (String) hv.get("endDate");
                %>
                <!-- 전적 상세 정보 -->
                <div class="result-box">
                    <div class="winlose-label" style="color:<%= winner.equals(user.getUserid()) ? "#475569" : "#E85B56" %>;">
                        <%= winner.equals(user.getUserid()) ? "WIN" : "LOSE" %>
                        <span style="font-size:10px; margin-left:5px; color: #494949;"><%= endDate %></span>
                    </div>
                    <div class="result">
                        <!-- 내 정보 -->
                        <div class="user-profile profile" style="background-color: <%= user.getProfilecolor() %>;">
                            <img src="<%= profileImagePath %>" alt="프로필 이미지" />
                            <div class="name-box" style="background-color: <%= user.getProfilecolor() %>;" ><%= nickname %></div>
                        </div>
                        <div class="rank-box">
                            <div class="rank">오목조목킹 : <%= points %> 점</div>
                            <div><%= myStone %></div>
                        </div>
                    </div>
                    <h3>VS</h3>
                    <div class="result">
                        <!-- 상대방 정보 -->
                        <div class="opponent-profile profile" style="background-color: <%= opponentProfileColor %>;">
                            <img src="<%= opponentProfileImagePath %>" alt="프로필 이미지" />
                            <div class="name-box" style="background-color: <%= opponentProfileColor %>;"><%= opponentNickname %></div>
                        </div>
                        <div class="rank-box">
                            <div class="rank">오목조목킹 : <%= opponentPoints %> 점</div>
                            <div><%= opponentStone %></div>
                        </div>
                    </div>
                </div>
                <!-- 전적이 없을 때 -->
                <% } 
                } else { %>
                <div style="text-align:center; color:#888;">전적이 없습니다.</div>
                <% } %>
            </div>
            <!-- 랭킹 컨테이너 (처음엔 숨김) -->
            <div class="overlay" id="overlay" style="display:none;"></div>
            <div class="ranking-modal" id="ranking-container" style="display:none;">
                <div style="text-align:center; color:#888; margin-top: 30px;">
                    <h3>🏆 오목조목킹</h3>
                    <ul class="ranking-list">
                        <% 
                            int rankNum = 1;
                            for (User rankedUser : rankingList) {
                        %>
                        <li>
                            <!-- 순위 -->
                            <div class="rank-number"><%= rankNum %>위</div>
                            <!-- 프로필, 닉네임 -->
                            <div class="rank-info">
                                <div class="profile" style="background-color: <%= rankedUser.getProfilecolor() %>;">
                                    <img src="img/<%= rankedUser.getProfileimage() %>.png" alt="프로필 이미지">
                                </div>
                                <span class="nickname" style="background-color: <%= rankedUser.getProfilecolor() %>;">
                                    <%= rankedUser.getNickname() %>
                                </span>
                            </div>
                            <!-- 점수 -->
                            <div class="rank-points"><%= rankedUser.getPoints() %>점</div>
                        </li>
                        <% 
                                rankNum++;
                            } 
                        %>
                    </ul>
                    <hr style="margin: 20px 0;">
                    <!-- 내 랭킹 표시 -->
                    <h3>👤 MY 오목조목킹</h3>
                    <% if (userRank > 0) { %>
                        <div class="current-user-ranking">
                            <div class="rank-number"><%= userRank %>위</div>
                            <div class="profile" style="background-color: <%= profileColor %>;">
                                <img src="<%= profileImagePath %>" alt="프로필 이미지">
                            </div>
                            <span class="nickname" style="background-color: <%= profileColor %>;">
                                <%= nickname %>
                            </span>
                            <div class="rank-points"><%= points %>점</div>
                        </div>
                    <% } else { %>
                        <div style="text-align: center; color: #888;">랭킹 정보가 없습니다.</div>
                    <% } %>
                </div>
            </div>
        </main>
    </div>
</body>
</html>