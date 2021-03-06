package com.doogwal.coffee.vo;

import java.sql.Timestamp;
import java.util.List;

public class CrewMemberPostReport {

	private String name,profileImg;
	
	List<Report> reports;
	List<Post> posts;
	public CrewMemberPostReport() {
		// TODO Auto-generated constructor stub
	}
	
	public CrewMemberPostReport(String name, String profileImg, List<Report> reports, List<Post> posts) {
		this.name = name;
		this.profileImg = profileImg;
		this.reports = reports;
		this.posts = posts;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public List<Report> getReports() {
		return reports;
	}
	public void setReports(List<Report> reports) {
		this.reports = reports;
	}
	public List<Post> getPosts() {
		return posts;
	}
	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}
	
	
	
}
