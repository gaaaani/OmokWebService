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
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String user_id = request.getParameter("user_id"); //로그인 폼에서 아이디 받기
		String user_pw = request.getParameter("user_pw"); // 로그인 폼에서 비밀번호 받기

		UserDAO userDao = new UserDAO(); //DAO 객체 생성
		User user = userDao.login(user_id, user_pw);

		if (user != null) {
			// 로그인 성공시 세션에 user 객체 저장
			request.getSession().setAttribute("user", user);
			response.sendRedirect("roomList");

		} else {
			// 로그인 실패 시 에러메세지를 세션에 저장 후 로그인 페이지로 이동
			request.getSession().setAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
			response.sendRedirect("login.jsp");
		}
	}

}
