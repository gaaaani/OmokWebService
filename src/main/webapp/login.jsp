<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="css/login.css" />
  </head>

  <body>
    <div id="wrapper">
      <div class="login-container">
        <form class="login-form" method="post" action="login">
          <input type="text" name="user_id" placeholder="아이디를 입력하세요" required />
          <input type="password" name="user_pw" placeholder="비밀번호를 입력하세요" required />
          <div class="button-container">
            <input type="submit" value="로그인" id="loginBtn" class="btn-common">
            <input type="button" value="회원가입" id="registerBtn" class="btn-common"
              onclick="window.location.href='register.html'">
          </div>
        </form>
        <% String error=(String) session.getAttribute("error"); if (error !=null) { %>
          <div style="color:red; margin-bottom:-18px; text-align:center;">
            <%= error %>
          </div>
          <% session.removeAttribute("error"); } %>
      </div>

    </div>
  </body>

  </html>