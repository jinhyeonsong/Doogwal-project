package com.doogwal.coffee.dao;

import org.apache.ibatis.session.SqlSession;
import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.Gathering;

public class GatheringsDAO {
	
	public static int insert(Gathering gathering) {
		int result = 0;
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			result = session.insert("gatherings.insert",gathering);
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
			
			return session.selectOne("gatherings.selectOne",no);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return null;
	}
}












