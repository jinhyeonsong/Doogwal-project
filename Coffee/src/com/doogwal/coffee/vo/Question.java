package com.doogwal.coffee.vo;

import java.sql.Timestamp;
import java.util.ArrayList;

public class Question {

	private int no,crewNo;
	private char type;
	private String quest;
	private Timestamp regdate;
	
	private ArrayList<MtpQuest> list = new ArrayList<>();
	
	public Question() {
		// TODO Auto-generated constructor stub
	}

	public Question(int crewNo, char type, String quest) {
		this.crewNo = crewNo;
		this.type = type;
		this.quest = quest;
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

	public char getType() {
		return type;
	}

	public void setType(char type) {
		this.type = type;
	}

	public String getQuest() {
		return quest;
	}

	public void setQuest(String quest) {
		this.quest = quest;
	}
	
}
