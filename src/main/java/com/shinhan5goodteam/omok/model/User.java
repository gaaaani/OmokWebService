package com.shinhan5goodteam.omok.model;

public class User {
	private String userid;
	private String nickname;
	private String userpw;
	private String points;
	private String createdat;
	private String profileimage;
	private String profilecolor;

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUserpw() {
		return userpw;
	}

	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}

	public String getPoints() {
		return points;
	}

	public void setPoints(String points) {
		this.points = points;
	}

	public String getCreatedat() {
		return createdat;
	}

	public void setCreatedat(String createdat) {
		this.createdat = createdat;
	}

	public String getProfileimage() {
		return profileimage;
	}

	public void setProfileimage(String profileimage) {
		this.profileimage = profileimage;
	}

	public String getProfilecolor() {
		return profilecolor;
	}

	public void setProfilecolor(String profilecolor) {
		this.profilecolor = profilecolor;
	}

}