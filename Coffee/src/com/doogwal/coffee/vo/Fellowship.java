package com.doogwal.coffee.vo;

import java.sql.Timestamp;

public class Fellowship {
	
	private int no,meetingNo,raterNo,rateeNo;
	private String review;
	private Timestamp regdate;
	
	public Fellowship() {
	
	}

	public Fellowship(int no, int meetingNo, int raterNo, int rateeNo, String review) {
		this.no = no;
		this.meetingNo = meetingNo;
		this.raterNo = raterNo;
		this.rateeNo = rateeNo;
		this.review = review;
	}
	public Fellowship(int meetingNo,int raterNo,int rateeNo,String review) {
		this.meetingNo = meetingNo;
		this.raterNo = raterNo;
		this.rateeNo = rateeNo;
		this.review = review;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getMeetingNo() {
		return meetingNo;
	}
	public void setMeetingNo(int meetingNo) {
		this.meetingNo = meetingNo;
	}
	public int getRaterNo() {
		return raterNo;
	}
	public void setRaterNo(int raterNo) {
		this.raterNo = raterNo;
	}
	public int getRateeNo() {
		return rateeNo;
	}
	public void setRateeNo(int rateeNo) {
		this.rateeNo = rateeNo;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	
	
	
}
