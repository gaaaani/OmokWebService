<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.shinhan5goodteam.omok.model.Room"%>
<%@ page import="com.shinhan5goodteam.omok.model.User"%>
<%!// HEX 매핑 함수
	public String getProfileColorHex(String color) {
		if ("orange".equals(color))
			return "#F3B671";
		if ("pink".equals(color))
			return "#F2BFCB";
		if ("gray".equals(color))
			return "#A4B2C0";
		if ("navy".equals(color))
			return "#5874A0";
		return "#D8CFE2";
	}%>

<%
	User loginUser = (User) request.getAttribute("user"); // 로그인 유저 정보
	String loginProfileImagePath = "img/" + loginUser.getProfileimage() + ".png";
	String loginProfileColorHex = getProfileColorHex(loginUser.getProfilecolor());
%>
<DOCTYPE html>
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
		<a href="<%= request.getContextPath() %>/roomList" id=home>
			<div class="title">5조은목</div>
		</a>
			<div class=header-icon>
				<a href="<%= request.getContextPath() %>/GameHistory">
					<div class="record_icon">
						<img src="img/tomyhistoryicon.png" alt="전적" />
					</div>
				</a>
				<a href="myprofil.jsp">
					<div class="mypage_icon" id="mypageIcon"
						style="background-color: <%=loginProfileColorHex%>; border-radius: 50%; padding: 5px;">
						<img src="<%=loginProfileImagePath%>" alt="마이페이지" />
					</div>
				</a>
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
						String profileImagePath = "img/" + room.getProfileImage() + ".png";
						String profileColorHex = getProfileColorHex(room.getProfileColor());
				%>
				<a href="game.jsp?roomId=<%= room.getRoomId() %>" class="room-box-link">
					<div class="room-box">
						<div class="room-left">
							<div class="room-title"><%=room.getRoomName()%></div>
							<div class="room-subtitle"><%=room.getRoomExplain()%></div>
						</div>
	
						<div class=profile>
							<div class="room-right">
								<div class="room-point"
									style="background-color: <%=getProfileColorHex(room.getProfileColor())%>;">
									<%=room.getNickName()%>
								</div>
								<div class="image-container"
									style="background-color: <%=getProfileColorHex(room.getProfileColor())%>;">
									<img src="<%=profileImagePath%>" alt="프로필 이미지" />
								</div>
							</div>
							<div class="ranking">
								오목조목킹:
								<%=room.getPoints()%></div>
						</div>
					</div>
				</a>
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
							<label> > 방 이름 </label> <input type="text" name="roomName" class="modal-input">
						</div>
						<div class="modal-common">
							<label> > 방 소개 </label> <input type="text" name="roomExplain"class="modal-input">
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