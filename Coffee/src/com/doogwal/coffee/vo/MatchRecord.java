package com.doogwal.coffee.vo;

public class MatchRecord {
	
	private int win, draw, lose;
	
	public MatchRecord() {
		// TODO Auto-generated constructor stub
	}
	
	public int getTotal() {
		return win+lose+draw;
	}

	public int getWin() {
		return win;
	}

	public void setWin(int win) {
		this.win = win;
	}

	public int getDraw() {
		return draw;
	}

	public void setDraw(int draw) {
		this.draw = draw;
	}

	public int getLose() {
		return lose;
	}

	public void setLose(int lose) {
		this.lose = lose;
	}
	
	
	
}
