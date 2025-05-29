<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.shinhan5goodteam.omok.model.User" %>
<%@ page import="com.shinhan5goodteam.omok.model.Room" %>
<%@ page import="com.shinhan5goodteam.omok.dao.UserDAO" %>
<%@ page import="com.shinhan5goodteam.omok.dao.RoomDAO" %>
<%
  if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
  }
  //유저 객체 생성된
  //user1 본인. user2는 상대방.
  User user1 = UserDAO.findById(((User) session.getAttribute("user")).getUserid());
  User user2 = null;

  //방 객체 생성. 원래는 생성된 Room 객체를 가져옴.
  //방 만들기, 방 입장 시 Room 데이터를 어떻게 가져올지 정해야함.
  int roomId = Integer.parseInt(request.getParameter("roomId"));
  Room room = RoomDAO.getRoomById(roomId);
  
  //방에 입장한 유저의 경우 본인의 아이디와 룸생성자의 id가 다르기때문에
  //방 생성자의 객체를 가져와 본인 클라이언트에 적용하기 위함.
  if ( room.getUserId() != user1.getUserid()){
      user2 = UserDAO.findById(room.getUserId());
      System.out.println(user2.getUserid());
  }

%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>5조은목</title>
  <link rel="stylesheet" href="css/layout.css">
  <link rel="stylesheet" href="css/reset.css">
  <link rel="stylesheet" href="css/game.css">
  <audio id ="move-sound" src="./audio/sound.mp3" preload="auto"></audio>
  <audio id ="move-sound2" src = "./audio/moveSound.mp3" preload="auto"></audio>
</head>

<body>
  <div id="wrapper">
    <div id="header">
      <div id="title-bar">
        <span>5조은목</span>
        <!-- <img id="chat-icon" src="chat.png" alt="채팅"> -->
      </div>
    </div>
    <main>
    <div id="omok-board" style="position: relative;"></div>

    <div class="info-panel">
      <div class="info-container">
        <div class="info-panel-inside">
          <div id="player-info">
            <div id="left-user">
              <div id="left-avatar-bg" class="avatar-bg" style="background-color: #F8BBD0;">
                <img src="img/sol.png" id="leftUser">
              </div>
              <div class="name-stone">
                <span class="player-name"><%= user1.getNickname() %></span>
                <span class="user1stone"></span>
              </div>
              <div class="score">오목조목킹 <%= user1.getPoints() %></div>

            </div>
            <div class="move-container">
              <div id="timer">
                <span id="left-time">30</span> ⏱ <span id="right-time">30</span>
              </div>
              <button id="move-button" disabled>착수</button>
            </div>

            <div id="right-user">
              <div id="right-avatar-bg" class="avatar-bg" style="background-color: #E9E9E9;">

                <img src="img/sol.png" id="rightUser">
              </div>
              <div class="name-stone">
                <span id="user2" class="player-name"><%= user2.getNickname() %></span>
                <span class="user2stone"></span>
              </div>
              <div id="user2point" class="score">오목조목킹 <%= user2.getPoints() %></div>

            </div>
        </div>
        </div>
        <div class="surrender-conatiner">
          <button id="surrenderbutton">나가기</button>
        </div>
      </div>

    </div>
    </main>
    <div id="popup-overlay">
      <!-- 1) 나가기 확인 팝업 -->
      <div id="surrender-popup" class="popup-box">
        <p>게임 중에 퇴장시 패배처리됩니다.</p>
        <button class="cancle-button" onclick="closeAllPopups()">취소</button>
        <button class="surrender" onclick="confirmExit()">나가기</button>
      </div>

      <!-- 2) 승리 팝업 -->
      <div id="winner-popup" class="popup-box">
        <h2>WIN !!</h2>
        <div>
          <div class="avatar-bg" style="background-color: #E9E9E9;">
            <img src="" alt="win" class="popup-avatar" id="winner-img">
          </div>
          <p id="winner-text"></p>
        </div>
        <div class="divider"></div>
        <button class="popup-button">나가기</button>
      </div>

      <!-- 3) 패배 팝업 -->
      <div id="loser-popup" class="popup-box">
        <h2>LOSE !!</h2>
        <div class="avatar-bg" style="background-color: #F8BBD0;">
          <img src="" alt="lose" class="popup-avatar" id="loser-img">
        </div>
        <p id="loser-text"></p>
        <div class="divider"></div>
        <button class="popup-button">나가기</button>
      </div>

    </div>

  </div>

  <script>

  //js에서 사용하기 위해 객체 저장
  //본인정보
  let user1 = {
    type: "user",
    id : "<%= user1.getUserid() %>",
    point: "<%= user1.getPoints() %>",
    nickname: "<%= user1.getNickname() %>",
    profileimg: "<%= user1.getProfileimage() %>",
    profilecolor: "<%= user1.getProfilecolor() %>"
  }
  document.querySelector("#leftUser").src = "img/"+user1.profileimg+".png";
  document.querySelector(".popup-avatar").src = "img/"+user1.profileimg+".png";
  document.querySelector("#left-avatar-bg").style.backgroundColor = user1.profilecolor;
  //방정보
  let room = {
    roomId: "<%= room.getRoomId() %>",
    createuserId: "<%= room.getUserId() %>",
    status: "<%= room.getStatus() %>"
  }
  //상대정보
  let user2;
  //본인이 입장한 유저인 경우 상대가 정해져잇으므로 바로 적용
  if ( "<%= user2 %>" != null){
      user2 = {
          type: "user",
          id : "<%= user2.getUserid() %>",
          point: "<%= user2.getPoints() %>",
          nickname: "<%= user2.getNickname() %>",
          profileimg: "<%= user2.getProfileimage() %>",
          profilecolor: "<%= user2.getProfilecolor() %>"
      }
      document.querySelector("#user2").innerHTML = user2.nickname;
      document.querySelector("#user2point").innerHTML = "오목조목킹 "+user2.point;
      document.querySelector("#rightUser").src = "img/"+user2.profileimg+".png";
      document.querySelector("#right-avatar-bg").style.backgroundColor = user2.profilecolor;
    }

  //좌표 값
  let posx = -1;
  let posy = -1;

  //흑백 저장
  let color;

  //서버로 보낼 move 데이터 객체
  let sendData = {
        type : "move",
        roomId : room.roomId,
        userId : user1.id,
        x: posx,
        y: posy
  };

  //타이머 관련 변수
  let leftTime = 30;
  let rightTime = 30;
  let current;
  let timerId = null;
  const leftDisplay = document.getElementById('left-time');
  const rightDisplay = document.getElementById('right-time');

  //바둑알 두기 함수
  function draw() {
    console.log("function out");
    if (this.style.backgroundColor != "white" && this.style.backgroundColor != "black"){
      console.log("check");
      if ( posx >=0 && posy >= 0){
        document.getElementById(posx+"-"+posy).style.backgroundColor = "initial";
      }
      if ( color == "black" ){
        this.style.backgroundColor = "black";
      } else {
        this.style.backgroundColor = "white";
      }
      posx = this.dataset.x;
      posy = this.dataset.y;
      sendData.x = posx;
      sendData.y = posy;
      document.getElementById("move-sound2").play(); 
      console.log("(x: " + this.dataset.x + ", y: " + this.dataset.y + ")");
    }
  };  

  //바둑판 그리기 함수
  function drawOmok() {
    	  var board = document.getElementById("omok-board");
    	  var size = 15;
    	  var boardSize = 398;
    	  var offset = 16;
    	  var gap = (boardSize - 2 * offset) / (size - 1);

    	  board.innerHTML = "";

    	  // 가로줄
    	  for (var i = 0; i < size; i++) {
    	    var hLine = document.createElement("div");
    	    hLine.className = "horizon";
    	    hLine.style.position = "absolute";
    	    hLine.style.height = "1px";
    	    hLine.style.backgroundColor = "#333";
    	    hLine.style.left = offset + "px";
    	    hLine.style.top = Math.round(offset + i * gap) + "px";
    	    hLine.style.width = Math.round((size - 1) * gap) + "px";
    	    board.appendChild(hLine);
    	  }

    	  // 세로줄
    	  for (var i = 0; i < size; i++) {
    	    var vLine = document.createElement("div");
    	    vLine.className = "vertical";
    	    vLine.style.position = "absolute";
    	    vLine.style.width = "1px";
    	    vLine.style.backgroundColor = "#333";
    	    vLine.style.top = offset + "px";
    	    vLine.style.left = Math.round(offset + i * gap) + "px";
    	    vLine.style.height = Math.round((size - 1) * gap) + "px";
    	    board.appendChild(vLine);
    	  }

    	  // 가운데 별
    	  var star = document.createElement("div");
    	  star.className = "star";
    	  star.style.left = Math.round(offset + 7 * gap) + "px";
    	  star.style.top = Math.round(offset + 7 * gap) + "px";
    	  board.appendChild(star);

    	  // 클릭 가능한 cell
    	  for (var y = 0; y < size; y++) {
    	    for (var x = 0; x < size; x++) {
    	      var cell = document.createElement("div");
            cell.id =  x + "-" + y;
    	      cell.className = "cell";
    	      cell.style.left = Math.round(offset + x * gap) + "px";
    	      cell.style.top = Math.round(offset + y * gap) + "px";
    	      cell.dataset.x = x;
    	      cell.dataset.y = y;
            cell.style.borderRadius = "50%";
    	      board.appendChild(cell);
    	    }
    	  }
    	}
    //바둑판 그리기 함수 호출
    document.addEventListener("DOMContentLoaded", function () {       
    	  drawOmok();   
    });

    // 승리 팝업 열기
    function showWinnerPopup() {
      document.getElementById('popup-overlay').style.display = 'block';
      document.querySelector("#winner-img").src = "img/"+user1.profileimg+".png";
      document.getElementById('winner-text').innerHTML = user1.id+" +100점";
      document.getElementById('winner-popup').style.display = 'block';
    }

    // 패배 팝업 열기
    function showLoserPopup() {
      document.getElementById('popup-overlay').style.display = 'block';
      document.querySelector("#loser-img").src = "img/"+user1.profileimg+".png";
      document.getElementById('loser-text').innerHTML = user1.id+" -100점";
      document.getElementById('loser-popup').style.display = 'block';
    }

    //결과창 나가기 버튼. 서버에 exit 메세지 전달
    document.querySelectorAll(".popup-button").forEach(e => {
      e.addEventListener("click", function () {
      const exit_data = {
        type : "exit",
        roomId : room.roomId,
        userId : user1.id
      }
      socket.send(JSON.stringify(exit_data));
      })
    })
  
    //소켓 설정
    //socket.send() 실행 당 서버에서 한번의 Onmessage 함수 작동.
    let socket;
    function connect() {
      socket = new WebSocket("ws://192.168.0.208:8090/omok/GamePlay/"+"<%= room.getRoomId() %>" );
      socket.onopen = function() {  //소켓 입장 시 실행
        socket.send(JSON.stringify(user1));
      };

      socket.onmessage = function(e){ // 서버에서 Onmessage 함수 발동시 실행.
        console.log(e.data);
        if (e.data.startsWith("{")) { //{ 로 판단해 객체 정보가 옴을 판단
          const data1 = JSON.parse(e.data); //데이터를 json형태로 처리(기존엔 string)
          if (data1.type == "user") { // 넘어온 객체가 user인 경우. 즉 방을 만든 유저가 방에 들어온 유저의 객체를 가져오기 위함 
            console.log("get IN")
            user2 = {
              id: data1.id,
              point: data1.point,
              nickname: data1.nickname,
              profileimg: data1.profileimg,
              profilecolor: data1.profilecolor
          }
          // 가져온 정보로 본인의 클라이언트 적용
          document.querySelector("#user2").innerHTML = user2.nickname;
          document.querySelector("#user2point").innerHTML = "오목조목킹 "+ user2.point;
          document.querySelector("#rightUser").src = "img/"+user2.profileimg+".png";
          document.querySelector("#right-avatar-bg").style.backgroundColor = user2.profilecolor;
          } else if (data1.type == "move"){ //넘어온 객체가 move인 경우. 서버에서 바둑판 정보를 보낸것. 방id, 현재 차례 유저 등
            if (data1.userId == user1.id){
              document.getElementById(data1.x+"-"+data1.y).style.backgroundColor = color == "black" ? "white" : "black";
              document.querySelector("#move-button").disabled = false;
              current = "left";
              leftTime = 30;
              rightTime = 30;
              document.querySelectorAll(".cell").forEach(cell => {
                cell.addEventListener("click", draw);
              });
            } else {
              document.querySelector("#move-button").disabled = true;
              current = "right";
              leftTime = 30;
              rightTime = 30;
            }
          } else if (data1.type == "start"){ // 게임 시작 시 최초 1회 받음. 흑백 선정 데이터
            if (data1.userId == user1.id){
              document.querySelector("#move-button").disabled = false;
              current = "left";
              document.querySelectorAll(".cell").forEach(cell => {
                cell.addEventListener("click", draw);
              });
              color = "black";
              document.querySelector(".user1stone").innerHTML = "⚫";
              document.querySelector(".user2stone").innerHTML = "⚪";
            } else {
              document.querySelector(".user2stone").innerHTML = "⚫";
              document.querySelector(".user1stone").innerHTML = "⚪";
              color = "white";
              current = "right";
            }
            room.status = "start";
            startTimer();
          } else if (data1.type == "over"){ //게임 종료 데이터 받음.
            if(user1.id == data1.userId){
              showLoserPopup();
            } else {
              showWinnerPopup();
            }
          } else if (data1.type == "exit"){ // 메인으로 나가라는 데이터 받음
            if (data1.redirect == "roomList") {
              window.location.href = "roomList";
            }
          } else if (data1.type == "surrender"){
            clearInterval(timerId);
            if (data1.userId == user1.id){
              showLoserPopup();
            } else {
              showWinnerPopup();
            }
          }
        }
      };

      socket.onclose = function() { //소켓 연결 종료 시 실행
      socket.close();
      console.log('서버랑 연결이 끊어졌습니다');
      };
    };
    window.onload = connect; // 창 로드가 완료된 후 소켓연결

    //착수 버튼 이벤트
    document.querySelector("#move-button").addEventListener("click", function(){
      if (posx >= 0 && posy >= 0) {
        document.getElementById("move-sound").play();
        socket.send(JSON.stringify(sendData));
        document.querySelectorAll(".cell").forEach(cell => {
          cell.removeEventListener("click", draw);
        });
        posx = -1;
        posy = -1;
      }
    })
    
    // 화면에 시간 업데이트
    function updateDisplays() {
      leftDisplay.textContent = leftTime;
      rightDisplay.textContent = rightTime;
    }

    //타이머 시작
    //타임 오버 판단 및 시간 반영
    //시간 역시 소켓 통신을 통해 주고 받아야할듯 함. 
    function startTimer() {
      if (timerId) clearInterval(timerId);
      timerId = setInterval(() => {
        if (current == 'left') {
          leftTime--;
          if (leftTime <= 0) return onTimeout();
        } else {
          rightTime--;
        }
        updateDisplays();
      }, 1000);
      updateDisplays();
    }

    //타임 오버
    function onTimeout() {
      clearInterval(timerId);
      const surrenderMsg = {
        type:"surrender",
        roomId: room.roomId,
        userId: user1.id
      };
      socket.send(JSON.stringify(surrenderMsg));
    }

    //아직 미구현 혹은 사용하지 않는 애들

    const exitBtn = document.getElementById('surrenderbutton');
    // “나가기” 버튼에 팝업 연결
    exitBtn.addEventListener('click', showExitPopup);


    // // 나가기 확인 팝업 열기
    function showExitPopup() {
      document.getElementById('popup-overlay').style.display = 'block';
      document.getElementById('surrender-popup').style.display = 'block';
    }

    // 모든 팝업 닫기
    function closeAllPopups() {
      document.getElementById('popup-overlay').style.display = 'none';
      document.getElementById('surrender-popup').style.display = 'none';
    }

    //  나가기(항복) 처리
    function confirmExit() {
      if (room.status == "ready"){
        const exit_data = {
        type : "exit",
        roomId : room.roomId,
        userId : user1.id
        }
        socket.send(JSON.stringify(exit_data));
      } else if (room.status == "start") {
        clearInterval(timerId);
        const surrenderMsg = {
        type:"surrender",
        roomId: room.roomId,
        userId: user1.id
        };
        socket.send(JSON.stringify(surrenderMsg));
      }
    }



    




  </script>

</body>

</html>

