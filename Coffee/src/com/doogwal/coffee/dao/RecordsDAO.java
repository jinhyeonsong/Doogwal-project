package com.doogwal.coffee.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.MatchRecord;
import com.doogwal.coffee.vo.Record;

public class RecordsDAO {

	public static MatchRecord selectMatchRecord(int crewNo) {
		
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.selectOne("records.selectMatchRecord",crewNo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return null;
	}
	
	public static int update(Map<String,Object> map) {
		
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			return session.update("records.update",map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return -1;
	}
	
	//박형우 start -----------------------------------------------------------------------
	//20210130 start
		
	//레코드 생성하는
	public static int insertRecord(Record record) {
		
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			
			return session.insert("records.insertRecord", record);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return -1;
	}
	
	//20210130 end
	//박형우 end -----------------------------------------------------------------------
}
