package com.shinhan5goodteam.omok.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.shinhan5goodteam.omok.dao.RoomDAO;
import com.shinhan5goodteam.omok.model.Room;
import com.shinhan5goodteam.omok.model.User;


@WebServlet("/roomList")
public class RoomList extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
	HttpSession session = request.getSession();
	User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
      response.sendRedirect("login.jsp");
      return;
    }
    RoomDAO dao = new RoomDAO();
    List<Room> roomList = dao.getAllRooms();

    request.setAttribute("roomList", roomList);
    request.setAttribute("user", user);
    request.getRequestDispatcher("main.jsp").forward(request, response);
  }
}
