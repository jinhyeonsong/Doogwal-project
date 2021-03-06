package com.doogwal.coffee.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class Gathering {

	
	// schedules table
	private int no,districtNo,crewNo;	
	private char type;
	private Timestamp startDate,endDate;
	private String name,address,description;
	private double lat,lng;
	private Timestamp regdate;
	
	// gatherings table
	private int fee;// 모임이면 값이 있으나 밋팅이면 0
	
	//정진하 20210117 2157 메인에서 모임 크루 이름, 크루 커버 가져오기 위해 추가함.
	private String crewName, crewCoverImg;

	
	public Gathering() {
		// TODO Auto-generated constructor stub
	}
	public Gathering(int no, int fee) {
		super();
		this.no = no;
		this.fee = fee;
	}
	public Gathering(int no, int districtNo, int crewNo, char type, Timestamp startDate, Timestamp endDate, String name,
			String address, String description, double lat, double lng, int fee) {
		this.no = no;
		this.districtNo = districtNo;
		this.crewNo = crewNo;
		this.type = type;
		this.startDate = startDate;
		this.endDate = endDate;
		this.name = name;
		this.address = address;
		this.description = description;
		this.lat = lat;
		this.lng = lng;
		this.fee = fee;
	}
	public Gathering(int districtNo, int crewNo, char type, Timestamp startDate, Timestamp endDate, String name, String address,
			String description, double lat, double lng) {
		super();
		this.districtNo = districtNo;
		this.crewNo = crewNo;
		this.type = type;
		this.startDate = startDate;
		this.endDate = endDate;
		this.name = name;
		this.address = address;
		this.description = description;
		this.lat = lat;
		this.lng = lng;
	}



	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public int getDistrictNo() {
		return districtNo;
	}


	public void setDistrictNo(int districtNo) {
		this.districtNo = districtNo;
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


	public Timestamp getStartDate() {
		return startDate;
	}


	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}


	public Timestamp getEndDate() {
		return endDate;
	}


	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public double getLat() {
		return lat;
	}


	public void setLat(double lat) {
		this.lat = lat;
	}


	public double getLng() {
		return lng;
	}


	public void setLng(double lng) {
		this.lng = lng;
	}


	public int getFee() {
		return fee;
	}


	public void setFee(int fee) {
		this.fee = fee;
	}
	
	//정진하 20210117 2203 메인에서 모임 크루 이름, 크루 커버 가져오기 위해 추가함.
	public String getCrewName() {
			return crewName;
	}

	public void setCrewName(String crewName) {
			this.crewName = crewName;
	}

	public String getCrewCoverImg() {
			return crewCoverImg;
	}

	public void setCrewCoverImg(String crewCoverImg) {
			this.crewCoverImg = crewCoverImg;
	}
	
	
		
}
