package com.shinhan5goodteam.omok.model;

public class Room {
	private int roomId;
	private String userId;
	private String roomName;
	private String roomExplain;
	private String createdAt;
	private String blackId;
	private String whiteId;
	private String closedAt;
	private String status;

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

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getRoomExplain() {
		return roomExplain;
	}

	public void setRoomExplain(String roomExplain) {
		this.roomExplain = roomExplain;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public String getBlackId() {
		return blackId;
	}

	public void setBlackId(String blackId) {
		this.blackId = blackId;
	}

	public String getWhiteId() {
		return whiteId;
	}

	public void setWhiteId(String whiteId) {
		this.whiteId = whiteId;
	}

	public String getClosedAt() {
		return closedAt;
	}

	public void setClosedAt(String closedAt) {
		this.closedAt = closedAt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
