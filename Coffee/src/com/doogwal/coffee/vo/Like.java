package com.doogwal.coffee.vo;

import java.sql.Timestamp;

public class Like {

	private int no,likerNo,postNo;
	private Timestamp regdate;
	
	private String name,profileImg;
	
	
	public Like() {
		// TODO Auto-generated constructor stub
	}


	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public int getLikerNo() {
		return likerNo;
	}


	public void setLikerNo(int likerNo) {
		this.likerNo = likerNo;
	}


	public int getPostNo() {
		return postNo;
	}


	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}


	public Timestamp getRegdate() {
		return regdate;
	}


	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getProfileImg() {
		return profileImg;
	}


	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	
	
}
