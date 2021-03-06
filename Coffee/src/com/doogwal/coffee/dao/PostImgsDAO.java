package com.doogwal.coffee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.PostImg;

public class PostImgsDAO {
	
	// 주성호 start 2021 01 25
	// 하나의 글에 대해 이미지들 불러오기
	public static List<PostImg> selectImageList(int postNo) {

		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectList("postImgs.selectImageList",postNo);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}//try~catch~finally end
		
		return null;
	}
	// 이미지 삽입
	public static int insertPostImages(PostImg postImage) {

		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.insert("postImgs.insertPostImages",postImage);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}//try~catch~finally end
		return -1;
	}
	// 주성호 end 2021 01 25
	// 좋아요 삭제
	public static int deletePostImages(int postNo) {
		int cnt = -1;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			return session.delete("postImgs.deletePostImages",postNo);
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return -1;
	}
	// 주성호 2021 02 02 end
	
}
