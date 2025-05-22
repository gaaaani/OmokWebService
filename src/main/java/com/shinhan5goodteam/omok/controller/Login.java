package com.shinhan5goodteam.omok.controller;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shinhan5goodteam.omok.dao.UserDAO;
import com.shinhan5goodteam.omok.model.User;

@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");

		UserDAO userDao = new UserDAO();
		User user = userDao.login(user_id, user_pw);

		if (user != null) {
			// 로그인 성공
			request.getSession().setAttribute("user", user);
			response.sendRedirect("main.html");
		} else {
			// 로그인 실패 시
			request.getSession().setAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
			response.sendRedirect("login.jsp");
		}
	}

}
