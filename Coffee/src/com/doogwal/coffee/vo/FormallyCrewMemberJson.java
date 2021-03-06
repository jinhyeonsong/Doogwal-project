package com.doogwal.coffee.vo;

//정식 크루원들을 받아오는 편의를 위한 json 클래스
public class FormallyCrewMemberJson {
	private int crewMemberNo,reportNum;
	private String name, profileImg;
	private char rank;
	
	public FormallyCrewMemberJson() {
		// TODO Auto-generated constructor stub
	}

	public int getReportNum() {
		return reportNum;
	}

	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}

	public String getName() {
		return name;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public char getRank() {
		return rank;
	}

	public int getCrewMemberNo() {
		return crewMemberNo;
	}

	public void setCrewMemberNo(int crewMemberNo) {
		this.crewMemberNo = crewMemberNo;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public void setRank(char rank) {
		this.rank = rank;
	}
	
	
}
