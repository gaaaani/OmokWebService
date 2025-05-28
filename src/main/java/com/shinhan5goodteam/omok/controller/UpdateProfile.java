

package com.shinhan5goodteam.omok.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shinhan5goodteam.omok.dao.UserDAO;

import com.shinhan5goodteam.omok.model.User;

import javax.servlet.annotation.WebServlet;
@WebServlet("/updateProfile")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public UpdateProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8");

        String character = request.getParameter("character");
        String backgroundColor = request.getParameter("backgroundColor");

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.setStatus(401);
            response.getWriter().write("{\"result\":\"fail\", \"message\":\"로그인 필요\"}");
            return;
        }

        boolean success = new UserDAO().updateProfile(user.getUserid(), character, backgroundColor);

        if (success) {
            user.setProfileimage(character);
            user.setProfilecolor(backgroundColor);
            request.getSession().setAttribute("user", user);

            response.getWriter().write("{\"result\":\"success\"}");
        } else {
            response.setStatus(500);
            response.getWriter().write("{\"result\":\"fail\", \"message\":\"DB 업데이트 실패\"}");
        }
    }


}
