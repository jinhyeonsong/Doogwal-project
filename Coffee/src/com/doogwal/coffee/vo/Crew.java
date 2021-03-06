package com.doogwal.coffee.vo;

import java.sql.Timestamp;

public class Crew {
	
	//minAge:1980 << maxAge:1995;
	private int no,minAge,maxAge,maxPop,curPop,categoryNo,point;
	private float avgAge,genderRate;
	private String name,coverImg,intro;
	private Timestamp regdate;
	
	public Crew() {
		// TODO Auto-generated constructor stub
	}

	public Crew(int minAge, int maxAge, int maxPop, int curPop, int categoryNo, int point, float avgAge,
			float genderRate, String name, String coverImg, String intro) {
		this.minAge = minAge;
		this.maxAge = maxAge;
		this.maxPop = maxPop;
		this.curPop = curPop;
		this.categoryNo = categoryNo;
		this.point = point;
		this.avgAge = avgAge;
		this.genderRate = genderRate;
		this.name = name;
		this.coverImg = coverImg;
		this.intro = intro;
	}
	
	public Crew(int curPop, int categoryNo, float avgAge, float genderRate, String name, String coverImg,
			String intro) {
		super();
		this.curPop = curPop;
		this.categoryNo = categoryNo;
		this.avgAge = avgAge;
		this.genderRate = genderRate;
		this.name = name;
		this.coverImg = coverImg;
		this.intro = intro;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getMinAge() {
		return minAge;
	}

	public void setMinAge(int minAge) {
		this.minAge = minAge;
	}

	public int getMaxAge() {
		return maxAge;
	}

	public void setMaxAge(int maxAge) {
		this.maxAge = maxAge;
	}

	public int getMaxPop() {
		return maxPop;
	}

	public void setMaxPop(int maxPop) {
		this.maxPop = maxPop;
	}

	public int getCurPop() {
		return curPop;
	}

	public void setCurPop(int curPop) {
		this.curPop = curPop;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public float getAvgAge() {
		return avgAge;
	}

	public void setAvgAge(float avgAge) {
		this.avgAge = avgAge;
	}

	public float getGenderRate() {
		return genderRate;
	}

	public void setGenderRate(float genderRate) {
		this.genderRate = genderRate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCoverImg() {
		return coverImg;
	}

	public void setCoverImg(String coverImg) {
		this.coverImg = coverImg;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}
	
	
	
	
}
