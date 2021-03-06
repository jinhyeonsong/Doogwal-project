package com.doogwal.coffee.vo;

import java.sql.Timestamp;

public class Record {

	private int no, crewNo, meetingNo;
	private char type;
	private Timestamp regdate;
	
	public Record() {
	}
	

	public Record(int no, int crewNo, int meetingNo, char type) {
		this.no = no;
		this.crewNo = crewNo;
		this.meetingNo = meetingNo;
		this.type = type;
	}


	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getCrewNo() {
		return crewNo;
	}

	public void setCrewNo(int crewNo) {
		this.crewNo = crewNo;
	}

	public int getMeetingNo() {
		return meetingNo;
	}

	public void setMeetingNo(int meetingNo) {
		this.meetingNo = meetingNo;
	}

	public char getType() {
		return type;
	}

	public void setType(char type) {
		this.type = type;
	}

	
}
