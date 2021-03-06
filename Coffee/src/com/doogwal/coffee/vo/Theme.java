package com.doogwal.coffee.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class Theme {
	private int no;
	private String theme;
	private Timestamp regdate;

	public Theme() {
	}
	
	public Theme(int no, String theme) {
		this.no = no;
		this.theme = theme;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

}
