<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.shinhan5goodteam.omok.model.User" %>
<%@ page import="com.shinhan5goodteam.omok.model.Room" %>
<%@ page import="com.shinhan5goodteam.omok.dao.UserDAO" %>
<%
  
  //유저 객체 생성된
  //user1 본인. user2는 상대방.
  User user1 = (User) session.getAttribute("user");
  User user2 = null;

  //방 객체 생성. 원래는 생성된 Room 객체를 가져옴.
  //방 만들기, 방 입장 시 Room 데이터를 어떻게 가져올지 정해야함.
  Room room = new Room();
  room.setRoomId(1);
  room.setUserId("aaa");
  room.setRoomName("testroom");
  room.setStatus("ready");
  
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

</head>

<body>
  <div id="wrapper">
    <div id="header">
      <div id="title-bar">
        <span>5조은목</span>
        <!-- <img id="chat-icon" src="chat.png" alt="채팅"> -->
      </div>
    </div>

    <div id="omok-board" style="position: relative;"></div>

    <div class="info-panel">
      <div class="info-panel-inside">
        <div id="player-info">
          <div id="left-user">
            <div class="avatar-bg" style="background-color: #F8BBD0;">
              <img src="img/sol.png" id="leftUser">
            </div>
            <div class="name-stone">
              <span class="player-name"><%= user1.getNickname() %></span>
              <span class="stone">⚫</span>
            </div>
            <div class="score">오목조목킹 <%= user1.getPoints() %></div>

          </div>

          <div id="timer">
            <span id="left-time">30</span> ⏱ <span id="right-time">30</span>
          </div>

          <div id="right-user">
            <div class="avatar-bg" style="background-color: #E9E9E9;">

              <img src="img/sol.png" alt="곰돌이" id="rightUser">
            </div>
            <div class="name-stone">
              <span id="user2" class="player-name"><%= user2.getNickname() %></span>
              <span class="stone">⚪</span>
            </div>
            <div id="user2point" class="score">오목조목킹 <%= user2.getPoints() %></div>

          </div>
        </div>
        <button id="move-button" disabled>착수</button>
      </div>
      <button id="exit-button">나가기</button>
    </div>

    <div id="popup-overlay">
      <!-- 1) 나가기 확인 팝업 -->
      <div id="exit-popup" class="popup-box">
        <p>지금 나가면 항복처리 됩니다.</p>
        <button class="popup-button" onclick="closeAllPopups()">취소</button>
        <button class="popup-button" onclick="confirmExit()">나가기</button>
      </div>

      <!-- 2) 승리 팝업 -->
      <div id="winner-popup" class="popup-box">
        <h2>WIN !!</h2>
        <div>
          <div class="avatar-bg" style="background-color: #E9E9E9;">
            <img src="" alt="win" class="popup-avatar" id="winner-img">
          </div>
          <p id="winner-text"><%= user1.getNickname() %> 🏆 +100점!!</p>
        </div>
        <div class="divider"></div>
        <button class="popup-button" onclick="closeAllPopups()">나가기</button>
      </div>

      <!-- 3) 패배 팝업 -->
      <div id="loser-popup" class="popup-box">
        <h2>LOSE !!</h2>
        <div class="avatar-bg" style="background-color: #F8BBD0;">
          <img src="" alt="lose" class="popup-avatar" id="lose-img">
        </div>
        <p id="loser-text"><%= user1.getNickname() %> 😢 −100점!!</p>
        <div class="divider"></div>
        <button class="popup-button" onclick="closeAllPopups()">나가기</button>
      </div>

    </div>

  </div>

  <script>

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
    	      cell.className = "cell";
    	      cell.style.left = Math.round(offset + x * gap) + "px";
    	      cell.style.top = Math.round(offset + y * gap) + "px";
    	      cell.dataset.x = x;
    	      cell.dataset.y = y;
    	      cell.addEventListener("click", function () {
    	        console.log("(x: " + this.dataset.x + ", y: " + this.dataset.y + ")");
    	      });
    	      board.appendChild(cell);
    	    }
    	  }
    	}
    
    document.addEventListener("DOMContentLoaded", function () {       
    	  drawOmok();   
    	});

    //js에서 사용하기 위해 객체 저장
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
    
    let room = {
      roomId: "<%= room.getRoomId() %>",
      createuserId: "<%= room.getUserId() %>",
      status: "<%= room.getStatus() %>"
    }
    let user2;

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
    }
    
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
          } else if (data1.type == "move"){ //넘어온 객체가 move인 경우. 서버에서 바둑판 정보를 보낸것. 방id, 현재 차례 유저 등

          } else if (data1.type == "start"){
            
          }
        }
      };

      socket.onclose = function() { //소켓 연결 종료 시 실행
        socket.close();
        console.log('서버랑 연결이 끊어졌습니다');
      };
    };
    window.onload = connect; // 창 로드가 완료된 후 소켓연결
    

    let whiteuser;
    let blackuser;

    let leftTime = 30;
    let rightTime = 30;
    let current = 'left';   
    let timerId = null;

    const leftDisplay = document.getElementById('left-time');
    const rightDisplay = document.getElementById('right-time');
    const moveBtn = document.getElementById('move-button');
    const exitBtn = document.getElementById('exit-button');

    //게임시작시 흑백 선정과 버튼 활성화
    function gameStart() {
      console.log("game Start")
      if ( parseInt(Math.random() * 10) % 2 == 0){
        whiteuser = user1.id;
        blackuser = user2.id;
      } else{
        whiteuser = user2.id;
        blackuser = user1.id;
      }
      document.querySelector("#move-button").disabled = false;
      //document.querySelector(".boardbutton").removeAttribute("disabled");
      startTimer(); // 타이머 시작
    };
    
    // 바둑돌 두기 이벤트. 미구현
    // document.querySelector(".boardbutton").addEventListener('click',function(){
    //   pos.val();
    //   pos = this.parentElemnt.id;
    // });


    /*
    타이머 기능
    */
   

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
          if (leftTime <= 0) return onTimeout('left');
        } else {
          rightTime--;
          if (rightTime <= 0) return onTimeout('right');
        }
        updateDisplays();
      }, 1000);
      updateDisplays();
    }
    //타임 오버
    function onTimeout(player) {
      clearInterval(timerId);
      alert(`${player == 'left' ? '부엉이' : '곰돌이'} 시간이 초과되었습니다.`);
      switchTurn();
    }
    // 턴 변환
    function switchTurn() {
      if (current == 'left') leftTime = 30;
      else rightTime = 30;
      current = (current == 'left') ? 'right' : 'left';
      startTimer();
    }

    // “착수” 버튼 클릭 시 턴 전환
    // moveBtn.addEventListener('click', () => {
    //   clearInterval(timerId);
    //   switchTurn();
    // });


    // 페이지 로드 시 타이머 시작
    // window.addEventListener('load', startTimer);
    /*
    팝업 제어 함수 모음
    */

    // // 모든 팝업 닫기
    // function closeAllPopups() {
    //   document.getElementById('popup-overlay').style.display = 'none';
    //   ['exit-popup', 'winner-popup', 'loser-popup'].forEach(id => {
    //     document.getElementById(id).style.display = 'none';
    //   });
    // }

    // // 나가기 확인 팝업 열기
    // function showExitPopup() {
    //   document.getElementById('popup-overlay').style.display = 'block';
    //   document.getElementById('exit-popup').style.display = 'block';
    // }

    // //  나가기(항복) 처리
    // function confirmExit() {
    //   closeAllPopups();
    //   alert('항복 처리되었습니다.');
    // }

    // // 승리 팝업 열기
    // // player: '부엉이' or '곰돌이', delta: 점수 변화값(숫자)
    // function showWinnerPopup(player, delta) {
    //   document.getElementById('popup-overlay').style.display = 'block';
    //   document.getElementById('winner-text').textContent = `${player} 🏆 +${delta}점!!`;
    //   document.getElementById('winner-popup').style.display = 'block';
    // }

    // // 패배 팝업 열기
    // function showLoserPopup(player, delta) {
    //   document.getElementById('popup-overlay').style.display = 'block';
    //   document.getElementById('loser-text').textContent = `${player} 😢 −${delta}점!!`;
    //   document.getElementById('loser-popup').style.display = 'block';
    // }

    // // 게임 종료 시 호출하는 함수
    // // winner: 'left' or 'right'
    // function onGameEnd(winner) {
    //   clearInterval(timerId);
    //   if (winner == 'left') {
    //     showWinnerPopup('부엉이', 100);
    //   } else {
    //     showLoserPopup('곰돌이', 100);
    //   }
    // }

    // // “나가기” 버튼에 팝업 연결
    // exitBtn.addEventListener('click', showExitPopup);




  </script>

</body>

</html>

