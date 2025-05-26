
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shinhan5goodteam.omok.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String nickname = user.getNickname();
    int points = user.getPoints();

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
                        <img src="img/<%= user.getProfileimage() %>.png" alt="프로필 이미지" />
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
                            <div class="total">364전</div>
                             <div class="win">264승</div>
                             <div class="lose">100패</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="myhistory-container">
                <div class="result-box">
                    <div class="result">
                        <div class="profile">
                            <img src="img/lay.png" alt="프로필 이미지" />
                            <div class="name-box"><%= nickname %></div>
                        </div>
                        <div class="rank-box">
                            <div class="rank">오목조목킹 : <%= points %> 점</div>
                            <div>⚫</div>
                        </div>
                    </div>
                    <h3>VS</h3>
                    <div class="result">
                        <div class="profile">
                            <img src="img/lay.png" alt="프로필 이미지" />
                            <div class="name-box">곰돌이</div>
                        </div>
                        <div class="rank-box">
                            <div>⚪</div>
                            <div class="rank">오목조목킹 : 95614점</div>

                        </div>
                    </div>
                </div>
                <div class="result-box">
                    <div class="result">
                        <div class="profile">
                            <img src="img/lay.png" alt="프로필 이미지" />
                            <div class="name-box">곰돌이</div>
                        </div>
                        <div class="rank-box">
                            <div class="rank">오목조목킹 : 95614점</div>
                            <div>⚫</div>
                        </div>
                    </div>
                    <h3>VS</h3>
                    <div class="result">
                        <div class="profile">
                            <img src="img/lay.png" alt="프로필 이미지" />
                            <div class="name-box">곰돌이</div>
                        </div>
                        <div class="rank-box">
                            <div>⚪</div>
                            <div class="rank">오목조목킹 : 95614점</div>

                        </div>
                    </div>
                </div>
                <div class="result-box">
                    <div class="result">
                        <div class="profile">
                            <img src="img/lay.png" alt="프로필 이미지" />
                            <div class="name-box">곰돌이</div>
                        </div>
                        <div class="rank-box">
                            <div class="rank">오목조목킹 : 95614점</div>
                            <div>⚫</div>
                        </div>
                    </div>
                    <h3>VS</h3>
                    <div class="result">
                        <div class="profile">
                            <img src="img/lay.png" alt="프로필 이미지" />
                            <div class="name-box">곰돌이</div>
                        </div>
                        <div class="rank-box">
                            <div>⚪</div>
                            <div class="rank">오목조목킹 : 95614점</div>

                        </div>
                    </div>
                </div>
                <div class="result-box">
                    <div class="result">
                        <div class="profile">
                            <img src="img/lay.png" alt="프로필 이미지" />
                            <div class="name-box">곰돌이</div>
                        </div>
                        <div class="rank-box">
                            <div class="rank">오목조목킹 : 95614점</div>
                            <div>⚫</div>
                        </div>
                    </div>
                    <h3>VS</h3>
                    <div class="result">
                        <div class="profile">
                            <img src="img/lay.png" alt="프로필 이미지" />
                            <div class="name-box">곰돌이</div>
                        </div>
                        <div class="rank-box">
                            <div>⚪</div>
                            <div class="rank">오목조목킹 : 95614점</div>

                        </div>
                    </div>
                </div>




            </div>
    </div>


    </main>
    </div>
</body>

</html>