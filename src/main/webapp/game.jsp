<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.shinhan5goodteam.omok.model.User" %>
<%@ page import="com.shinhan5goodteam.omok.model.Room" %>
<%
 
  String roomId = "1";
  String userId = "aaa";

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
              <img src="img/lay.png" alt="부엉이" id="leftUser">
            </div>
            <div class="name-stone">
              <span class="player-name"><%= userId %></span>
              <span class="stone">⚫</span>
            </div>
            <div class="score">오목조목링 9514점</div>
          </div>

          <div id="timer">
            <span id="left-time">30</span> ⏱ <span id="right-time">30</span>
          </div>


          <div id="right-user">
            <div class="avatar-bg" style="background-color: #E9E9E9;">
              <img src="img/sol.png" alt="곰돌이" id="rightUser">
            </div>
            <div class="name-stone">
              <span id="yourId" class="player-name"></span>
              <span class="stone">⚪</span>
            </div>
            <div class="score">오목조목킹 9514점</div>
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
            <img src="img/lay.png" alt="win" class="popup-avatar" id="winner-img">
          </div>
          <p id="winner-text">부엉이 🏆 +100점!!</p>
        </div>
        <div class="divider"></div>
        <button class="popup-button" onclick="closeAllPopups()">나가기</button>
      </div>

      <!-- 3) 패배 팝업 -->
      <div id="loser-popup" class="popup-box">
        <h2>LOSE !!</h2>
        <div class="avatar-bg" style="background-color: #F8BBD0;">
          <img src="img/sol.png" alt="lose" class="popup-avatar" id="lose-img">
        </div>
        <p id="loser-text">곰돌이 😢 −100점!!</p>
        <div class="divider"></div>
        <button class="popup-button" onclick="closeAllPopups()">나가기</button>
      </div>

    </div>

  </div>

  <script>
    let socket;
    let yourId;
    let pos;
    
    function connect() {
    	console.log("connect 실행됨");
      socket = new WebSocket("ws://localhost:8090/omok/GamePlay/"+"<%= roomId %>" );
      socket.onopen = function() {
        socket.send("<%= userId %>");
        console.log('웹소켓 접속 성공');
      };
      socket.onmessage = function(e){
        console.log(e.data);
        yourId = e.data;
        document.querySelector("#yourId").innerHTML = yourId;
        if (e.data == "start"){
          gameStart();
        }
      };
      socket.onclose = function() {
          console.log('서버랑 연결이 끊어졌습니다');
      };
    };
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
    	  connect();         
    	  drawOmok();   
    	});
    


    
    
    function gameStart() {
      if ( parseInt(Math.random * 10) % 2 == 0){
        Room.setWhiteId = myId;
        Room.setBlackId = yourId;
      } else{
        Room.setWhiteId = yourId;
        Room.setBlackId = myId;
      }
      document.querySelector("#move-button").removeAttribute("disabled");

    }
    
    


    /*
    타이머 기능
    */
    let leftTime = 30;
    let rightTime = 30;
    let current = 'left';   
    let timerId = null;

    const leftDisplay = document.getElementById('left-time');
    const rightDisplay = document.getElementById('right-time');
    const moveBtn = document.getElementById('move-button');
    const exitBtn = document.getElementById('exit-button');

    // 화면에 시간 업데이트
    // function updateDisplays() {
    //   leftDisplay.textContent = leftTime;
    //   rightDisplay.textContent = rightTime;
    // }

    // function startTimer() {
    //   if (timerId) clearInterval(timerId);
    //   timerId = setInterval(() => {
    //     if (current == 'left') {
    //       leftTime--;
    //       if (leftTime <= 0) return onTimeout('left');
    //     } else {
    //       rightTime--;
    //       if (rightTime <= 0) return onTimeout('right');
    //     }
    //     updateDisplays();
    //   }, 1000);
    //   updateDisplays();
    // }

    // function onTimeout(player) {
    //   clearInterval(timerId);
    //   alert(`${player == 'left' ? '부엉이' : '곰돌이'} 시간이 초과되었습니다.`);
    //   switchTurn();
    // }

    // function switchTurn() {
    //   if (current == 'left') leftTime = 30;
    //   else rightTime = 30;
    //   current = (current == 'left') ? 'right' : 'left';
    //   startTimer();
    // }

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
