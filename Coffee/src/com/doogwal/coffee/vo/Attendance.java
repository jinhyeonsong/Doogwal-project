package com.doogwal.coffee.vo;

import java.sql.Date;

public class Attendance {
	private int no,scheduleNo,memberNo;
	private char attendance;
	private Date regdate;
	private String profileImg;
	
	public Attendance() {
		// TODO Auto-generated constructor stub
	}
	
	public Attendance(int scheduleNo, int memberNo) {
		super();
		this.scheduleNo = scheduleNo;
		this.memberNo = memberNo;
	}

	public Attendance(int no, int scheduleNo, int memberNo, char attendance, Date regdate, String profileImg) {
		super();
		this.no = no;
		this.scheduleNo = scheduleNo;
		this.memberNo = memberNo;
		this.attendance = attendance;
		this.regdate = regdate;
		this.profileImg = profileImg;
	}
	public Attendance(int memberNo, char attendance, String profileImg) {
		super();
		this.memberNo = memberNo;
		this.attendance = attendance;
		this.profileImg = profileImg;
	}
	
	public Attendance(int scheduleNo, int memberNo, char attendance) {
		super();
		this.scheduleNo = scheduleNo;
		this.memberNo = memberNo;
		this.attendance = attendance;
	}
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getScheduleNo() {
		return scheduleNo;
	}

	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public char getAttendance() {
		return attendance;
	}

	public void setAttendance(char attendance) {
		this.attendance = attendance;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	
	




	
}
