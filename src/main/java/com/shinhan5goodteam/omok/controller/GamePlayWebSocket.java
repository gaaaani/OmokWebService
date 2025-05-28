package com.shinhan5goodteam.omok.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.shinhan5goodteam.omok.service.BoardService;
import com.shinhan5goodteam.omok.service.GameMessage;
import com.shinhan5goodteam.omok.service.GameService;
import com.shinhan5goodteam.omok.dao.HistoryDAO;
import com.shinhan5goodteam.omok.dao.RoomDAO;
import com.shinhan5goodteam.omok.dao.UserDAO;

import javax.websocket.Session;

//웹소켓 종단점
//roomId를 동적으로 받아 방마다 웹소켓 생성
@ServerEndpoint("/GamePlay/{roomId}")
public class GamePlayWebSocket {
    private static Map<String, Set<Session>> roomClients = new ConcurrentHashMap<>();
    private static GameService gameService = new GameService();

    //소켓 접속 시 1회 실행
    @OnOpen
    public void onOpen(Session session, @PathParam("roomId") String roomId) throws IOException {
        //clients에 접속 session 저장
        roomClients.putIfAbsent(roomId, Collections.synchronizedSet(new HashSet<>()));
        Set<Session> clients = roomClients.get(roomId);
        clients.add(session);
        System.out.println("클라이언트 연결됨 (room: " + roomId + ", session: " + session.getId() + ")");

        // //2명 접속 확인 후 게임 시작 전달
        // if (clients.size() == 2) {
        //     // user1, user2의 id는 세션에서 받아오거나, 임시로 session id 사용
        //     String[] userIds = clients.stream().map(Session::getId).toArray(String[]::new);
        //     BoardService board = gameService.cerateBoard(Integer.parseInt(roomId), userIds[0], userIds[1]);

        //     //게임 시작 최초 move 전달.
        //     //여기서 가는 user1id 가 흑으로 프론트에서 표시
        //     GameMessage gameMessage = new GameMessage(
        //         "move",
        //         Integer.parseInt(roomId),
        //         board.getUser1Id()
        //     );

        //     // JSON 변환
        //     Gson gson = new Gson();
        //     String jsonMessage = gson.toJson(gameMessage);
        //     for (Session client : clients) {
        //         if (client.isOpen()) {
        //             client.getBasicRemote().sendText(jsonMessage);
        //         }
        //     }
        //     System.out.println("방 " + roomId + "에 보드 생성 및 게임 시작");
        // }
    }

    //클라이언트에서 send 발생 시 실행
    @OnMessage
    public void handleMessage(String message, Session sender, @PathParam("roomId") String roomId) throws IOException {
        System.out.println(message);
        Set<Session> clients = roomClients.get(roomId);
        
        // JSON인지 확인
        if (message.trim().startsWith("{")) {
            Gson gson = new Gson();
            JsonObject json = JsonParser.parseString(message).getAsJsonObject();
            String type = json.get("type").getAsString();

            switch (type) {
                case "user": // 유저가 입장시에
                    // 유저 정보 전달
                    for (Session client : clients) {
                        if (client.isOpen() && !client.equals(sender)) {
                            // System.out.println("sendUser");
                            client.getBasicRemote().sendText(message);
                        }
                    }
                    String receivedUserId = json.get("id").getAsString();
                    sender.getUserProperties().put("userId", receivedUserId);

                    boolean allReady = clients.size() == 2 &&
                    clients.stream().allMatch(s -> s.getUserProperties().get("userId") != null);

                    if (allReady) {
                        String[] userIds = clients.stream()
                            .map(s -> (String) s.getUserProperties().get("userId"))
                            .toArray(String[]::new);

                        BoardService board = gameService.cerateBoard(Integer.parseInt(roomId), userIds[0], userIds[1]);

                        GameMessage gameMessage = new GameMessage(
                            "start",
                            Integer.parseInt(roomId),
                            board.getCurrentTurn()
                        );

                        RoomDAO.setBlackWhiteUsers(board.getUser1Id(), board.getUser2Id(), board.getRoomId());

                        Gson gsonStart = new Gson();
                        String jsonMessage = gsonStart.toJson(gameMessage);
                        for (Session client : clients) {
                            if (client.isOpen()) {
                                client.getBasicRemote().sendText(jsonMessage);
                            }
                        }
                        System.out.println("방 " + roomId + "에 보드 생성 및 게임 시작");
                    }
                    break;
                case "move":  //클라이언트에서 바둑알 둔 정보를 받았을 때
                    // 바둑판 적용
                    int x = json.get("x").getAsInt();
                    int y = json.get("y").getAsInt();
                    String userId = json.get("userId").getAsString();

                    BoardService board = gameService.getBoard(Integer.parseInt(roomId));

                    if(board.getBoard()[x][y] == 0 ){
                        if(board.placeStone(userId,x,y)){
                            // System.out.println("placeStone");
                            GameMessage gameMessage = new GameMessage(
                                "move",
                                Integer.parseInt(roomId),
                                board.getCurrentTurn(),
                                x,
                                y
                            );

                            board.print(); // 보드 확인용 콘솔 출력

                            // JSON 변환
                            Gson gson1 = new Gson();
                            String jsonMessage = gson1.toJson(gameMessage);
                            for (Session client : clients) {
                                if (client.isOpen()) {
                                    client.getBasicRemote().sendText(jsonMessage);
                                }
                            }
                        }

                        if(board.isOmok(userId, x, y)){
                            // System.out.println("gameOver");
                            GameMessage gameMessage = new GameMessage(
                                "over",
                                Integer.parseInt(roomId),
                                board.getCurrentTurn(),
                                x,
                                y
                            );

                            RoomDAO.setGameOver(board.getRoomId());
                            if(board.getUser1Id().equals(board.getCurrentTurn())){
                                UserDAO.updatePoint(board.getUser1Id(), UserDAO.findById(board.getUser1Id()).getPoints() - 100);
                                UserDAO.updatePoint(board.getUser2Id(), UserDAO.findById(board.getUser2Id()).getPoints() + 100);
                            } else {
                                UserDAO.updatePoint(board.getUser1Id(), UserDAO.findById(board.getUser1Id()).getPoints() + 100);
                                UserDAO.updatePoint(board.getUser2Id(), UserDAO.findById(board.getUser2Id()).getPoints() - 100);
                            }
                            HistoryDAO.addHistory(RoomDAO.getRoomById(Integer.parseInt(roomId)), board.getCurrentTurn().equals(board.getUser1Id()) ? board.getUser2Id() : board.getUser1Id());
                            

                            // JSON 변환
                            Gson gson1 = new Gson();
                            String jsonMessage = gson1.toJson(gameMessage);
                            for (Session client : clients) {
                                if (client.isOpen()) {
                                    client.getBasicRemote().sendText(jsonMessage);
                                }
                            }

                        }
                    } else {
                        if(board.placeStone(userId,x,y)){
                            // System.out.println("not placeStone");
                            GameMessage gameMessage = new GameMessage(
                                "move",
                                Integer.parseInt(roomId),
                                board.getCurrentTurn(),
                                x,
                                y
                            );

                            board.print(); // 보드 확인용 콘솔 출력

                            // JSON 변환
                            Gson gson1 = new Gson();
                            String jsonMessage = gson1.toJson(gameMessage);
                            for (Session client : clients) {
                                if (client.isOpen()) {
                                    client.getBasicRemote().sendText(jsonMessage);
                                }
                            }
                        }
                    }
                    break;
                case "exit": // 클라이언트에서 결과창에서 나가기를 요청했을 때
                    JsonObject exitMsg = new JsonObject();
                    exitMsg.addProperty("type", "exit");
                    exitMsg.addProperty("redirect", "roomList");
                    sender.getBasicRemote().sendText(exitMsg.toString());
                    break;
                case "surrender":
                    String surrenderId = json.get("userId").getAsString();
                    
                    BoardService board1 = gameService.getBoard(Integer.parseInt(roomId));
                    RoomDAO.setGameOver(board1.getRoomId());
                    if(board1.getUser1Id().equals(surrenderId)){
                        UserDAO.updatePoint(board1.getUser1Id(), UserDAO.findById(board1.getUser1Id()).getPoints() - 100);
                        UserDAO.updatePoint(board1.getUser2Id(), UserDAO.findById(board1.getUser2Id()).getPoints() + 100);
                    } else {
                        UserDAO.updatePoint(board1.getUser1Id(), UserDAO.findById(board1.getUser1Id()).getPoints() + 100);
                        UserDAO.updatePoint(board1.getUser2Id(), UserDAO.findById(board1.getUser2Id()).getPoints() - 100);
                    }
                    HistoryDAO.addHistory(RoomDAO.getRoomById(Integer.parseInt(roomId)), surrenderId.equals(board1.getUser1Id()) ? board1.getUser2Id() : board1.getUser1Id());
                    
                    JsonObject surrenderMsg = new JsonObject();
                    surrenderMsg.addProperty("type", "surrender");
                    surrenderMsg.addProperty("roomId", Integer.parseInt(roomId));
                    surrenderMsg.addProperty("userId", surrenderId);
                    
                    Gson gson1 = new Gson();
                    String jsonMessage = gson1.toJson(surrenderMsg);
                    for (Session client : clients) {
                        if (client.isOpen()) {
                            client.getBasicRemote().sendText(jsonMessage);
                        }
                    }


                    break;
                default:
                    System.out.println("알 수 없는 type: " + type);
            }
        } else {
            // 단순 문자열 메시지 처리
            for (Session client : clients) {
                if (client.isOpen() && !client.equals(sender)) {
                    client.getBasicRemote().sendText(message);
                }
            }
        }
        
    }

    //클라이언트가 웹소켓 퇴장시 실행
    @OnClose
    public void onClose(Session session, @PathParam("roomId") String roomId) {
        Set<Session> clients = roomClients.get(roomId);
        // String userId = (String) session.getUserProperties().get("userId");
        if (clients != null) {
            clients.remove(session);
            System.out.println("클라이언트 연결 종료됨: " + session.getId());
            if (clients.isEmpty()) {
                roomClients.remove(roomId);
            }
        }

        //클라이언트가 나갔는데 빈 방이 되면 방 상태 변경
        if (clients.size() == 0){
            // System.out.println("gameOver");
            RoomDAO.setGameOver(Integer.parseInt(roomId));
        }
    }
    

}
