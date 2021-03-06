package com.doogwal.coffee.vo;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class CrewPost {
	
	private int no,memberNo,likeCnt,boardNo,replyCnt;
	private char imageApplicable;
	private String contents,texts;
	private Timestamp regdate;
	

	private List<Reply> replies;
	private List<Like> likeMembers;
	private List<PostImg> postImgs;
	private UserMember userMember;

	private int myLikeCount;
	
	
	public int getMyLikeCount() {
		return myLikeCount;
	}

	public void setMyLikeCount(int myLikeCount) {
		this.myLikeCount = myLikeCount;
	}

	public int getReplyCnt() {
		return replyCnt;
	}
	
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}
	
	public UserMember getUserMember() {
		return userMember;
	}

	public void setUserMember(UserMember userMember) {
		this.userMember = userMember;
	}

	public CrewPost() {
		// TODO Auto-generated constructor stub
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public char getImageApplicable() {
		return imageApplicable;
	}

	public void setImageApplicable(char imageApplicable) {
		this.imageApplicable = imageApplicable;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public List<Reply> getReplies() {
		return replies;
	}

	public void setReplies(List<Reply> replies) {
		this.replies = replies;
	}

	public List<Like> getLikeMembers() {
		return likeMembers;
	}

	public void setLikeMembers(List<Like> likeMembers) {
		this.likeMembers = likeMembers;
	}

	public List<PostImg> getPostImgs() {
		return postImgs;
	}

	public void setPostImgs(List<PostImg> postImgs) {
		this.postImgs = postImgs;
	}

	public String getTexts() {
		return texts;
	}

	public void setTexts(String texts) {
		this.texts = texts;
	}
	
	
	

}
