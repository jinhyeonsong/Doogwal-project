package com.doogwal.coffee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.User;


public class UsersDAO {
	/* 2021 01 12 주성호 header jsp start*/
	//로그인시 로그인할 수 있는 유저가 맞는지 확인하는
	public static User selectLogin(User user) {
		
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			return session.selectOne("users.selectLogin",user);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return null;
	}
	/* 2021 01 12 주성호 header jsp end*/
	
	/* 2021 01 12 주성호 crew_create start*/
	public static User selectUserOne(int no) {
		
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			return session.selectOne("users.selectUserOne",no);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return null;
	}
	/* 2021 01 12 주성호 crew_create end*/
	//--------------------------------------------------------------------
	
	//박형우 start -----------------------------------------------------------------------
	//20210114 start
		public static User selecAttendanceUser(int no) {
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectOne("users.selecAttendanceUser",no);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return null;
		}
	//20210114 end
	//박형우 end -----------------------------------------------------------------------
		
	//정진하 20210116 2300 회원가입 인서트 추가
		public static int insert(User user) {
			int result = 0;
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				result = session.insert("users.insert",user);
			}catch(Exception e) {
				e.printStackTrace();
			} finally {
				session.close();
			}//try~catch~finally end
			
			return result;
	}

	//2021 01 14 0811 
	//정진하 마이페이지 주소 업데이트를 위해 추가함
	   	 public static int updateUserAddress(User user) {
	   		 int result = 0;
	   		 SqlSession session = null;
	   		 try {
	   			 session = SqlSessionUtil.getSession();
	   			 result = session.update("users.updateUserAddress",user);
	   		 } catch (Exception e) {
	   			 e.printStackTrace();
	   		 } finally {
	   			 session.close();
	   		 }//try~catch~finally end
	   		 
	   		 return result;
	   	 }//update() end
	   	 
	 //2021 01 14 1931 
	 //정진하 마이페이지 수신상태 업데이트를 위해 추가함
	 public static int updateUserSmsReception(User user) {
		 int result = 0;
		 SqlSession session = null;
		 try {
			 session = SqlSessionUtil.getSession();
			 result = session.update("users.updateUserSmsReception",user);
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
			 session.close();
		 }//try~catch~finally end
		 
		 return result;
	 }//update() end
	   			 
	public static int updateUserEmailReception(User user) {
		 int result = 0;
		 SqlSession session = null;
		 try {
			 session = SqlSessionUtil.getSession();
			 result = session.update("users.updateUserEmailReception",user);
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
			 session.close();
		 }//try~catch~finally end
		 
		 return result;
	 }//update() end
	
	// end --------------------------------------------------------------------------------------------------

}

