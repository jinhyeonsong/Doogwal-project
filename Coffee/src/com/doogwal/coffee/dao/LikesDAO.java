package com.doogwal.coffee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.Crew;
import com.doogwal.coffee.vo.Like;

public class LikesDAO {

	// 주성호 2021 01 25 start
	// 글 하나의 좋아요 리스트들 불러오기
	public static List<Like> selectLikesList(Map<String,Object> map) {

		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectList("likes.selectLikesList",map);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}//try~catch~finally end
		
		return null;
	}
	
	// 좋아요 클릭
	public static int pushLike(Map<String,Object> map) {
		int cnt = 0;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			cnt = session.insert("likes.pushLike",map);
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return cnt;
	}
	
	// 좋아요 취소 클릭
	public static int unPushLike(Map<String,Object> map) {
		int cnt = 0;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			cnt = session.insert("likes.unPushLike",map);
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return cnt;
	}
	
	// 좋아요 누른사람 보기
	public static int selectWhetherLike(Map<String,Object> map) {
		int cnt = -1;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			return session.selectOne("likes.selectWhetherLike",map);
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return -1;
	}
	// 주성호 2021 01 25 start
	// 좋아요 삭제
	public static int deleteLikes(int postNo) {
		int cnt = -1;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			return session.delete("likes.deleteLikes",postNo);
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return -1;
	}
	// 주성호 2021 02 02 end
}
