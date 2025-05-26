package com.shinhan5goodteam.omok.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.shinhan5goodteam.omok.dao.RoomDAO;
import com.shinhan5goodteam.omok.model.Room;
import com.shinhan5goodteam.omok.model.User;

@WebServlet("/createRoom")
public class RoomCreateServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");

    String roomName = request.getParameter("roomName");
    String roomExplain = request.getParameter("roomExplain");

    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
      response.sendRedirect("login.jsp");
      return;
    }

    Room room = new Room();
    room.setRoomName(roomName);
    room.setRoomExplain(roomExplain);
    room.setUserId(user.getUserid());
    room.setStatus("ready");

    int roomId = RoomDAO.insertRoom(room);

    if (roomId != -1) {
      response.sendRedirect("game.jsp?roomId=" + roomId);
    } else {
      response.getWriter().write("<script>alert('방 생성 실패'); history.back();</script>");
    }
  }
}
