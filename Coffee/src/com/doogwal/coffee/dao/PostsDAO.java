package com.doogwal.coffee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.Post;

public class PostsDAO {
	
	//박형우 start -----------------------------------------------------------------------
	//20210114 start
		
		//상위 고정 게시글을 가져오는
		public static List<Post> selectTopContents(int no) {
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectList("posts.selectTopContents",no);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return null;
		}
		
	//20210114 end
	//박형우 end -----------------------------------------------------------------------
	
	// 주성호 start 2021 01 25 -------------------------
	// 글 상세 불러오기
	public static Post selectPostDetailOne(int no) {
		Post post;
		
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
	
	
	// 글에 좋아요 수 증가
	public static int postPushLike(int no) {
		int cnt = 0;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			cnt = session.update("posts.postPushLike",no);
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return cnt;
	}
	
	// 글 좋아요 수 감소
	public static int postUnPushLike(int no) {
		int cnt = 0;
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			cnt = session.update("posts.postUnPushLike",no);
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return cnt;
	}

	// 글 생성
	public static int insertPost(Post post) {
		int cnt = 0;
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			cnt = session.insert("posts.insertPost",post);
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return cnt;
	}
	
	// 글 지우기
	public static int deletePost(int no) {
		int cnt = 0;
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			cnt = session.delete("posts.deletePost",no);
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		return cnt;
	}
	
	// 글 상세
	public static int selectpostNo() {
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectOne("posts.selectpostNo");
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		return -1;
	}
	
	// 글 수정
	public static Post selectPostUpdateOne(int no) {
		Post post;
		
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			return session.selectOne("posts.selectPostUpdateOne",no);
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return null;
	}//selectCheckNickname() end
	// 주성호 end 2021 01 25 -------------------------
	// 주성호 end 2021 02 01 -------------------------
	public static List<Post> selectReportPost(int crewMemberNo) {
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectList("posts.selectReportPost",crewMemberNo);
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return null;
	}//selectCheckNickname() end
}

