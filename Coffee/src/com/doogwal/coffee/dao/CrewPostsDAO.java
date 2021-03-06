package com.doogwal.coffee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.CrewPost;
import com.doogwal.coffee.vo.PageVO;
import com.doogwal.coffee.vo.Post;

public class CrewPostsDAO {
	
	// 주성호 start 2021 01 25
	// 크루 디테일 글 페이징 처리
	public static List<CrewPost> selectPostDetailList(Map<String, Object> pageVO) {

		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectList("posts.selectPostDetailList",pageVO);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}//try~catch~finally end
		
		return null;
	}
	// 크루 디테일 글 상세 불러오기
	public static CrewPost selectPostDetailOne(int no) {
		
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			return session.selectOne("posts.selectPostDetailOne",no);
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return null;
	}//selectCheckNickname() end
	
	// 주성호 end 2021 01 25

}
