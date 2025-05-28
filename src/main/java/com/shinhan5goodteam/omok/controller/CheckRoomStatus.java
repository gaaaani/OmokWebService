package com.shinhan5goodteam.omok.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shinhan5goodteam.omok.dao.RoomDAO;

//방 상태 최신화 요청
@WebServlet("/checkRoomStatus")
public class CheckRoomStatus extends HttpServlet {
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomIdStr = request.getParameter("roomId");
        int roomId = Integer.parseInt(roomIdStr);

        RoomDAO dao = new RoomDAO();
        String status = dao.getRoomStatusById(roomId); // 이 메서드는 아래에서 설명

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"status\": \"" + status + "\"}");
    }
}