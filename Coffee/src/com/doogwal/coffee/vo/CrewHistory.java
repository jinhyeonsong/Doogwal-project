package com.doogwal.coffee.vo;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class CrewHistory {
	private char type;
	private String crewName, coverImg, meetingName;
	private Timestamp startDate;
	
	public CrewHistory() {
		// TODO Auto-generated constructor stub
	}
	
	public CrewHistory(char type, String crewName, String coverImg, String meetingName, Timestamp startDate) {
		super();
		this.type = type;
		this.crewName = crewName;
		this.coverImg = coverImg;
		this.meetingName = meetingName;
		this.startDate = startDate;
	}

	public char getType() {
		return type;
	}
	public void setType(char type) {
		this.type = type;
	}
	public String getCrewName() {
		return crewName;
	}
	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}
	public String getCoverImg() {
		return coverImg;
	}
	public void setCoverImg(String coverImg) {
		this.coverImg = coverImg;
	}
	public String getMeetingName() {
		return meetingName;
	}
	public void setMeetingName(String meetingName) {
		this.meetingName = meetingName;
	}
	public Timestamp getStartDate() {
		return startDate;
	}
	public String getStartDateDetail() {
		SimpleDateFormat format1 = new SimpleDateFormat("YYYY년 MM월 DD일 a hh:mm");
		return format1.format(this.startDate);
	}
	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}
	
	
}



