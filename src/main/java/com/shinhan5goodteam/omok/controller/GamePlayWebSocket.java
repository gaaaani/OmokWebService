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

@ServerEndpoint("/GamePlay/{roomId}")
public class GamePlayWebSocket {
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session, @PathParam("roomId") String roomId) {
        clients.add(session);
        System.out.println("클라이언트 연결됨 (room: " + roomId + ", session: " + session.getId() + ")");

    }

    @OnMessage
    public void handleMessage(String message, Session sender) throws IOException {
        System.out.println(message);
        for (Session client : clients) {
            if (client.isOpen() && !client.equals(sender)) {
                client.getBasicRemote().sendText(message);
            }
        }
        System.out.println(clients.size());
        if (clients.size() > 1){
            for (Session client : clients) {
                if (client.isOpen()) {
                    client.getBasicRemote().sendText("start");
                }
            }
        }
        
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);  // Set<Session> clients 에서 제거
        System.out.println("클라이언트 연결 종료됨: " + session.getId());
    }
    

}
