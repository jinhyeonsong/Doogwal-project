package com.doogwal.coffee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.CrewApp;
import com.doogwal.coffee.vo.CrewMember;
import com.doogwal.coffee.vo.User;

public class CrewAppsDAO {
	
	// 주성호 start -----------------------------
	//2021 01 25 start

	public static int insertCrewApp(CrewApp crewApp) {
		int result = 0;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			result = session.insert("crewApps.insertCrewApp",crewApp);
			return crewApp.getNo();
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return -1;
	}
	//2021 01 25 end
	// 주성호 end-------------------------------
	
	
	//박형우 start -----------------------------------------------------------------------
	//20210114 start
		//가입 대기자들의 유저 정보 가져오는
		public static List<User> selectRegisteWatingUsers(int no){
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectList("crewApps.selectRegisteWatingUsers", no);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return null;
		}
		
		//가입 대기자들 답변들 가져오는
		public static List<String> selectUserAns(Map<String, Integer> map){
			
			SqlSession session = null;
				
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectList("crewApps.selectUserAns", map);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return null;
		}
		//가입 대기자들 자기 소개 가져오는
		public static String selectIntro(int no){
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectOne("crewApps.selectIntro", no);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return null;
		}
		
		//크루의 가입질문 가져오는
		public static List<String> selectQuest(int no){
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectList("crewApps.selectQuest", no);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return null;
		}
	//20210114 end
	//20210115 start
		
		//크루 정식멤버로 승인하는
		public static int updateRegularMember(Map<String, Integer> map){
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.update("crewApps.updateRegularMember", map);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return -1;
		}
		
		//크루 가입신청을 거절하는
		public static int updateRejectMember(Map<String, Integer> map) {
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
			
				return session.update("crewApps.updateRejectMember", map);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}//try~catch~finally end 
			return -1;
		}
		
		//20210115 end
		//20210125 start
		
		//크루멤버 탈퇴시키기
		public static int updateKickMember(CrewMember crewMember) {
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
				return session.update("crewApps.updateKickMember", crewMember);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}//try~catch~finally end 
			return -1;
		}

		//20210125 end

	//박형우 end -----------------------------------------------------------------------

	
	

	
}
