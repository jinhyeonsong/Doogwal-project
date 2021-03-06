package com.doogwal.coffee.vo;

import java.sql.Timestamp;

public class MtpQuest {
	private int no,qNo;
	private String mtpChoice;
	private Timestamp regdate;

	public MtpQuest() {
		// TODO Auto-generated constructor stub
	}
	
	

	public MtpQuest(int no, int qNo, String mtpChoice) {
		this.no = no;
		this.qNo = qNo;
		this.mtpChoice = mtpChoice;
	}



	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getqNo() {
		return qNo;
	}

	public void setqNo(int qNo) {
		this.qNo = qNo;
	}

	public String getMtpChoice() {
		return mtpChoice;
	}

	public void setMtpChoice(String mtpChoice) {
		this.mtpChoice = mtpChoice;
	}
	
	
}
