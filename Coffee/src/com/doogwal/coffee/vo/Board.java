package com.doogwal.coffee.vo;

import java.sql.Timestamp;

public class Board {

	private int no,crewNo;
	private String name;
	private Timestamp regdate;
	
	public Board() {
		// TODO Auto-generated constructor stub
	}
	public Board(int no, int crewNo, String name) {
		this.no = no;
		this.crewNo = crewNo;
		this.name = name;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
