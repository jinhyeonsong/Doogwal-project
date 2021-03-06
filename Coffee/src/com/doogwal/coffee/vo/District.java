package com.doogwal.coffee.vo;

public class District {
	private int no,priorNo;
	private String name;
	public District() {
		
	}
	
	public District(int no, int priorNo, String name) {
		this.no = no;
		this.priorNo = priorNo;
		this.name = name;
	}
	public District(int no) {
		this.no = no;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getPriorNo() {
		return priorNo;
	}
	public void setPriorNo(int priorNo) {
		this.priorNo = priorNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}