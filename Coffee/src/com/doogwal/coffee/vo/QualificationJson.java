package com.doogwal.coffee.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;

//20210114 박형우
//가입 신청 기다리는 유저들의 json데이터 작성 편의를 위한 클래스
public class QualificationJson{
	private String name, img, address, birthDate, intro, endDate;
	private List<String> questions, answers;
	private int userNo, crewNo;
	
	//Date타입들 때문에 생성
	private Calendar bCal, eCal;
	
	public QualificationJson(String name, String img, String address, Date birthDate, String intro, Timestamp endDate, List<String> questions, List<String> answers, int userNo, int crewNo) {
		this.name = name;
		this.img = img;
		this.address = address;
		this.intro = intro;
		this.questions = questions;
		this.answers = answers;
		this.userNo = userNo;
		this.crewNo = crewNo;
		
		this.bCal = Calendar.getInstance();
		this.bCal.setTime(birthDate);
		this.eCal = Calendar.getInstance();
		this.eCal.setTime(endDate);
		this.eCal.add(Calendar.DATE, 3);
	}
	
	public String getImg() {
		return img;
	}
	
	public String getName() {
		return name;
	}

	public String getAddress() {
		return address;
	}

	public String getBirthDate() {
		String result = bCal.get(Calendar.YEAR)+"/"+(bCal.get(Calendar.MONTH)+1)+"/"+bCal.get(Calendar.DATE);
		return result;
	}

	public String getIntro() {
		return intro;
	}

	public String getEndDate() {
		String result = eCal.get(Calendar.YEAR)+"/"+(eCal.get(Calendar.MONTH)+1)+"/"+eCal.get(Calendar.DATE);
		return result;
	}

	public List<String> getQuestions() {
		return questions;
	}
	
	public List<String> getAnswers() {
		return answers;
	}

	public int getUserNo() {
		return userNo;
	}

	public int getCrewNo() {
		return crewNo;
	}

}
