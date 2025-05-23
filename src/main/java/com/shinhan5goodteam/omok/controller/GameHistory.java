package com.shinhan5goodteam.omok.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shinhan5goodteam.omok.dao.HistoryDAO;
import com.shinhan5goodteam.omok.model.History;
import com.shinhan5goodteam.omok.model.User;


public class GameHistory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GameHistory() {
		super();

	}

	@Override
	public void init(ServletConfig config) throws ServletException {
	}

	@Override
	public void destroy() {
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인한 사용자 정보 가져오기
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		String userId = user.getUserid();

		// DAO에서 해당 사용자의 전적만 조회
		HistoryDAO dao = new HistoryDAO();
		List<History> historyList = dao.getUserHistories(userId);

		request.setAttribute("historyList", historyList);
		request.getRequestDispatcher("myhistory.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);

	}

}
