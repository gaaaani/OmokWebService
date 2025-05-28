package com.shinhan5goodteam.omok.model;

import java.sql.Date;

public class Room {
	private int roomId;
	private String userId;
	private String roomName;
	private String roomExplain;
	private Date createdAt;
	private String blackId;
	private String whiteId;
	private Date closedAt;
	private String status;
	private String profileColor;
	private String profileImage;
	private String nickName;
	private int points;

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

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
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

	public Date getClosedAt() {
		return closedAt;
	}

	public void setClosedAt(Date closedAt) {
		this.closedAt = closedAt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getProfileColor() {
		return profileColor; 
	}
	public void setProfileColor(String profileColor) {
		this.profileColor = profileColor;
	}
	public String getProfileImage() {
		return profileImage; 
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage; 
	}
	public String getNickName(){
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getPoints() {
		return points;
	}
	public void setPoints(int points) {
		this.points = points;
	}
}

