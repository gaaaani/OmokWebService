<!-- myprofil.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shinhan5goodteam.omok.model.User" %>
<%@ page import="com.shinhan5goodteam.omok.dao.UserDAO" %>
<%
    if (session.getAttribute("user") == null) {
      response.sendRedirect("login.jsp");
      return;
    }

    User user = UserDAO.findById(((User) session.getAttribute("user")).getUserid());

    String userid = user.getUserid();
    String nickname=user.getNickname();
    if(nickname==null|| nickname.isBlank()) nickname = "사용자";

    String profileImage = user.getProfileimage();
    if (profileImage == null || profileImage.isBlank()) profileImage = "moli";

    String profileColor = user.getProfilecolor();
    if (profileColor == null || profileColor.isBlank()) profileColor = "#F3B671";

    String profileName = "캐릭터";
    switch (profileImage) {
        case "moli": profileName = "모리"; break;
        case "rino": profileName = "리노"; break;
        case "sol": profileName = "솔"; break;
        case "lay": profileName = "레이"; break;
    }

%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>내 프로필</title>
  <link rel="stylesheet" href="css/reset.css">
  <link rel="stylesheet" href="css/layout.css">
  <link rel="stylesheet" href="css/myprofil.css">
  <style>
    .profile_circle {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto;
    }
    #selected_character_img {
      width: 100px;
      height: 100px;
    }
    #selected_character_name {
      margin-top: 10px;
      text-align: center;
      font-weight: bold;
      color: white;
      padding: 5px 0;
      border-radius: 10px;
      width: 150px;
      margin-left: auto;
      margin-right: auto;
    }
    #save_button_container {
      width: 100%;
      padding: 20px 0;
      display: flex;
      justify-content: center;
    }
    #save_button {
      width: 90%;
      padding: 12px 0;
      background-color: #BBD7F0;
      border: none;
      border-radius: 15px;
      font-size: 16px;
    }
  </style>
</head>
<body>
  <div id="wrapper">
    <header>
      <a href="<%= request.getContextPath() %>/roomList" id=home>
         <div class="title">5조은목</div>
      </a>
      
    </header>

    <main>
      <div id="user_section_title">
        <img src="img/arrow.png" alt="arrow" style="width:14px; height:14px; margin-right:8px;">
        회원 정보 
      </div>

      <div id="user_info_form">
        <input type="text" id="user_id_input" value="<%= userid %>" disabled />
        <input type="text" id="user_nickname_input" value="<%= nickname %>" disabled />
      </div>

      <div id="profile_section_title">
        <span class="section_icon_text">
          <img src="img/arrow.png" alt="arrow" class="arrow_icon" />
          프로필 변경
        </span>
      </div>

      <div id="profile_box_wrapper">
        <div id="profile_preview">
          <div class="profile_circle" style="background-color:<%= user.getProfilecolor() %>">
            <img src="img/<%= profileImage %>.png" alt="선택된 캐릭터" id="selected_character_img" />
          </div>
          <div id="selected_character_name" style="background-color:<%= user.getProfilecolor() %>"><%= nickname %></div>
        </div>

        <div id="character_selection_box">
          <div id="character_selection_group" class="character_selection_group">
            <img src="img/moli.png" id="moli" alt="모리" class="character_option" data-name="모리" />
            <img src="img/rino.png" id="rino" alt="리노" class="character_option" data-name="리노" />
            <img src="img/sol.png" id="sol" alt="솔" class="character_option" data-name="솔" />
            <img src="img/lay.png" id="lay" alt="레이" class="character_option" data-name="레이" />
          </div>
        </div>

        <div id="background_color_box">
          <div id="background_color_group" class="background_color_selection_container">
            <div id="orange" class="color_option" style="background-color: #F3B671;" data-color="#F3B671"></div>
            <div id="pink" class="color_option" style="background-color: #F2BFCB;" data-color="#F2BFCB"></div>
            <div id="gray" class="color_option" style="background-color: #A4B2C0;" data-color="#A4B2C0"></div>
            <div id="light-purple" class="color_option" style="background-color: #D8CFE2;" data-color="#D8CFE2"></div>
            <div id="navy" class="color_option" style="background-color: #5874A0;" data-color="#5874A0"></div>
          </div>
        </div>
      </div>

      <div id="save_button_container" class="save_button_container">
        <button id="save_button">저장</button>
      </div>
    </main>



  </div>
  <script>
    const userNickname = "<%= nickname %>";
  </script>
  <script src="myprofilscript.js"></script>
</body>
</html>
