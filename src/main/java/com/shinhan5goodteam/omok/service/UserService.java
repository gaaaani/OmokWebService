package com.shinhan5goodteam.omok.service;

import com.shinhan5goodteam.omok.dao.UserDAO;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    public boolean isUserIdDuplicate(String userid){
        return userDAO.isUserIdExist(userid);
    }
}
