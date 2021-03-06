package com.doogwal.coffee.vo;

import java.sql.Timestamp;
import java.util.List;

public class Post {

	private int no,memberNo,likeCnt,boardNo,replyCnt;
	private char imageApplicable,top;
	private String contents;
	private Timestamp regdate;
	
	private String texts;
	
	// report
	private List<Report> reports;

	// user
	private String name,profileImg;
	
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

	public List<Report> getReports() {
		return reports;
	}

	public void setReports(List<Report> reports) {
		this.reports = reports;
	}

	public String getTexts() {
		return texts;
	}

	public void setTexts(String texts) {
		this.texts = texts;
	}

	public Post() {
		// TODO Auto-generated constructor stub
	}
	
	public Post(int memberNo, int likeCnt, int boardNo, char imageApplicable, String contents,char top,String texts) {
		this.memberNo = memberNo;
		this.likeCnt = likeCnt;
		this.boardNo = boardNo;
		this.imageApplicable = imageApplicable;
		this.contents = contents;
		this.top = top;
		this.texts = texts;
	}
	

	public int getReplyCnt() {
		return replyCnt;
	}


	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}


	public Timestamp getRegdate() {
		return regdate;
	}


	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public char getTop() {
		return top;
	}


	public void setTop(char top) {
		this.top = top;
	}


	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public char getImageApplicable() {
		return imageApplicable;
	}

	public void setImageApplicable(char imageApplicable) {
		this.imageApplicable = imageApplicable;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}
	
	
	
}
