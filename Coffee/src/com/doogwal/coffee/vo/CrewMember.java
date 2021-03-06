package com.doogwal.coffee.vo;

import java.sql.Timestamp;

public class CrewMember {
	
	private int no,crewNo,userNo,reportNum;
	private char role,type;
	private String profileImg,introduction;
	private Timestamp regdate;
	
	private String name,coverImg;
	
//	NO	CREWNO	USERNO	ROLE	REPORTNUM	PROFILEIMG	INTRODUCTION	TYPE	REGDATE	COVERIMG	
//	1000	1000	1000	C	0	profile/1.jpg	<NULL>	A	2021-01-04 20:10:21.0	운동스포츠/2.jpg	

	
	public CrewMember() {
		// TODO Auto-generated constructor stub
	}

	public CrewMember(int crewNo, int userNo, int reportNum, char role, char type, String profileImg,
			String introduction) {
		this.crewNo = crewNo;
		this.userNo = userNo;
		this.reportNum = reportNum;
		this.role = role;
		this.type = type;
		this.profileImg = profileImg;
		this.introduction = introduction;
	}
	public CrewMember(int no, int crewNo, int userNo, int reportNum, char role, char type, String profileImg,
			String introduction) {
		this.no = no;
		this.crewNo = crewNo;
		this.userNo = userNo;
		this.reportNum = reportNum;
		this.role = role;
		this.type = type;
		this.profileImg = profileImg;
		this.introduction = introduction;
	}
	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCoverImg() {
		return coverImg;
	}

	public void setCoverImg(String coverImg) {
		this.coverImg = coverImg;
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

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getReportNum() {
		return reportNum;
	}

	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}

	public char getRole() {
		return role;
	}

	public void setRole(char role) {
		this.role = role;
	}

	public char getType() {
		return type;
	}

	public void setType(char type) {
		this.type = type;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	

	
}
