<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.shinhan5goodteam.omok.model.Room" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/main.css" />
</head>
<body>
<div id="wrapper">
    <header>
        <div class="title">5조은목</div>
        <div class=header-icon>
	        <div class="record_icon">
	            <img src="img/tomyhistoryicon.png" alt="전적" />
	        </div>        <div class="mypage_icon">
	
	            <img src="img/sol.png" alt="마이페이지" />
	        </div>
        </div>
    </header>
    <main>
        <div class="main-title">
            <h3>방 리스트 확인</h3>
            <img src="img/update_jcon.png" alt="새로고침" class="update-icon" id="update" />
        </div>
        <div class="main-container">

            <%
                List<Room> roomList = (List<Room>) request.getAttribute("roomList");
                if (roomList != null && !roomList.isEmpty()) {
                    for (Room room : roomList) {
            %>
                        <div class="room-box">
                            <div class="room-left">
                                <div class="room-title"><%= room.getRoomName() %></div>
                                <div class="room-subtitle"><%= room.getRoomExplain() %></div>
                            </div>
                            <div class="room-right">
                                <img src="img/sol.png" alt="프로필 이미지" />
                                <div class="room-point"><%= room.getUserId() %></div>
                            </div>
                        </div>
            <%
                    }
                } else {
            %>
                    <p>현재 생성된 방이 없습니다.</p>
            <%
                }
            %>

        </div>
    </main>
    <footer>
        <button class="createbtn" onclick="openModal()">방 만들기</button>
    </footer>

    <!-- ✅ 방 만들기 Modal -->
    <div id="modal" class="hidden">
        <div id="modal-inner">
            <div id="modal-title-row">
                <h2 class="modal-title">방 만들기</h2>
                <div id="modal-close">
                    <img src="img/typcn_delete.png" />
                </div>
            </div>

            <!-- ✅ form으로 감싸고 서버에 POST 요청 -->
            <form action="createRoom" method="post">
                <div id="modal-content">
                    <div class="modal-common">
                        <label> > 방 이름 </label>
                        <input type="text" name="roomName" class="modal-input" placeholder="들어오세요~~!!" required>
                    </div>

                    <div class="modal-common">
                        <div class="code-row">
                            <label class="code-label"> > 방 코드 </label>
                            <div class="private-wrap">
                                <span class="private-label">비밀방</span>
                                <img src="img/ion_checkbox-outline.png" class="check-icon">
                            </div>
                        </div>
                        <!-- 추후 비밀번호 기능 사용 시 name 부여 -->
                        <input type="password" name="roomCode" class="code-input" placeholder="********">
                    </div>

                    <div class="modal-common">
                        <label> > 방 소개 </label>
                        <input type="text" name="roomExplain" class="modal-input" placeholder="나랑 오목을 겨루자!@!!">
                    </div>

                    <!-- ✅ 서브밋 버튼으로 변경 -->
                    <button type="submit" class="modal-createbtn">만들기</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const modal = document.getElementById("modal");
        const modalClose = document.getElementById("modal-close");

        function openModal() {
            modal.classList.remove("hidden");
        }

        function closeModal() {
            modal.classList.add("hidden");
        }

        modalClose.addEventListener("click", closeModal);
        
        //update icon 클릭시 페이지 새로고침
        const update= document.getElementById("update");

        update.addEventListener("click", () => {
            location.reload();
        });
        
    </script>
</body>
</html>