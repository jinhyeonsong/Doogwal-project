package com.doogwal.coffee.vo;

import java.sql.Date;
import java.sql.Timestamp;

//밋팅 대기자들에 써넣을 json 작성 편의를 위한 클래스
public class WaitingMeetingCrewsJson {
	private int no, meetingNo, applyCrewNo;
	private String introduce, crewCoverImg, crewName, meetingName;
	private Date startDate;
	private Timestamp regdate;
	
	public WaitingMeetingCrewsJson() {
		// TODO Auto-generated constructor stub
	}

	public WaitingMeetingCrewsJson(int no, int meetingNo, int applyCrewNo, String introduce, String crewCoverImg,
			String crewName, String meetingName, Date startDate, Timestamp regdate) {
		this.no = no;
		this.meetingNo = meetingNo;
		this.applyCrewNo = applyCrewNo;
		this.introduce = introduce;
		this.crewCoverImg = crewCoverImg;
		this.crewName = crewName;
		this.meetingName = meetingName;
		this.startDate = startDate;
		this.regdate = regdate;
	}

	public int getNo() {
		return no;
	}

	public int getMeetingNo() {
		return meetingNo;
	}

	public int getApplyCrewNo() {
		return applyCrewNo;
	}

	public String getIntroduce() {
		return introduce;
	}

	public String getCrewCoverImg() {
		return crewCoverImg;
	}

	public String getCrewName() {
		return crewName;
	}

	public String getMeetingName() {
		return meetingName;
	}

	public Date getStartDate() {
		return startDate;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

}
