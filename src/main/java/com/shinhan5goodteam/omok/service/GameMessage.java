package com.shinhan5goodteam.omok.service;

//서버에서 클라이언트에게 전달해줄 메세지를 담는 객체
public class GameMessage {
    private String type;
    private int roomId;
    private String userId;
    private int x;
    private int y;

    public GameMessage(){};

	public GameMessage(String type, int roomId, String userId) {
        this.type = type;
        this.roomId = roomId;
        this.userId = userId;
    }

    public GameMessage(String type, int roomId, String userId, int x, int y) {
        this.type = type;
        this.roomId = roomId;
        this.userId = userId;
        this.x = x;
        this.y = y;
    }

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getX() {
		return x;
	}

	public void setX(int x) {
		this.x = x;
	}

	public int getY() {
		return y;
	}

	public void setY(int y) {
		this.y = y;
	}

}
