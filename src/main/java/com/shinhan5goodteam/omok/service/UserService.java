package com.shinhan5goodteam.omok.service;

import com.shinhan5goodteam.omok.dao.UserDAO;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    public boolean isUserIdDuplicate(String userid){
        return userDAO.isUserIdExist(userid);
    }

    public boolean isUserNicknameDuplicate(String usernickname){
        return userDAO.isUserNicknameExist(usernickname);
    }

    public boolean creatingAccount(String userid, String userpassword, String usernickname,String  profileimage, String profilebackground){
        return userDAO.createAccount(userid,userpassword,usernickname,profileimage,profilebackground);
    }
}
