package com.doogwal.coffee.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class Preparation {
	private int no, scheduleNo;
	private String preparation;
	private Timestamp regdate;
	
	public Preparation() {
	}
	public Preparation(int no, int scheduleNo, String prepation) {
		this.no = no;
		this.scheduleNo = scheduleNo;
		this.preparation = preparation;
	}
	public Preparation(int no, int scheduleNo, String preparation, Timestamp regdate) {
		super();
		this.no = no;
		this.scheduleNo = scheduleNo;
		this.preparation = preparation;
		this.regdate = regdate;
	}
	public Preparation(int scheduleNo, String preparation) {
		super();
		this.scheduleNo = scheduleNo;
		this.preparation = preparation;
	}
	
	public Preparation(String preparation) {
		super();
		this.preparation = preparation;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getScheduleNo() {
		return scheduleNo;
	}
	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}
	public String getPreparation() {
		return preparation;
	}
	public void setPreparation(String preparation) {
		this.preparation =preparation;
	}
	
}
