package com.doogwal.coffee.vo;

import java.sql.Timestamp;

public class MeetApp {

	private int no,meetingNo,applyCrewNo;
	private char acceptance;
	private String introduce;
	private Timestamp regdate;
	
	public MeetApp() {
		// TODO Auto-generated constructor stub
	}

	public MeetApp(int no, int meetingNo, int applyCrewNo, char acceptance, String introduce) {
		this.no = no;
		this.meetingNo = meetingNo;
		this.applyCrewNo = applyCrewNo;
		this.acceptance = acceptance;
		this.introduce = introduce;
	}
	public MeetApp(int meetingNo, int applyCrewNo, String introduce) {
		super();
		this.meetingNo = meetingNo;
		this.applyCrewNo = applyCrewNo;
		this.introduce = introduce;
	}

	public MeetApp(int meetingNo, int applyCrewNo) {
		super();
		this.meetingNo = meetingNo;
		this.applyCrewNo = applyCrewNo;
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

	public int getApplyCrewNo() {
		return applyCrewNo;
	}

	public void setApplyCrewNo(int applyCrewNo) {
		this.applyCrewNo = applyCrewNo;
	}

	public char getAcceptance() {
		return acceptance;
	}

	public void setAcceptance(char acceptance) {
		this.acceptance = acceptance;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	
	
	
	
}
