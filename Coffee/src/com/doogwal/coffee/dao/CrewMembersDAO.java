package com.doogwal.coffee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.Crew;
import com.doogwal.coffee.vo.CrewMember;
import com.doogwal.coffee.vo.FormallyCrewMemberJson;
import com.doogwal.coffee.vo.UserMember;

public class CrewMembersDAO {
	/*
		2021 01 11 주성호 start
		header.jsp 크루 이미지
	*/
	//정진하 주성호 0112 09:02
	//myPage.jsp에서 해당 유저가 속한 크루명 및 프로필 사진을 가져오기 위함
	public static List<CrewMember> selectOwnList(int userNo) {
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectList("crewMembers.selectOwnList",userNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}//try~catch~finally end 
		return null;
	}
	/*
		2021 01 11 주성호 end
		header.jsp 크루 이미지
	 */
	
	/*
	2021 01 14 주성호 start
 	크루 생성시 크루장 입력
	 */
	
	public static int insertCrewMember(CrewMember crewMember) {
		int cnt = 0;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			cnt = session.insert("crewMembers.insertCrewMemberByCaptin",crewMember);
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return cnt;
	}
	/*
	2021 01 14 주성호 end
 	크루 생성시 크루장 입력
	 */
	//주성호 2021116 
	//crewDetail crweMember 불러오기
	public static UserMember selectCrewMemberOneByNo(int memberNo) {
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectOne("crewMembers.selectCrewMemberOneByNo",memberNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) session.close();
		}//try~catch~finally end 
		return null;
	}
	/*
		2021 01 11 주성호 end
		header.jsp 크루 이미지
	 */
	
	// 2021 02 04 크루 report num 변경
	public static int updateReportCrewMember(int no) {
		int cnt = 0;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			cnt = session.update("crewMembers.updateReportCrewMember",no);
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		
		return cnt;
	}
	
	//-------------------------------------------------------------
	//박형우 start -----------------------------------------------------------------------
	//20210114 start
	//가입 대기자들의 이미지를 가져오기 위한 
		public static List<String> selectWatingCrewMemberImgs(int no) {
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
				return session.selectList("crewMembers.selectWatingCrewMemberImgs", no);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}//try~catch~finally end 
			return null;
		}
	//20210114 end
	//20210119 start
		
		//크루 정식 인원들 받아오는
		public static List<FormallyCrewMemberJson> selectFormallyCrewMemberList(int crewNo) {
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
				return session.selectList("crewMembers.selectFormallyCrewMemberList", crewNo);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}//try~catch~finally end 
			return null;
		}
			
		//20210119 end
		//20210124 start
		
		//크루멤버 일반회원->운영진으로
		public static int transformRankToOperator(int crewMemberNo) {
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
				return session.update("crewMembers.transformRankToOperator", crewMemberNo);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}//try~catch~finally end 
			return -1;
		}
		
		//크루멤버 운영진->일반회원으로
		public static int transformRankToMember(int crewMemberNo) {
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
				return session.update("crewMembers.transformRankToMember", crewMemberNo);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}//try~catch~finally end 
			return -1;
		}
		
		//20210124 end
		//20210125 start
		
		//크루멤버 탈퇴시키기
		public static CrewMember selectCrewMemberForKick(int crewMemberNo) {
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
				return session.selectOne("crewMembers.selectCrewMemberForKick", crewMemberNo);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}//try~catch~finally end 
			return null;
		}

		//20210125 end
		
		//크루 정식 멤버로 받아주는
		public static int updateRegularMember(Map<String, Integer> map) {
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
			
				return session.update("crewMembers.updateRegularMember", map);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}//try~catch~finally end 
			return 0;
		}

		//크루 가입신청을 거절하는
		public static int deleteKickMember(Map<String, Integer> map) {
			SqlSession session = null;
			try {
				session = SqlSessionUtil.getSession();
			
				return session.delete("crewMembers.deleteKickMember", map);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}//try~catch~finally end 
			return 0;
		}

	//박형우 end -----------------------------------------------------------------------
		
	//2021 01 13 정진하 마이페이지 사진 업데이트를 위해 추가함
	public static int updateProfileImage(CrewMember crewMember) {
		int result = 0;
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			result = session.update("crewMembers.updateProfileImage",crewMember);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}//try~catch~finally end
		return result;
	}//update() end

	//송진현
	public static List<CrewMember> selectList(int no) {
		
		List<CrewMember> crewmembers  = null;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			crewmembers = session.selectList("crewMembers.selectList",no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) {
				session.close();
			}//if end
		}//try~catch~finally end
		
		return crewmembers ;
	}
	//end 송진현

	
	
}
