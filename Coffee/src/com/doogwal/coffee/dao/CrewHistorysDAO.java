package com.doogwal.coffee.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.CrewHistory;

public class CrewHistorysDAO {
	public static List<CrewHistory> selectList(int no) {
		
		List<CrewHistory> crewhistorys = null;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			crewhistorys = session.selectList("crewhistorys.selectList",no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) {
				session.close();
			}//if end
		}//try~catch~finally end
		
		return crewhistorys;
	}
}
