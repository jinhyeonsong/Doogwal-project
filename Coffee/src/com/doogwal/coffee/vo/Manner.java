package com.doogwal.coffee.vo;

public class Manner {

	private int no,raterNo,rateeNo,meetingNo;
	private char manner,competence,harmony,eagerness,unity;
	
	public Manner() {
		// TODO Auto-generated constructor stub
	}
	

	public Manner(int no, int raterNo, int rateeNo, int meetingNo, char manner, char competence, char harmony,
			char eagerness, char unity) {
		this.no = no;
		this.raterNo = raterNo;
		this.rateeNo = rateeNo;
		this.meetingNo = meetingNo;
		this.manner = manner;
		this.competence = competence;
		this.harmony = harmony;
		this.eagerness = eagerness;
		this.unity = unity;
	}
	public Manner(int raterNo, int rateeNo, int meetingNo, char manner, char competence, char harmony,
			char eagerness, char unity) {
		this.raterNo = raterNo;
		this.rateeNo = rateeNo;
		this.meetingNo = meetingNo;
		this.manner = manner;
		this.competence = competence;
		this.harmony = harmony;
		this.eagerness = eagerness;
		this.unity = unity;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getRaterNo() {
		return raterNo;
	}

	public void setRaterNo(int raterNo) {
		this.raterNo = raterNo;
	}

	public int getRateeNo() {
		return rateeNo;
	}

	public void setRateeNo(int rateeNo) {
		this.rateeNo = rateeNo;
	}

	public int getMeetingNo() {
		return meetingNo;
	}

	public void setMeetingNo(int meetingNo) {
		this.meetingNo = meetingNo;
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
