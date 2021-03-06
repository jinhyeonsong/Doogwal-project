package com.doogwal.coffee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.Attendance;
import com.doogwal.coffee.vo.CrewMember;

public class AttendancesDAO {
	//박형우 start -----------------------------------------------------------------------
	//20210114 start
		// 참석이 Y인 attendance를 가져오는
		public static Attendance selectYAttendance(int no) {
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectOne("attendances.selectYAttendance",no);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return null;
		}
		
		// 참석자의 수를 가져오는 
		public static int selectYAttendanceCount(int no) {
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectOne("attendances.selectYAttendanceCount",no);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return 0;
		}
		
		// 참석자들의 user 정보를 가져오는
		public static List<CrewMember> selectYAttendanceList(int no) {
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectList("attendances.selectYAttendanceList",no);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return null;
		}
	//20210114 end
	//박형우 end -----------------------------------------------------------------------
		
	//2021 01 21 정진하 일정캘린더에서 참가자 수 뽑아오기 위함
	public static int selectTotalParticipants(int scheduleNo) {
	
	SqlSession session = null;
	
	try {
		session = com.doogwal.coffee.util.SqlSessionUtil.getSession();
		return session.selectOne("attendances.selectTotalParticipants",scheduleNo);
		
	} catch (Exception e) {
		e.printStackTrace();
		
	} finally {
		if(session!=null) session.close();
		
	}//try~catch~finally end 
	
	return 0;
}
	//2021 01 21 정진하 일정캘린더에서 불참가자 수 뽑아오기 위함
	public static int selectTotalNonParticipants(int scheduleNo) {
		
		SqlSession session = null;
		
		try {
			session = com.doogwal.coffee.util.SqlSessionUtil.getSession();
			return session.selectOne("attendances.selectTotalNonParticipants",scheduleNo);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			if(session!=null) session.close();
			
		}//try~catch~finally end 
		
		return 0;
	}
	
	//송진현
public static List<Attendance> selectList(int no) {
		
		List<Attendance> attendances = null;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			attendances = session.selectList("attendances.selectList",no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) {
				session.close();
			}//if end
		}//try~catch~finally end
		
		return attendances;
	}
	
	public static int update(Attendance attendanceUpdate) {
		int result = 0;
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			result = session.update("attendances.update",attendanceUpdate);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return result;
	}//update() end

	public static int insertList(Attendance attendance) {
		int result = 0;
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			result = session.insert("attendances.insertList",attendance);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return 0;
	}
	//end 송진현
}


