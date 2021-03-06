package com.doogwal.coffee.vo;

import java.sql.Timestamp;

public class Reply {
	
	private int no,postNo,seq,memberNo;
	private String reply;
	private Timestamp regdate;
	
	private String name,profileImg;
	
	public Reply() {
		// TODO Auto-generated constructor stub
	}
	
	public Reply(int postNo, int memberNo, String reply) {
		this.postNo = postNo;
		this.memberNo = memberNo;
		this.reply = reply;
	}
	
	
	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
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


	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	
}
