package com.doogwal.coffee.vo;

import java.sql.Date;

public class MeetingWeApplied {
	private int meetAppsNo, meetingsNo, applyCrewNo;
	private String img, schedulesName, description, address, introduce, crewName;
	private char acceptance;
	private Date startDate;
	
	public MeetingWeApplied() {
		// TODO Auto-generated constructor stub
	}

	public int getMeetAppsNo() {
		return meetAppsNo;
	}

	public int getMeetingsNo() {
		return meetingsNo;
	}

	public int getApplyCrewNo() {
		return applyCrewNo;
	}

	public String getImg() {
		return img;
	}

	public String getSchedulesName() {
		return schedulesName;
	}

	public String getDescription() {
		return description;
	}

	public String getAddress() {
		return address;
	}

	public String getIntroduce() {
		return introduce;
	}

	public String getCrewName() {
		return crewName;
	}

	public char getAcceptance() {
		return acceptance;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setMeetAppsNo(int meetAppsNo) {
		this.meetAppsNo = meetAppsNo;
	}

	public void setMeetingsNo(int meetingsNo) {
		this.meetingsNo = meetingsNo;
	}

	public void setApplyCrewNo(int applyCrewNo) {
		this.applyCrewNo = applyCrewNo;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public void setSchedulesName(String schedulesName) {
		this.schedulesName = schedulesName;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}

	public void setAcceptance(char acceptance) {
		this.acceptance = acceptance;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

}
