<c:forEach var="room" items="${roomList}">
    <div>
        <p>방 이름: ${room.roomName}</p>
        <p>소개: ${room.roomExplain}</p>
        <a href="game.jsp?roomId=${room.roomId}">입장</a>
    </div>
</c:forEach>
