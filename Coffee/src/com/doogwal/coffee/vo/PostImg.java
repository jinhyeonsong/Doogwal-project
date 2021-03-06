package com.doogwal.coffee.vo;

public class PostImg {

	private int no,postNo;
	private String image;
	
	public PostImg() {
		// TODO Auto-generated constructor stub
	}

	public PostImg(int postNo, String image) {
		this.postNo = postNo;
		this.image = image;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
	
}
