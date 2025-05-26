package com.shinhan5goodteam.omok.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import javax.websocket.Session;

//웹소켓 종단점
//roomId를 동적으로 받아 방마다 웹소켓 생성
@ServerEndpoint("/GamePlay/{roomId}")
public class GamePlayWebSocket {
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

    //소켓 접속 시 1회 실행
    @OnOpen
    public void onOpen(Session session, @PathParam("roomId") String roomId) {
        //clients에 접속 session 저장
        clients.add(session);
        System.out.println("클라이언트 연결됨 (room: " + roomId + ", session: " + session.getId() + ")");

    }

    //클라이언트에서 send 발생 시 실행
    @OnMessage
    public void handleMessage(String message, Session sender) throws IOException {
        System.out.println(message);
        //상대방에게만 메세지 전송
        for (Session client : clients) {
            if (client.isOpen() && !client.equals(sender)) {
                client.getBasicRemote().sendText(message);
            }
        }
        System.out.println(clients.size());
        //2명 접속 확인 후 게임 시작 전달
        if (clients.size() > 1){
            for (Session client : clients) {
                if (client.isOpen()) {
                    client.getBasicRemote().sendText("start");
                }
            }
        }
        
    }

    //클라이언트가 웹소켓 퇴장시 실행
    @OnClose
    public void onClose(Session session) {
        clients.remove(session);  // Set<Session> clients 에서 제거
        System.out.println("클라이언트 연결 종료됨: " + session.getId());
    }
    

}
