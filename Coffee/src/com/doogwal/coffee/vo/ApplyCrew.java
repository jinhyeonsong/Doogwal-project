package com.doogwal.coffee.vo;

public class ApplyCrew {
	private int applyCrewNo;
	private String introduce,name,coverImg,type;
	private char acceptance;
	
	public ApplyCrew() {
		// TODO Auto-generated constructor stub
	}
	
	public ApplyCrew(int applyCrewNo, String introduce, String name, String coverImg, String type, char acceptance) {
		super();
		this.applyCrewNo = applyCrewNo;
		this.introduce = introduce;
		this.name = name;
		this.coverImg = coverImg;
		this.type = type;
		this.acceptance = acceptance;
	}

	public int getApplyCrewNo() {
		return applyCrewNo;
	}

	public void setApplyCrewNo(int applyCrewNo) {
		this.applyCrewNo = applyCrewNo;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public char getAcceptance() {
		return acceptance;
	}

	public void setAcceptance(char acceptance) {
		this.acceptance = acceptance;
	}


	
}
