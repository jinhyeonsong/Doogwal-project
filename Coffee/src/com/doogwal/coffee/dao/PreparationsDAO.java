package com.doogwal.coffee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import com.doogwal.coffee.util.SqlSessionUtil;
import com.doogwal.coffee.vo.Preparation;

public class PreparationsDAO {
	public static int insert(Preparation preparation) {
		int result = 0;
		SqlSession session = null;
		try {
			session = SqlSessionUtil.getSession();
			result = session.insert("preparations.insert",preparation);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return 0;
	}
	
	public static List<Preparation> selectList(int no) {
		
		List<Preparation> preparations = null;
		SqlSession session = null;
		
		try {
			session = SqlSessionUtil.getSession();
			preparations = session.selectList("preparations.selectList",no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null) {
				session.close();
			}//if end
		}//try~catch~finally end
		
		return preparations;
	}

	//박형우 start -----------------------------------------------------------------------
	//20210123 start
	
		//밋팅 준비물 추가하는
		public static int insertMeetingPreparation(Map<String, Object> map) {
			
			SqlSession session = null;
			
			try {
				session = SqlSessionUtil.getSession();
				
				return session.insert("preparations.insertMeetingPreparation", map);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			
			return -1;
		}
	//20210123 end
	//박형우 end -----------------------------------------------------------------------

}


