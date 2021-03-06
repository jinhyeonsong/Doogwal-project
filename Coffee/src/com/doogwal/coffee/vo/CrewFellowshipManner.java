package com.doogwal.coffee.vo;

import java.sql.Timestamp;

public class CrewFellowshipManner {

	//fellowship.xml과 fellowshipsDAO
	// crew
	private String crewName,crewImg;
	
	// fellowship
	private String review;
	
	// manner
	private Timestamp regdate;
	private char manner,competence,harmony,eagerness,unity;
	
	public CrewFellowshipManner() {
		// TODO Auto-generated constructor stub
	}

	public String getCrewName() {
		return crewName;
	}

	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}

	public String getCrewImg() {
		return crewImg;
	}

	public void setCrewImg(String crewImg) {
		this.crewImg = crewImg;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public char getManner() {
		return manner;
	}

	public void setManner(char manner) {
		this.manner = manner;
	}

	public char getCompetence() {
		return competence;
	}

	public void setCompetence(char competence) {
		this.competence = competence;
	}

	public char getHarmony() {
		return harmony;
	}

	public void setHarmony(char harmony) {
		this.harmony = harmony;
	}

	public char getEagerness() {
		return eagerness;
	}

	public void setEagerness(char eagerness) {
		this.eagerness = eagerness;
	}

	public char getUnity() {
		return unity;
	}

	public void setUnity(char unity) {
		this.unity = unity;
	}
}
