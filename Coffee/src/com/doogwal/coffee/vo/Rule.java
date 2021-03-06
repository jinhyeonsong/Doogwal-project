package com.doogwal.coffee.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class Rule {
	private int no,meetingNo;
	private String rule;
	private Timestamp regdate;
	
	public Rule() {
	}
	
	public Rule(int no, int meetingNo, String rule) {
		this.no = no;
		this.meetingNo = meetingNo;
		this.rule = rule;
	}


	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getMeetingNo() {
		return meetingNo;
	}
	public void setMeetingNo(int meetingNo) {
		this.meetingNo = meetingNo;
	}
	public String getRule() {
		return rule;
	}
	public void setRule(String rule) {
		this.rule = rule;
	}
	
}
