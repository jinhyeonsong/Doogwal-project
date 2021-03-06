package com.doogwal.coffee.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.CrewFellowshipManner;
import com.doogwal.coffee.vo.Fellowship;


public class FellowshipsDAO {
	
	public static int insert(Fellowship fellowship) {
		
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.insert("fellowships.insert",fellowship);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return -1;
	}
	
	public static CrewFellowshipManner selectByRateeNo(Map<String, Object> map) {
		
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectOne("fellowships.selectByRateeNo",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return null;
	}
	
	
}
