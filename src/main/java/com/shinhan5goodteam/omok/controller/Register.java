package com.shinhan5goodteam.omok.controller;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shinhan5goodteam.omok.service.UserService;

/**
 * Servlet implementation class Register
 */
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Servlet#destroy()
	 */
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		//들어온 command를 통해 판별
		String command = request.getParameter("command");

		//아이디 중복 검사 요청 
		if (command.equals("checkid")){
			String userid = request.getParameter("userid");
			boolean isDupiclicate = userService.isUserIdDuplicate(userid);

			response.getWriter().write(String.valueOf(isDupiclicate));
		} else if (command.equals("checknickname")){	// 닉네임 중복검사 요청
			String usernickname = request.getParameter("usernickname");
			boolean isDupiclicate = userService.isUserNicknameDuplicate(usernickname);

			response.getWriter().write(String.valueOf(isDupiclicate));
		} else if (command.equals("register")){	// 계정 생성 요청
			String userid = request.getParameter("userid");
			String userpassword = request.getParameter("userpassword");
			String usernickname = request.getParameter("usernickname");
			String profileimage = request.getParameter("profileimage");
			String profilebackground = request.getParameter("profilebackground");
			System.out.println(userid+" "+userpassword+" "+usernickname+" "+profilebackground+" "+profileimage);
			boolean isCreatingAccount = userService.creatingAccount(userid, userpassword, usernickname, profileimage, profilebackground);
			response.getWriter().write(String.valueOf(isCreatingAccount));
		}

	}

}
