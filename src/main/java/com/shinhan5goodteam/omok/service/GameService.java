package com.shinhan5goodteam.omok.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class GameService {

    private static Map<Integer, BoardService> boards = new ConcurrentHashMap<>();

    //user1 = 흑 , user2 = 백 
    //바둑판(board) 생성
    //생성한 바둑판 boards 에 저장 - 여러 방을 관리하기 위해
    public BoardService cerateBoard(int roomId, String user1Id, String user2Id){
        BoardService board = new BoardService(roomId, user1Id, user2Id);
        boards.put(roomId, board);
        return board;
    }

    public BoardService getBoard(int roomId){
        return boards.get(roomId);
    }

}
