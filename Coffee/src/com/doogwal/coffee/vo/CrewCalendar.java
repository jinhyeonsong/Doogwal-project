package com.doogwal.coffee.vo;


import java.sql.Timestamp;
import java.util.Calendar;

import com.fasterxml.jackson.annotation.JsonProperty;

public class CrewCalendar {
	//정진하 20210121 1031 크루 디테일 일정 게시판용으로 만듦
	
	//schedules table
	private int no,crewNo;//여기서 no는 스케줄 번호
	private char type;
	private Timestamp startDate;
	private Timestamp regdate;
	
	private String name;//일정 이름
	
	//시작날짜 얻기용
	private Calendar startCalendar;
	private String startDateStr;
	
	// meetings table
	private int point;//밋팅에 걸린 포인트
	
	//meet_apps table
	private int applyCrewNo;//밋팅 신청 크루 번호
	private char acceptance;//수락여부. A(확정)인 것만 캘린더에 가져오면 될 것.
	
	//crew //상대크루 정보 가져오기 용
	private String applyCrewName, applyCrewImg;
	
	//참여하는 사람, 참여 안하는 사람 수 얻기
	private int participantsTotal, nonParticipantsTotal;
	
	public CrewCalendar() {
		startCalendar = Calendar.getInstance();
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
	
	//정진하 2021 01 23 1703 풀캘린더에 일정 들어가게 하기 위해 작성함 
	@JsonProperty("start")
	public Timestamp getStartDateForFullCalendar() {
		return startDate;
	}
	
	
	public Timestamp getStartDate() {
		return startDate;
	}

	public void setStartDate(Timestamp startDate) {
		startCalendar.setTime(startDate);
		this.startDate = startDate;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	//2021 0123 정진하 풀캘린더에 addSource 하기 위해  작성함.(풀캘린더는 이름 맞춰줘야 함)
	@JsonProperty("title")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getApplyCrewNo() {
		return applyCrewNo;
	}

	public void setApplyCrewNo(int applyCrewNo) {
		this.applyCrewNo = applyCrewNo;
	}

	public char getAcceptance() {
		return acceptance;
	}

	public void setAcceptance(char acceptance) {
		this.acceptance = acceptance;
	}

	
	
	public String getApplyCrewName() {
		return applyCrewName;
	}


	public void setApplyCrewName(String applyCrewName) {
		this.applyCrewName = applyCrewName;
	}


	public String getApplyCrewImg() {
		return applyCrewImg;
	}


	public void setApplyCrewImg(String applyCrewImg) {
		this.applyCrewImg = applyCrewImg;
	}


	public int getParticipantsTotal() {
		return participantsTotal;
	}

	public void setParticipantsTotal(int participantsTotal) {
		this.participantsTotal = participantsTotal;
	}

	public int getNonParticipantsTotal() {
		return nonParticipantsTotal;
	}

	public void setNonParticipantsTotal(int nonParticipantsTotal) {
		this.nonParticipantsTotal = nonParticipantsTotal;
	}
	
	public int getStartYear() {
		return startCalendar.get(Calendar.YEAR);
	}
	
	public int getStartMonth() {
		return startCalendar.get(Calendar.MONTH)+1;
		
	}
	
	public int getStartDay() {
		return startCalendar.get(Calendar.DATE);
	}
	
	public int getStartHour() {
		return startCalendar.get(Calendar.HOUR_OF_DAY);
	}
	
	public int getStartMin() {
		return startCalendar.get(Calendar.MINUTE);
	}


	public String getStartDateStr() {
		return getStartYear()+"년 "+ getStartMonth() +"월 "+
				getStartDay()+"일 " +getStartHour()+"시 "+getStartMin()+"분 ";
	}


	public void setStartDateStr(String startDateStr) {
		this.startDateStr = startDateStr; 
	}
	
	


}
	

