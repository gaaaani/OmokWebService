<%@page import="com.shinhan5goodteam.omok.dao.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shinhan5goodteam.omok.model.User" %>
<%@ page import="com.shinhan5goodteam.omok.model.History" %>
<%@ page import="com.shinhan5goodteam.omok.dao.HistoryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Comparator" %>
<%
    //세션에서 로그인 유저 정보 가져오기
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp"); //로그인 안 되어 있으면 로그인 페이지로로
        return;
    }
    String userId = user.getUserid();
    String nickname = user.getNickname();
    int points = user.getPoints();

    UserDAO userDao = new UserDAO(); //UserDAO 객체 생성
    HistoryDAO dao = new HistoryDAO(); //HistoryDAO 객체 생성
    List<History> historyList = dao.getUserHistories(userId); //내 전적 리스트 조회
%>
<%
    // 전적, 승, 패 계산
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
    // 프로필 이미지 경로
    String profileImage = user.getProfileimage(); // ("rino", "moli", "sol", "lay")
    String profileImagePath = "img/" + profileImage + ".png";
%>
<%! // 컬러 HEX 매핑 함수(프로필 배경색)
    public String getProfileColorHex(String color) {
        if ("orange".equals(color)) return "#F3B671";
        if ("pink".equals(color)) return "#F2BFCB";
        if ("gray".equals(color)) return "#A4B2C0";
        if ("navy".equals(color)) return "#5874A0";
        return "#D8CFE2"; // light purple
    }
%>
<%  //프로필 배경색 HEX 값값
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
<script>
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

    // 오버레이 클릭 시 닫기
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
                    <button id="ranking">🏆</h3>   
            </div>
            <div class="container">
                <div class="profile-container">
                    <div class="profile" style="background-color: <%= profileColorHex %>;" >
                        <img src="<%= profileImagePath %>" alt="프로필 이미지" />
                    </div>
                    <div class="name-box" style="background-color: <%= profileColorHex %>;"><%= nickname %></div>
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
                    <%
                    
                    if (historyList != null) {
                        historyList.sort(new Comparator<History>() {
                            @Override
                            public int compare(History h1, History h2) {
                                // 최신 날짜가 먼저 오도록 내림차순 정렬
                                if (h1.getEndTime() == null && h2.getEndTime() == null) return 0;
                                if (h1.getEndTime() == null) return 1;
                                if (h2.getEndTime() == null) return -1;
                                return h2.getEndTime().compareTo(h1.getEndTime());
                            }
                        });
                    }
                    %>
                    <% for (History h : historyList) {
                        // 내 돌 색, 상대 돌 색, 상대 ID, 승자 ID 구하기기
                        boolean isBlack = userId.equals(h.getBlackId());
                        String myStone = isBlack ? "⚫" : "⚪";
                        String opponentStone = isBlack ? "⚪" : "⚫";
                        String opponentId = isBlack ? h.getWhiteId() : h.getBlackId();
                        String winner = h.getWinnerId();

                        // 상대방 정보 조회
                        User opponentUser = userDao.findById(opponentId);
                        String opponentNickname = opponentUser.getNickname();
                        int opponentpoints = opponentUser.getPoints();
                        String opponentProfileImagePath = "img/" + opponentUser.getProfileimage() + ".png";
                        String opponentProfileColorHex = getProfileColorHex(opponentUser.getProfilecolor());
                    
                        String endDate = "";
                        if (h.getEndTime() != null) {
                            String[] parts = h.getEndTime().toString().split(" ");
                            endDate = parts[0];
                        }
                    %>
                <div class="result-box">
                        <div class="winlose-label" style="color:<%= winner.equals(userId) ? "#475569" : "#E85B56" %>;">
                            <%= winner.equals(userId) ? "WIN" : "LOSE" %>
                            <span style="font-size:10px; margin-left:5px; color: #494949;"><%= endDate %></span>
                        </div>
                    <div class="result">
                        <div class="user-profile profile" style="background-color: <%= profileColorHex %>;">
                            <img src="<%= profileImagePath %>" alt="프로필 이미지" />
                            <div class="name-box" style="background-color: <%= profileColorHex %>;" ><%= nickname %></div>
                        </div>
                        <div class="rank-box">
                            <div class="rank";">오목조목킹 : <%= points %> 점</div>
                            <div><%= myStone %></div>
                        </div>
                    </div>
                    <h3>VS</h3>
                    <div class="result">
                        <div class="opponent-profile profile" style="background-color: <%= opponentProfileColorHex %>;">
                            <img src="<%= opponentProfileImagePath %>" alt="프로필 이미지" />
                            <div class="name-box" style="background-color: <%= opponentProfileColorHex %>;"><%= opponentNickname %></div>
                        </div>
                        <div class="rank-box">
                            <div class="rank">오목조목킹 : <%= opponentpoints %> 점</div>
                            <div><%= opponentStone %></div>
                        </div>
                    </div>
                </div>
                <% } 
            	 } else { %>
                    <!-- 전적이 없을 때 -->
                <div style="text-align:center; color:#888;">전적이 없습니다.</div>
            <% } %>
            </div>
            <!-- 랭킹 컨테이너 (처음엔 숨김) -->
            <div class="overlay" id="overlay" style="display:none;"></div>
            <div class="ranking-modal" id="ranking-container" style="display:none;">
                <div style="text-align:center; color:#888; margin-top: 30px;">
                    <!-- 여기에 랭킹 리스트를 넣으세요 -->
                    랭킹 기능은 준비중입니다.
                </div>
            </div>


    </main>
    </div>
</body>

</html>