package com.doogwal.coffee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.Gathering;
import com.doogwal.coffee.vo.Meeting;

public class SchedulesDAO {
	//박형우 start -----------------------------------------------------------------------
	//20210114 start
	
	// upcomming event를 가져오는
	public static Gathering selectUpcommingGathring(int no) {
		
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			
			return session.selectOne("schedules.selectUpcommingGathring", no);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return null;
	}
	public static Meeting selectUpcommingMeeting(int no) {
		
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			
			return session.selectOne("schedules.selectUpcommingMeeting", no);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return null;
	}
	//20210114 end

	//20210123 start
	
	//밋팅만들기 하는
	public static int insertMakingMeeting(Meeting meeting) {
		
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			
			return session.insert("schedules.insertMakingMeeting", meeting);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return -1;
	}
	//20210123 end
	//20210130 start
	
	//수락된 스케쥴 수락된 크루에도 넣어주는것
	public static int insertAcceptMeeing(Meeting meeting) {
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
		
			return session.insert("schedules.insertAcceptMeeing", meeting);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}//try~catch~finally end 
		return -1;
	}
	
	//수락된 스케쥴 정보 가져오는
	public static Meeting selectOneScheduleInformation(int no) {
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
		
			return session.selectOne("schedules.selectOneScheduleInformation", no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}//try~catch~finally end 
		return null;
	}
	//20210130 end
	//박형우 end -----------------------------------------------------------------------
	
	//송진현start---------------------------------------------------------------------------
		public static int insert(Gathering schedule) {
			int result = 0;
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
				result = session.insert("schedules.insert",schedule);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			return 0;
		}
		
		public static Gathering selectOne(int no) {
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.selectOne("schedules.selectOne",no);
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				session.close();
			}
			
			return null;
		}
	//송진현end---------------------------------------------------------------------------
		
	//정진하 20210117 2210 메인에서 업커밍 모임 가져오기 위해 작성함
	public static List<Gathering> selectUpcomingGatheringList() {
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectList("schedules.selectUpcomingGatheringList");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}//try~catch~finally end 
		return null;
	}//selectUpcomingGatheringList() end 
	
	//정진하 20210121 1500 일정캘린더에서 일별일정 가져오기 위해 작성함
	public static List<Meeting> selectDailySchedules(Map<String,Object> map) {
	SqlSession session = null;
		try {
				session = SqlSessionUtil.getSession();
				return session.selectList("schedules.selectDailySchedules",map);
	    } catch (Exception e) {
				e.printStackTrace();
		} finally {
				if(session!=null) session.close();
		}//try~catch~finally end 
		return null;
		}//selectDailySchedules() end 
	
		//정진하 20210123 1416 일정캘린더에서 모든일정 가져오기 위해 작성함
		public static List<Meeting> selectAllSchedules(int crewNo) {
			SqlSession session = null;
		try {
				session = SqlSessionUtil.getSession();
				return session.selectList("schedules.selectAllSchedules",crewNo);
	    } catch (Exception e) {
				e.printStackTrace();
		} finally {
				if(session!=null) session.close();
		}//try~catch~finally end 
		return null;
		}//selectAllSchedules() end 

	//정진하 20210121 1500 일정캘린더에서 월간일정 가져오기 위해 작성함
		public static List<Meeting> selectMonthlySchedules(int crewNo) {
			SqlSession session = null;
				try {
						session = SqlSessionUtil.getSession();
						return session.selectList("schedules.selectMonthlySchedules",crewNo);
			    } catch (Exception e) {
						e.printStackTrace();
				} finally {
						if(session!=null) session.close();
				}//try~catch~finally end 
				return null;
		}//selectDailySchedules() end 
		
		
	//정진하 20210124 1127 밋팅메인에서 테마 번호에 따라 밋팅 리스트 가져올기 위해 작성함
		public static List<Meeting> selectMeetingListByThemeNo(int themeNo) {
			SqlSession session = null;
				try {
						session = SqlSessionUtil.getSession();
						return session.selectList("schedules.selectMeetingListByThemeNo",themeNo);
			    } catch (Exception e) {
						e.printStackTrace();
				} finally {
						if(session!=null) session.close();
				}//try~catch~finally end 
				return null;
		}//selectDailySchedules() end
		
	//정진하 20210124 밋팅메인에서 데이트 레인지 픽커에서 날짜 선택한 범위에 맞게 밋팅 리스트 가져오기 위해 작성함
		public static List<Meeting> selectMeetingListByDateRange(Map<String,String> map) {
		SqlSession session = null;
			try {
					session = SqlSessionUtil.getSession();
					return session.selectList("schedules.selectMeetingListByDateRange",map);
		    } catch (Exception e) {
					e.printStackTrace();
			} finally {
					if(session!=null) session.close();
			}//try~catch~finally end 
			return null;
			}//selectDailySchedules() end 
		
	//정진하 20210124 밋팅메인에서 위치 정보 선택한 것에 따라 밋팅 리스트 가져오기 위해 작성함	
	public static List<Meeting> selectMeetingListByUsingLocationInfo(String locationInfo) {
		SqlSession session = null;
			try {
					session = SqlSessionUtil.getSession();
					return session.selectList("schedules.selectMeetingListByUsingLocationInfo",locationInfo);
			   } catch (Exception e) {
					e.printStackTrace();
			} finally {
					if(session!=null) session.close();
			}//try~catch~finally end 
			return null;
			}//selectMeetingListByUsingLocationInfo() end 
		
	//정진하 20210124 밋팅메인 처음 들어갔을 때 오늘 포함 그 후의 밋팅 리스트 가져오기 위해 작성함.	
	public static List<Meeting> selectMeetingListFromToday() {
			SqlSession session = null;
			try {
					session = SqlSessionUtil.getSession();
					return session.selectList("schedules.selectMeetingListFromToday");
				  } catch (Exception e) {
					e.printStackTrace();
			} finally {
					if(session!=null) session.close();
			}//try~catch~finally end 
			return null;
			}//selectMeetingListFromToday() end 
	
	//정진하 20210129 1127 밋팅메인에서 카테고리 상위 번호에 따라 밋팅 리스트 가져올기 위해 작성함
	public static List<Meeting> selectMeetingListByCategoryNo(int categoryNo) {
		SqlSession session = null;
			try {
					session = SqlSessionUtil.getSession();
					return session.selectList("schedules.selectMeetingListByCategoryNo",categoryNo);
		    } catch (Exception e) {
					e.printStackTrace();
			} finally {
					if(session!=null) session.close();
			}//try~catch~finally end 
			return null;
	}//selectDailySchedules() end 
	
	
	
	//정진하 20210129 밋팅메인에서 연령대 선택에 따라 밋팅 목록 가져오기 위해 설정함 
	public static List<Meeting> selectMeetingListByAgeGroup(Map<String,Object> map) {
	SqlSession session = null;
		try {
				session = SqlSessionUtil.getSession();
				return session.selectList("schedules.selectMeetingListByAgeGroup",map);
	    } catch (Exception e) {
				e.printStackTrace();
		} finally {
				if(session!=null) session.close();
		}//try~catch~finally end 
		return null;
		}//selectMeetingListByAgeGroup() end 
	
	//20210124 밋팅히스토리(대결,친목) 카운트 이아림
		public static Map<String, Object> selectHistoryCount(int crewNo) {
			
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
				return session.selectOne("schedules.selectHistoryCount",crewNo);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			return null;
		}
}

