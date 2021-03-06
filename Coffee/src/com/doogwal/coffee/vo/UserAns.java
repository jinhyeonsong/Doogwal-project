package com.doogwal.coffee.vo;

import java.sql.Timestamp;

//객관식 답변 MtpAns객체로 바꾸는거 기억!
public class UserAns {
	private int no,qNo,crewApplyNo,mtpChoiceNo;
	private Timestamp regdate;
	
	public UserAns() {
		// TODO Auto-generated constructor stub
	}

	public UserAns(int qNo, int crewApplyNo, int mtpChoiceNo) {
		this.qNo = qNo;
		this.crewApplyNo = crewApplyNo;
		this.mtpChoiceNo = mtpChoiceNo;
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

	public int getCrewApplyNo() {
		return crewApplyNo;
	}

	public void setCrewApplyNo(int crewApplyNo) {
		this.crewApplyNo = crewApplyNo;
	}

	public int getMtpChoiceNo() {
		return mtpChoiceNo;
	}

	public void setMtpChoiceNo(int mtpChoiceNo) {
		this.mtpChoiceNo = mtpChoiceNo;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	
}
