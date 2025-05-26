package com.shinhan5goodteam.omok.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.shinhan5goodteam.omok.dao.RoomDAO;
import com.shinhan5goodteam.omok.model.Room;


@WebServlet("/roomList")
public class RoomListServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    RoomDAO dao = new RoomDAO();
    List<Room> roomList = dao.getAllRooms();

    request.setAttribute("roomList", roomList);
    request.getRequestDispatcher("main.jsp").forward(request, response);
  }
}
