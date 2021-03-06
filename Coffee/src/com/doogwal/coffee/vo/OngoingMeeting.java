package com.doogwal.coffee.vo;

//20210116 박형우
//진행중인 밋팅 json데이터 작성 편의를 위한 클래스
public class OngoingMeeting {
	private int seq, crewNo, meetingNo;
	private String crewName, meetingName, img;
	
	public OngoingMeeting() {
		// TODO Auto-generated constructor stub
	}

	public int getSeq() {
		return seq;
	}

	public String getCrewName() {
		return crewName;
	}

	public String getMeetingName() {
		return meetingName;
	}

	public String getImg() {
		return img;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getCrewNo() {
		return crewNo;
	}

	public int getMeetingNo() {
		return meetingNo;
	}

	public void setCrewNo(int crewNo) {
		this.crewNo = crewNo;
	}

	public void setMeetingNo(int meetingNo) {
		this.meetingNo = meetingNo;
	}

	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}

	public void setMeetingName(String meetingName) {
		this.meetingName = meetingName;
	}

	public void setImg(String img) {
		this.img = img;
	}
	
	
}
