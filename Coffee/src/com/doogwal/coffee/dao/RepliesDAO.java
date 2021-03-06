package com.doogwal.coffee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.Reply;

public class RepliesDAO {
	
	
	/*
	 * 	2021 01 25 주성호 start
	 * */
	//- ------------------------------------------------------------------
	// 댓글 리스트 불러오기
	public static List<Reply> selectReplyList(Map<String,Object> map) {

		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectList("replies.selectReplyList",map);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}//try~catch~finally end
		
		return null;
	}
	// 댓글 삽입
	public static int insertReply(Reply reply) {
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.insert("replies.insertReply",reply);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}//try~catch~finally end
		
		return -1;
	}
	/*
	 * 	2021 01 25 주성호 end
	 * */
	// 댓글 삭제 
	public static int deleteReplies(int postNo) {
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.delete("replies.deleteReplies",postNo);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}//try~catch~finally end
		
		return -1;
	}
	//- ------------------------------------------------------------------
	 
	
}
