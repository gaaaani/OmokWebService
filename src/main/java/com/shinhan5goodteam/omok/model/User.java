package com.shinhan5goodteam.omok.model;

import java.sql.Date;

public class User {
	private String userid;
	private String nickname;
	private String userpw;
	private int points;
	private Date createdat;
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

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}

	public Date getCreatedat() {
		return createdat;
	}

	public void setCreatedat(Date createdat) {
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
