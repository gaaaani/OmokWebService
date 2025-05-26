package com.shinhan5goodteam.omok.service;

import com.shinhan5goodteam.omok.dao.UserDAO;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    //아이디 중복 검사 
    public boolean isUserIdDuplicate(String userid){
        return userDAO.isUserIdExist(userid);
    }

    //닉네임 중복 검사
    public boolean isUserNicknameDuplicate(String usernickname){
        return userDAO.isUserNicknameExist(usernickname);
    }

    //계성 생성
    public boolean creatingAccount(String userid, String userpassword, String usernickname,String  profileimage, String profilebackground){
        return userDAO.createAccount(userid,userpassword,usernickname,profileimage,profilebackground);
    }
}
